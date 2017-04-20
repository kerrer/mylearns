#!/usr/bin/perl -w

use CGI::Carp qw(fatalsToBrowser);
use CGI;
use JSON;
use DBI;
use Cache::SharedMemoryCache;

$query = new CGI;  
print $query->header('application/json');

$token = $query->param("token");
$username= $query->param("username");
$password = $query->param("password");

die();
$dbh_speed = DBI->connect('DBI:mysql:speedtrade;host=192.168.1.145','root','123456',{
	        PrintError => 1,
	        RaiseError => 1
	     }) or die "can not connect to db: $DBI::errstr";                                                    
$dbh_speed->do("SET NAMES utf8");


$sql = "SELECT * FROM t_application LIMIT 10";
$sth_speed = $dbh_speed->prepare($sql) or die $dbh_speed->errstr;
$sth_speed->execute();
while(my $row = $sth_speed->fetchrow_hashref()){
	print $row->{t_application_id}, "\n";
}
$dbh_speed->disconnect or warn " eror disconnecting: $DBI::errstr\n"; 

sub authorize_api_user(

)

sub validate_user_token(){
	
}

sub get_user_token(){
	
}
