#!/usr/bin/python

import sys,os,MySQLdb,urllib,urllib2,stat

flag = "ZH"
image_root= "/images/"
zh_images_host = "http://images.speed-trade.com"
rpc_items_uri = "http://ca.max.com/images/setSyncJp/.json"
rpc_file_uri = "http://ca.max.com/files/setSyncJp/.json"
DB_HOST= "localhost"
DB_USER= "caimgpd"
DB_PASSWORD= "huy72sH&sh"
DB_NAME="speedImages"
nums_per_check=100
security_salt = "7cc2a91bb73fe81a018fc13469d03a2b"

SELECT_IMAGES_QUERY="select * from Item_Images where imgz_s=0 and imgj_s=1 and status = 1 limit %d"
UPDATE_IMAGE_QUERY="UPDATE Item_Images SET imgz_s = 1 WHERE id = %d"
SELECT_FILES_QUERY="select * from Files where  status = 1 and imgz_s=0 and imgj_s=1  limit %d"
UPDATE_FILE_QUERY="UPDATE Files SET imgz_s = 1 WHERE id = %d"

def download_image(uri):
   global image_root
   global zh_images_host 
   
   url= zh_images_host + uri

   file_path =  os.path.dirname(uri)
   file_name = os.path.basename(uri)
   dest_path = os.path.join(image_root , file_path.lstrip("/"))
   dest_file = os.path.join(image_root , uri.lstrip("/"))   

   try:
     if os.path.exists(dest_file):
	    os.remove(dest_file)
	     
     if( not os.path.isdir(dest_path)):
	    os.makedirs(dest_path)
	    os.chown(dest_path,101,4084)
	    os.chmod(dest_path,0770)	
	        	   
     req = urllib2.Request(url)
     response = urllib2.urlopen(req)
     data = response.read()   

     with open(dest_file,'wb') as f:
	    f.write(data)
	    os.chown(dest_file,101,4084)
	    os.chmod(dest_file,0770)
   except Exception as e:
	   print("error download: ", e)
	   return 0
		
   return 1
   

def set_image_stats(id):
   global rpc_items_uri,security_salt
   values = {'id' : id,'ms': security_salt}
   data = urllib.urlencode(values)
   req = urllib2.Request(rpc_items_uri,data)  
   response = urllib2.urlopen(req)
   print(response.read())
   
def set_file_stats(id):
   global rpc_file_uri,security_salt
   values = {'id' : id,'ms': security_salt}
   try:
      data = urllib.urlencode(values)
      req = urllib2.Request(rpc_file_uri,data)  
      response = urllib2.urlopen(req)     
   except Exception as e:
	  print("errors: ",e.code)
	   
   

def init_db():
   global db,DB_HOST,DB_USER,DB_PASSWORD,DB_NAME
   try:
	  db = MySQLdb.connect(host=DB_HOST,user=DB_USER,passwd=DB_PASSWORD,db=DB_NAME,unix_socket='/var/lib/mysql-img/mysql.sock')
      #db = MySQLdb.connect(host=DB_HOST,user=DB_USER,passwd=DB_PASSWORD,db=DB_NAME)
   except Exception:
      print("cannot connect db")

def close_db():
	global db
	db.close()
	
def sync_item_images():
   global db,nums_per_check,flag,SELECT_IMAGES_QUERY,UPDATE_IMAGE_QUERY
   cursor = db.cursor()
   sql = SELECT_IMAGES_QUERY % (nums_per_check)
   try:	
	  cursor.execute(sql)
	  results = cursor.fetchall()
	  for row in results:
		 if download_image(row[2]):		
			    sql_up = UPDATE_IMAGE_QUERY % (row[0])
			    cursor.execute(sql_up)			
			    print("image: ", row[0])
   except Exception as e:
	  print("error: ", e)	
	  
def sync_files():
   global db,nums_per_check,flag,SELECT_FILES_QUERY,UPDATE_FILE_QUERY
   cursor = db.cursor()
   sql = SELECT_FILES_QUERY % (nums_per_check)
   try:	
	  cursor.execute(sql)
	  results = cursor.fetchall()
	  for row in results:
		 if download_image(row[2]):			  
			    sql_up = UPDATE_FILE_QUERY % (row[0])
			    cursor.execute(sql_up)
			    print("file: ", row[0])
				
   except Exception as e:
	  print("error: ", e)	
   
print(" ")
init_db()
sync_item_images()
sync_files()
close_db()

