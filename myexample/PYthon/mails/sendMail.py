#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
 usage: python myp.py > out.txt 2>&1 &
'''

import MySQLdb as mdb
import sys
import mailLib as spMail
import time

_mode = "dev"
_interval = 60

def getEmail(*emails):
	maker_email = ""
	for e in emails:
		if  e:
			maker_email=e
			break
			
	return maker_email

def getName(*names):
	maker_name = ""
	for n in names:
		if  n:
			maker_name = n
			break
	
	return maker_name
	
def getSqlStr(mode):
	_sqlstr_dev="""
	SELECT m_maker_daihyo_ch,m_maker_sekininsha_ch,m_maker_bank_meigi,m_maker_account,
	m_maker_sekininsha_email,m_maker_sekininsha_email_support,m_maker_sekininsha_email_shopping
	from m_maker where m_maker_void_flag  =0 and m_maker_close_flag=0   
	limit 1
	"""
	_sqlstr_prod = """
	SELECT m_maker_daihyo_ch,m_maker_sekininsha_ch,m_maker_bank_meigi,m_maker_account,
	m_maker_sekininsha_email,m_maker_sekininsha_email_support,m_maker_sekininsha_email_shopping
	from m_maker WHERE `m_maker_void_flag` = 0 AND `m_maker_close_flag` = 0 
	"""
	
	if mode == "dev":
		return _sqlstr_dev
	elif mode == "prod":
		return _sqlstr_prod
		
def getConnect(mode):
	if mode == "dev":
		return mdb.connect('192.168.1.145', 'root', '123456', 'speedtrade')
	elif mode == "prod":
		return mdb.connect('localhost', 'speedtrade', 'husy$sH8&sy', 'speedTrade')
	
con = None
try:
    con = getConnect(_mode)

    cur = con.cursor()
    cur.execute("SET NAMES utf8")
    cur.execute(getSqlStr(_mode))
    
    rows = cur.fetchall()
    for ver in rows:    
		name = getName(ver[0],ver[1],ver[2],ver[3])
		#email = getEmail(ver[4],ver[5],ver[6])
		email = "kerrer@126.com"
		try:
			spMail.sendmailToMaker(name,email)
			
		except Exception as  err:
			print "not send : %s [err: %s]" % (email,str(err))
		else:
			print "send to email: %s " % email
			
		sys.stdout.flush()
		time.sleep(_interval)
		ver = cur.fetchone()
    
except mdb.Error, e:
	print "Error %d: %s" % (e.args[0],e.args[1])
	sys.exit(1)
finally:
	if con:    
		con.close()



