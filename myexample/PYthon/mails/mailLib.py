#!/usr/bin/python
# -*- coding: utf-8 -*-

import smtplib
from email.MIMEBase import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.application import MIMEApplication
from email import Encoders
from string import Template

_from = "no-reply@speed-trade.com.cn"
_email_tmp = "temp2.html"
_to = ""
_html = ""
_subject= "SPEED-TRADE 通知"

def loadEmailTmp(temp_file):
	global _html
	if(not _html):
		fd = open(temp_file,"r")
		_html = fd.read()

def sendmailToMaker(maker_name,maker_email):
    global _from,_email_tmp,_to,_html,_subject
    #print maker_name
    _to = maker_email
    
    loadEmailTmp(_email_tmp)
    _msg = MIMEMultipart('alternative')
    #_msg.add_header('Content-Disposition', 'attachment', filename='回执单.xlsx')
    _msg['Subject'] = _subject
    _msg['From'] = _from
    _msg['to'] = maker_email
    
    d=dict(name = maker_name)
    part = MIMEText(Template(_html).substitute(d), 'html', 'utf-8')
    _msg.attach(part)
    
    '''
    attach_img = MIMEImage(file("部分参展商户.jpg").read())
    attach_img.add_header('Content-Disposition', 'attachment', filename=('utf-8', '', '部分参展商户.jpg'))
    _msg.attach(attach_img)
    
    attachFile = MIMEApplication('application', 'application/vnd.ms-excel')
    attachFile.set_payload(file("回执单.xlsx").read())
    Encoders.encode_base64(attachFile)
    attachFile.add_header('Content-Disposition', 'attachment', filename=('utf-8', '', '回执单.xlsx'))
    _msg.attach(attachFile)
	'''	
  
    #s = smtplib.SMTP('localhost')
    mailserver = smtplib.SMTP_SSL('smtp.exmail.qq.com',465) 
    mailserver.ehlo()
    mailserver.ehlo()
    mailserver.login('no-reply@speed-trade.com.cn', 'speedtrade2014')
    
    mailserver.sendmail(_from, _to, _msg.as_string())
    mailserver.quit()


