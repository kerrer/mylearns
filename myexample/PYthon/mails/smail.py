#!/usr/bin/python
# -*- coding: utf-8 -*-
import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText

msg = MIMEMultipart()
msg['From'] = 'no-reply@speed-trade.com.cn'
msg['To'] = 'kerrer@126.com'
msg['Subject'] = 'simple email in python'
message = '岁的发馊豆腐，岁的发，喔喔司法四方的阿'
msg.attach(MIMEText(message))

try:
  mailserver = smtplib.SMTP_SSL('smtp.exmail.qq.com',465)
  # identify ourselves to smtp gmail client
  mailserver.ehlo()
  # secure our email with tls encryption
  #mailserver.starttls()
  # re-identify ourselves as an encrypted connection
  mailserver.ehlo()
  mailserver.login('no-reply@speed-trade.com.cn', 'speedtrade2014')

  mailserver.sendmail('no-reply@speed-trade.com.cn','kerrer@126.com',msg.as_string())

  mailserver.quit()
except smtplib.SMTPException  as err:
    print "send mail error " + str(err)
