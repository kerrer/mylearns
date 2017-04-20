#!/usr/bin/perl -w
  
  use CGI::Carp qw(fatalsToBrowser);
  use CGI;
  use File::Basename;
  use File::Path qw(make_path remove_tree);
  use JSON;
  use DBI;


  $query = new CGI;  
  print $query->header('application/json');   
  
  my $upload_root = "/images/";
  my $url_root = "/";
  
  my %res ={};
  
  $CGI::POST_MAX = 1024 * 1030;  
  my @cgi_allow_img_type= qw#image/jpeg image/png image/jeg image/gif image/bmp #;
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =  localtime(time); 
  
  if($query->param("mode") ne 'product'){
	  $upload_root = $upload_root . "test/";
	  $url_root = $url_root . "test/";
  }
   
   
  
  $filename = $query->param("photo"); 
  
  if(!$filename && $query->cgi_error){	  
	 $res = {err=>1,msg=>"There was a problem uploading your photo: " . $query->cgi_error};
	 print to_json($res);
     exit 0;  
  }
  
  $type = $query->uploadInfo($filename)->{'Content-Type'}; 
  if(!isExist($type,\@cgi_allow_img_type)){
	  $res = {err=>1,msg=>"Unsupport file type: $type"};
	 print to_json($res);
     exit 0;  
   }
  
  my $tmpfile = $query->tmpFileName($filename);
  my $file_size = (-s $tmpfile);
  
  
  my $dir_cat;  
  my $dir_sub_cat = getFileDir("$filename$file_size");
  
  if($query->param("dirname")){
	 $dir_cat = $query->param("dirname") . "/" ;  
  }else{
	 $dir_cat = "";
  }
  my $upload_dir = $upload_root . $dir_cat . $dir_sub_cat ;
  my $url_dir = $url_root . $dir_cat . $dir_sub_cat;
  
  if(!-d $upload_dir){
	  make_path($upload_dir,{mode=>0775,group => 'speedshad',error => \my $err});
	  if(@$err){
		   $res = {err=>1,msg=>"mkdir $upload_dir error: @$err"};
		   print to_json($res);
		   exit 0;  
	  }
  } 
  
  my ($name,$path,$extension) = fileparse($filename,qr/\.[^.]*/);  
  
  $newName = sprintf("%d%d%d%d%d%d%d%s",$year,$mon,$mday,$hour,$min,$sec,int(rand(1000)),$extension);
 
  $upload_filehandle = $query->upload("photo");

  open UPLOADFILE, ">$upload_dir$newName";
  binmode UPLOADFILE;

  while ( <$upload_filehandle> )
  {
    print UPLOADFILE;
  }
  close UPLOADFILE;
  chown(-1,4084,"$upload_dir$newName");
 chmod(0775,"$upload_dir$newName");
 if( ($query->param("mode") && $query->param("mode") eq 'product') && ($query->param("cat")) ){
  if($query->param("cat") eq 'item'){
	  my %pams= (
		     maker_id => $query->param("maker_id"),
		     item_id => $query->param("item_id"),
		     size => $file_size,
		     type => $type,
		     uri => "$url_dir$newName",
		     fold_id => $query->param("fold_id")		    
		  );
      saveToImages(\%pams);
  }else{
	  my %pams= (
		     cat_name => $query->param("cat"),		     
		     size => $file_size,
		     type => $type,
		     uri => "$url_dir$newName"	     	    
		  );
      saveToFiles(\%pams);
  }
}
  $res = {err=>0,uri=>"$url_dir$newName",size=>$file_size,type=>$type};  
  print to_json($res);
  exit;
  
  sub isExist($$){
	  my ($val, $arr) = @_;
	  my $ele;
	  for $ele (@{$arr}){
		  if($ele eq $val){
			return 1;  
		  }
	  }  
	  return 0;
  }
  
  sub saveToImages($){
	my $img_attr = shift @_;
	my($maker_id, $item_id, $size,$uri,$type,$fold_id) = ($img_attr->{maker_id},
	                                                      $img_attr->{item_id},
	                                                      $img_attr->{size},
	                                                      $img_attr->{uri},
	                                                      $img_attr->{type},
	                                                      $img_attr->{fold_id});
	$dbh = DBI->connect('DBI:mysql:speedImages;host=localhost;mysql_socket=/var/lib/mysql-img/mysql.sock','caimgpd','huy72sH&sh',{
	        PrintError => 1,
	        RaiseError => 1
	     }) or die "can not connect to db: $DBI::errstr";                                                    
	$dbh->do("SET NAMES utf8");
	$dbh->do("INSERT INTO Item_Images SET maker_id=$maker_id, item_id=$item_id,size=$size, uri='$uri', type='$type', fold_id=$fold_id,created=now(),modified=now(),imgz_s=1,imgj_s=0,status=1"); 
	$dbh->disconnect or warn " eror disconnecting: $DBI::errstr\n"; 
	return 1;                                           
  }
  
sub saveToFiles($){
	my $img_attr = shift @_;
	my($cat_name,$size,$uri,$type,$fold_id) = ($img_attr->{cat_name},	                                                      
	                                                      $img_attr->{size},
	                                                      $img_attr->{uri},
	                                                      $img_attr->{type},
	                                                      $img_attr->{fold_id});
	$dbh = DBI->connect('DBI:mysql:speedImages;host=localhost;mysql_socket=/var/lib/mysql-img/mysql.sock','caimgpd','huy72sH&sh',{
	        PrintError => 1,
	        RaiseError => 1
	     }) or die "can not connect to db: $DBI::errstr";                                                    
	$dbh->do("SET NAMES utf8");
	$dbh->do("INSERT INTO Files SET cat_name='$cat_name',size=$size, uri='$uri', type='$type', created=now(),modified=now(),imgz_s=1,imgj_s=0,status=1"); 
	$dbh->disconnect or warn " eror disconnecting: $DBI::errstr\n"; 
	return 1;                                           
  }
  
sub getFileDir($)
{
   my $fileName = shift;
   my $code = hashCode($fileName); 
   my $dir = sprintf("%02x",($code & 255)).'/'.sprintf("%02x",($code >> 8 & 255)).'/';
   return $dir;
}
    
sub hashCode($) {
  my $hash = 0;
  use integer;
  foreach(split //,shift) {
   $hash = 31*$hash+ord($_);
  }
  return $hash;
}
