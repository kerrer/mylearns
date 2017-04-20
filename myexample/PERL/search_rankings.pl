#!/usr/bin/perl

use strict;

use Thread qw(cond_wait cond_signal);
use threads;
use threads::shared;
use List::Util qw(max);
use DBI;
use Time::Local;
use POSIX qw/strftime/;

my @rows  :shared  =();
my $num :shared =0;
my %integral_spdj :shared;
my %integral_spxl :shared;
my %integral_xjcp :shared;
my %integral_xinsj :shared;
my %integral_cpwz :shared;
my %integral_dppf :shared =0;
my %integral_jfpf :shared;
my %integral_chpf :shared;
my %integral_cpsjl :shared;
my %integral_dpscl :shared; 
my %integral_zhl :shared;
my %integral_dljl :shared;


sub dljl_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	print "start dljl_intact($tid)....\n";
	my ($intact) =@_;
	my %arr = ();
	my %scores= ();
    my $dbh=&getDbHandler();
	my $q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
    my $sth = $dbh->prepare($q);
    $sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
        my $q_1 = " SELECT count(*) sum
				FROM m_sp_coin_income
				where m_sp_coin_income_type='6' and m_sp_coin_income_m_maker_id = '$res->{m_item_m_maker_id}' ";
		my $v_1 = $dbh->prepare($q_1);
		$v_1->execute();
		my $val_1 =$v_1->fetchrow_hashref();
		$arr{$res->{m_item_id}} = $val_1->{sum};
	}
    my $maxvalue=max(values(%arr));
	while( my ($key,$value) = each(%arr)){	
			if ($maxvalue!=0){
				$scores{$key} = $value/$maxvalue*$intact;
			}else {
				$scores{$key} = 0;
			}
	}	
   %integral_dljl=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
   print "dljl_intact() has over.";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}

sub zhl_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	print "start zhl_intact($tid)....\n";
	my ($intact) =@_;
	my %arr = ();
	my %scores= ();
     my $dbh=&getDbHandler();
	my $q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
	my $sth= $dbh->prepare($q);
	$sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
		my $q_1 = "  select t_ranking.t_ranking_number
					from 
					t_ranking 
					LEFT JOIN m_item 
					ON 
					m_item.m_item_id = t_ranking.t_ranking_m_item_id  
					LEFT JOIN m_maker 
					ON 
					m_item.m_item_m_maker_id = m_maker.m_maker_id 
					where 1 
					and t_ranking.t_ranking_type = 'all_everyday' 
					and m_maker.m_maker_void_flag = '0' 
					and t_ranking_m_item_id = '$res->{m_item_id}' order by t_ranking.t_ranking_number desc limit 1 
					";
		my $v_1 = $dbh->prepare($q_1);
		$v_1->execute();
		my $val_1 = $v_1->fetchrow_hashref();

         #订单总数 
		my $q_2 = "SELECT count(DISTINCT(t_juchu_id)) as ddsum FROM t_juchu INNER JOIN t_juchuitem ON t_juchu.t_juchu_id = t_juchuitem.t_juchuitem_t_juchu_id 
		           left join t_zaikoitem on t_zaikoitem.t_zaikoitem_id = t_juchuitem.t_juchuitem_id where 1
					and t_zaikoitem.t_zaikoitem_id is not null 
					and t_juchuitem_maker_deliverydate <> '0000-00-00 00:00:00' 
					and t_juchu_nyukin_datetime <> '0000-00-00 00:00:00' 
					and t_juchu.t_juchu_void_flag = '0' 
					and t_juchu.t_juchu_id = '$res->{m_item_id}' ";
		my $v_2 = $dbh->prepare($q_2);
		$v_2->execute();
		my $val_2 = $v_2->fetchrow_hashref();
				
		my $rank_number = ($val_1->{t_ranking_number})?$val_1->{t_ranking_number}:0;
			if ($rank_number!=0){
				$scores{$res->{m_item_id}} = $val_2->{ddsum}/$val_1->{t_ranking_number}*$intact;
			}else {
				$scores{$res->{m_item_id}}  = 0;
			}
		}
	%integral_zhl=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
   print "zhl_intact() has over";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}

sub dpscl_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	print "start dpscl_intact($tid)....\n";
	my ($intact) =@_;
	my %arr = ();
	my %scores= ();
	 my $dbh=&getDbHandler();
	my 	$q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
	my $sth = $dbh->prepare($q);
    $sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
			#收藏 数
	  my $q_1 = "SELECT count(*) sum
				FROM t_customer_brand 
				where t_customer_brand_m_brand_id = '$res->{m_item_m_maker_id}' ";
	  my $v_1 = $dbh->prepare($q_1);
	  $v_1->execute();
      my $val_1 = $v_1->fetchrow_hashref();
      $arr{$res->{m_item_id}} = $val_1->{sum};
	}
    my $maxvalue=max(values(%arr));
	while( my ($key,$value) = each(%arr)){	
			if ($maxvalue!=0){
				$scores{$key} = $value/$maxvalue*$intact;
			}else {
				$scores{$key} = 0;
			}
	}

	%integral_dpscl=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
   print "dpscl_intact() has over";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
sub cpsjl_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	print "start cpsjl_intact($tid)....\n";
	my ($intact) =@_;
	my %arr = ();
	my %scores= ();
     my $dbh=&getDbHandler();
	my $q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
	my $sth = $dbh->prepare($q);
    $sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
       #上架数量
	   my $q_1 = " SELECT count(*) as sum
					FROM m_item
					WHERE m_item.m_item_void_flag =0
					 AND m_item.m_item_m_maker_id = '$res->{m_item_m_maker_id}'
					 AND m_item.m_item_delete_flag =0 ";
	   my $v_1 = $dbh->prepare($q_1);
	   $v_1->execute();
	   my $val_1 = $v_1->fetchrow_hashref();
       $arr{$res->{m_item_id}} = $val_1->{sum};
	}
    my $maxvalue=max(values(%arr));
	while( my ($key,$value) = each(%arr)){	
			if ($maxvalue!=0){
				$scores{$key} = $value/$maxvalue*$intact;
			}else {
				$scores{$key} = 0;
			}
	}

	%integral_cpsjl=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
   print "cpsjl_intact() has over";
   $dbh->disconnect();
    my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
	
sub jfpf_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	print "start jfpf_intact($tid)....\n";
    my ($intact) =@_;
	my %scores= ();
	 my $dbh=&getDbHandler();
    my $q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
	my $sth=$dbh->prepare($q);
	$sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
			#订单总数 
	  my $q_1 = "SELECT count(DISTINCT(t_juchu_id)) as sum
					FROM t_juchu 
					INNER JOIN t_juchuitem 
					ON t_juchu.t_juchu_id = t_juchuitem.t_juchuitem_t_juchu_id  
					where 1 and t_juchuitem.t_juchuitem_m_maker_id = '$res->{m_item_m_maker_id}' ";
	  my $v_1 = $dbh->prepare($q_1);
	  $v_1->execute();
	  my $val_1 = $v_1->fetchrow_hashref();

			#纠纷数
	  my $q_2 = "select count(*) as sum
						from t_juchu 
						inner join t_mediate 
						on t_juchu.t_juchu_id = t_mediate.t_mediate_t_juchu_id 
						and t_mediate.t_mediate_from = '1' 
						where 1 
						and t_mediate.t_mediate_m_maker_id = '$res->{m_item_m_maker_id}' 
						group by t_juchu.t_juchu_id ";
	  my $v_2 = $dbh->prepare($q_2);
	  $v_2->execute();
	  my $val_2 = $v_2->fetchrow_hashref();

	  if ($val_1->{sum}!=0){
				$scores{$res->{m_item_id}} = ($val_1->{sum}-$val_2->{sum})/$val_1->{sum}*$intact; #$_s_arr[7]
	  }else {
				$scores{$res->{m_item_id}} = 0;
	  }
    }

	%integral_jfpf=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
    print "jfpf_intact() has over";
   $dbh->disconnect();
    my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
 
 sub chpf_intact{
	 my $startTime=time();
	 my $tid=threads->self->tid;
	 print "start chpf_intact($tid)....\n";
	my ($intact) =@_;
	my %scores= ();
	 my $dbh=&getDbHandler();
	my $q = " select m_item_id,m_item_m_maker_id from m_item
				where  m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				";
	my $sth=$dbh->prepare($q);
    $sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
		my $q_1 = "SELECT
					t_juchu.t_juchu_id , 
					t_juchu.t_juchu_datetime, 
					t_juchuitem.t_juchuitem_m_maker_id,
					t_juchuitem.t_juchuitem_t_delivery_company_id, 
					t_juchuitem.t_juchuitem_warehousenum,
					t_juchuitem.t_juchuitem_maker_deliverydate, 
					t_juchu.t_juchu_t_juchuitem_collection_limit,
					t_juchuitem.t_juchuitem_quantity, 
					t_zaikoitem.t_zaikoitem_quantity,
					DATEDIFF(t_juchuitem.t_juchuitem_maker_deliverydate,t_juchu.t_juchu_datetime) AS interval_s
					FROM 
					t_juchu INNER JOIN 
					t_juchuitem ON t_juchu.t_juchu_id = t_juchuitem.t_juchuitem_t_juchu_id left join 
					t_zaikoitem on t_zaikoitem.t_zaikoitem_id = t_juchuitem.t_juchuitem_id where 1 
					and t_juchu_nyukin_datetime <> '0000-00-00 00:00:00' 
					and t_juchu.t_juchu_id = '$res->{m_item_id}'
					";
				
		   my $sth_1=$dbh->prepare($q_1);
		   my $interval_s = 0;
		   my $zaiku_s = 0;
		   my $juchu_s = 0;
		   my $i = 0;
		   my $y = 0;
		   $sth_1->execute();
		   while(my $res_1=$sth_1->fetchrow_hashref()){				
				if ($res_1->{t_zaikoitem_id} && $res_1->{t_juchuitem_maker_deliverydate} != '0000-00-00 00:00:00' && $res_1->{t_juchu_void_flag}=='0' ){
					$i++;
					
					$interval_s += $res_1->{interval_s};						
					$zaiku_s += $res_1->{t_zaikoitem_quantity};
					$juchu_s += $res_1->{t_juchuitem_quantity};
				}

				#已过期
				my $sm=$res_1->{t_juchu_t_juchuitem_collection_limit}=='0000-00-00 00:00:00'?'1970-01-01 00:00:00':$res_1->{t_juchu_t_juchuitem_collection_limit};
                my($year,$month,$day,$hour,$min,$sec)=$sm=~/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;                
                my $collection_limit=timelocal($sec,$min,$hour,$day,$month-1,$year);
                my $curTime=time();                
				if ($collection_limit <$curTime && $res_1->{t_juchuitem_maker_deliverydate}== '0000-00-00 00:00:00'){
					$y++;
					$zaiku_s += $res_1->{t_zaikoitem_quantity};#实际发货
					$juchu_s += $res_1->{t_juchuitem_quantity};#订单数量
				}
			}

			if ($i!=0 || $y!=0){
				if ($i!=0){
					my $s = $interval_s/$i;#平均
					my $k_1 = 1/(1+$s);    #1/(1+订单仓库收件时间-订单下单付款时间)*100
						
					my $k_2 = $zaiku_s/$juchu_s;  #该商品实际出货总数/该商品有效订单货物总数*100 
					$scores{$res->{m_item_id}} = ($k_1+$k_2)/2*$intact;
				}elsif ($i==0){
					my $k_2 = $zaiku_s/$juchu_s;
					$scores{$res->{m_item_id}}= $k_2*$intact;
				}

			}else {
				#出货日 m_maker_delivery_date 
				my $q_k = "SELECT m_maker_delivery_date FROM m_maker where m_maker_id ='$res->{m_item_m_maker_id}' ";
				my $sth_k = $dbh->prepare($q_k);
				$sth_k->execute();
				my $val_k = $sth_k->fetchrow_hashref();
				if ($val_k->{m_maker_delivery_date}!=0){
					$scores{$res->{m_item_id}} = 1/$val_k->{m_maker_delivery_date}*$intact;
				}else {
					$scores{$res->{m_item_id}} = 0;
				}
			}
		}
	%integral_chpf=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
   print "chpf_intact() has over";
   $dbh->disconnect();
    my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
	
sub cpwz_intact{
	 my $startTime=time();
	  my $tid=threads->self->tid;
	 print "start cpwz_intact($tid)....\n";
    my ($intact) =@_;
	my %scores= ();
	my $dbh=&getDbHandler();
    my $q = " select it.m_item_id,itch.m_item_ch_name,itch.m_item_ch_description,it.m_item_spec,it.m_item_ingredient,itch.m_item_ch_spec,
				 itch.m_item_ch_ingredient,itch.m_item_ch_code,it.m_item_m_image_id,itch.m_item_ch_t_application_id,
				 itch.m_item_ch_property,itch.m_item_ch_code,it.m_item_min_price,it.m_item_ruser,it.m_item_uuser
from m_item it  
left join m_item_ch itch on itch.m_item_ch_id  =it.m_item_id
where  it.m_item_void_flag =0 AND it.m_item_delete_flag =0 
				";
	my $sth = $dbh->prepare($q);
	$sth->execute();

	while(my $res=$sth->fetchrow_hashref()){
			my $itScore = 0;
			++$itScore if ($res->{m_item_ch_name}); 
			++$itScore if ($res->{m_item_ch_description});
			++$itScore if ($res->{m_item_spec});
			++$itScore if ($res->{m_item_ingredient});
			++$itScore if ($res->{m_item_ch_spec});
			++$itScore if ($res->{m_item_ch_ingredient});
			++$itScore if ($res->{m_item_ch_code});
			++$itScore if ($res->{m_item_m_image_id} != 0);
			++$itScore if ($res->{m_item_ch_t_application_id} != 0) ;
			++$itScore if ($res->{m_item_ch_property});
			++$itScore if ($res->{m_item_ch_code}); 
		
			++$itScore if ($res->{m_item_min_price} != 0) ; 
			++$itScore if ($res->{m_item_ruser} != 0); 
			++$itScore if ($res->{m_item_uuser} != 0); 
           
			$scores{$res->{m_item_id}} = $itScore/14*$intact;
			
	}
		 
	%integral_cpwz=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
    print "cpwz_intact() has over";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}

 sub xinsj_intact($intact){
	my $startTime=time();
	 my $tid=threads->self->tid;
	print "start xinsj_intact($tid)....\n";
	my ($intact) =@_;
	my %scores= ();
	my $dbh=&getDbHandler();
    my $q = "SELECT m_item.m_item_id,m_maker.m_maker_regist_date,DATEDIFF(NOW(),m_maker.m_maker_regist_date) AS REGDAYS FROM 
				m_item left join 
				m_maker on m_item.m_item_m_maker_id = m_maker.m_maker_id 
				where m_item.m_item_void_flag =0
				AND m_item.m_item_delete_flag =0 
				 ";
	my $sth = $dbh->prepare($q);
	$sth->execute();
	while(my $res=$sth->fetchrow_hashref()){
		$scores{$res->{m_item_id}} = 1/(1+$res->{REGDAYS})*$intact;
    }    
    %integral_xinsj=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
    print "xinsj_intact() has over";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
		
 sub xjcp_intact{
	 my $startTime=time();	 
	  my $tid=threads->self->tid;
	print "start xjcp_intact($tid)....\n";
	my ($intact) =@_;
	my %arr = ();
	my %scores= ();
     my $dbh=&getDbHandler();
	my $q = "select m_item_id,m_item_udatetime,".
    "(UNIX_TIMESTAMP(date_add(m_item_udatetime,interval 1 MONTH))-UNIX_TIMESTAMP())/(UNIX_TIMESTAMP(date_add(m_item_udatetime,interval 1 MONTH))-UNIX_TIMESTAMP(m_item_udatetimE)) AS ONE, ".
    "(UNIX_TIMESTAMP(date_add(m_item_udatetime,interval 2 MONTH))-UNIX_TIMESTAMP())/(UNIX_TIMESTAMP(date_add(m_item_udatetime,interval 2 MONTH))-UNIX_TIMESTAMP(m_item_udatetimE)) AS TWO  ".
    "from m_item where 	m_item.m_item_void_flag =0 	AND m_item.m_item_delete_flag =0";
    
	my $sth = $dbh->prepare($q);
		$sth->execute();
		while(my $res=$sth->fetchrow_hashref()){
		   if($res->{ONE}<=1 && $res->{ONE}>0){
		     $scores{$res->{m_item_id}} = $res->{ONE} * $intact;
		   }elsif($res->{TWO}<=1 && $res->{TWO}>0){
		     $scores{$res->{m_item_id}} = $res->{TWO} * $intact;
		   }else{
		     $scores{$res->{m_item_id}}= 0;
		   }		
   }
   %integral_xjcp=%scores;
   lock($num);
   $num++;
   cond_broadcast($num);
    print "xjcp_intact() has over";
   $dbh->disconnect();
   my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
 sub spxl_intact{
	 my $startTime=time();	 
	  my $tid=threads->self->tid;
	    print "start spxl_intact($tid)....\n";
	    my ($intact) =@_;
		my %arr = ();
		my %scores= ();		
	    my $dbh=&getDbHandler();
		my $q = "SELECT t_juchu.t_juchu_id,sum(t_zaikoitem_quantity) as num FROM t_juchu INNER JOIN t_juchuitem ON t_juchu.t_juchu_id = t_juchuitem.t_juchuitem_t_juchu_id left join t_zaikoitem on t_zaikoitem.t_zaikoitem_id = t_juchuitem.t_juchuitem_id where 1 ".
				"and t_zaikoitem.t_zaikoitem_id is not null ".
				"and t_juchuitem_maker_deliverydate <> '0000-00-00 00:00:00' ".
				"and t_juchu_nyukin_datetime <> '0000-00-00 00:00:00' ".
				"and t_juchu.t_juchu_void_flag = '0' ".
				"and t_juchu.t_juchu_datetime > DATE_SUB(NOW(),INTERVAL 2 MONTH)  ".
				"group by t_juchu.t_juchu_id ";
		 my $sth=$dbh->prepare($q);	
		$sth->execute();
		while(my $res=$sth->fetchrow_hashref()){			
			$arr{$res->{t_juchu_id}} = ($res->{num})?$res->{num}:0;
		}
		my $maxvalue=max(values(%arr));
        while( my ($key,$value) = each(%arr)){				
			if ($maxvalue !=0 ){
				$scores{$key} =  $value/$maxvalue*$intact;				
			}else {
				$scores{$key} = 0;
			}
		}
		
		%integral_spxl=%scores;
		
		lock($num);
		$num++;
		cond_broadcast($num);
		 print "spxl_intact() has over";
		$dbh->disconnect();
		my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}
	
sub spdj_intact{
	my $startTime=time();
	my $tid=threads->self->tid;
	 print "start spdj_intact($tid)....\n";
	    my ($intact) =@_;
		my %arr = ();
		my %scores = ();
         my $dbh=&getDbHandler();
		my $q = "select t_ranking.t_ranking_m_item_id, t_ranking.t_ranking_number
				from 
				t_ranking 
				LEFT JOIN m_item 
				ON 
				m_item.m_item_id = t_ranking.t_ranking_m_item_id  
				LEFT JOIN m_maker 
				ON 
				m_item.m_item_m_maker_id = m_maker.m_maker_id 
				where 1 
				and t_ranking.t_ranking_type = 'all_realtime' 
				and m_maker.m_maker_void_flag = '0' 
				order by t_ranking.t_ranking_number ";
        my $sth=$dbh->prepare($q);	
		$sth->execute();
		while(my $res=$sth->fetchrow_hashref()){			
			$arr{$res->{t_ranking_m_item_id}} = ($res->{t_ranking_number})?$res->{t_ranking_number}:0;
		}

        my $maxvalue=max(values(%arr));
		while( my ($key,$value) = each(%arr)){		
			
			if ($maxvalue!=0){
				$integral_spdj{$key}  =  $value/$maxvalue*$intact;
			}else {
				$integral_spdj{$key}  = 0;
			}
		}	
		lock($num);
		$num++;
		cond_broadcast($num);
		 print "spdj_intact() has over";
		$dbh->disconnect();
		my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}


sub consumer{	
	my $startTime=time();
	my $processStartTime;
	my $tid=threads->self->tid;
	 print "start consumer($tid)....\n";
	 my $dbh=&getDbHandler();  
    {
	  lock($num);
	  cond_wait($num) until ($num ==11);
    }
  
  my $inSql="REPLACE INTO m_item_search (`m_item_search_item_id` ,`m_item_search_integral_gjz` ,`m_item_search_integral_spdj` ,
			`m_item_search_integral_spxl` ,	`m_item_search_integral_xjcp` ,	`m_item_search_integral_xinsj` ,`m_item_search_integral_cpwz` ,
			`m_item_search_integral_dppf` ,	`m_item_search_integral_jfpf` ,	`m_item_search_integral_chpf` ,	`m_item_search_integral_cpsjl` ,
			`m_item_search_integral_dpscl` ,`m_item_search_integral_zhl` ,	`m_item_search_integral_dljl`,	`m_item_search_integral`
			) VALUES (?, 0, ?,?,?,?,?,?,?,?,?,?,?,?,?)";
  my $insth=$dbh->prepare($inSql) or die $dbh->errstr; 
	
  while(1){ 
	  our $id;
      {
      lock(@rows);
      cond_wait(@rows) until (@rows);          
      goto CONSUMEROVER if($rows[0] == 'over' && $#rows ==0);
      $id= shift @rows;     
     }
      cond_signal(@rows);
    $processStartTime =time() if(!$processStartTime);
    my $integral_=0;
    my $integral_spdj_s =sprintf("%0.6f", $integral_spdj{$id}?$integral_spdj{$id}:0); 	#点击率
	my $integral_spxl_s =sprintf("%0.6f", $integral_spxl{$id}?$integral_spxl{$id}:0); 		#商品销量
	my $integral_xjcp_s =sprintf("%0.6f", $integral_xjcp{$id}?$integral_xjcp{$id}:0);			#快下架的产品
	my $integral_xinsj_s =sprintf("%0.6f", $integral_xinsj{$id}?$integral_xinsj{$id}:0);		#新商家
	my $integral_cpwz_s =sprintf("%0.6f", $integral_cpwz{$id}?$integral_cpwz{$id}:0); 	#产品信息完整度 
	my $integral_dppf_s = 0;						#dppf 店铺评分
	my $integral_jfpf_s =sprintf("%0.6f", $integral_jfpf{$id}?$integral_jfpf{$id}:0);  		#纠纷评分 
	my $integral_chpf_s =sprintf("%0.6f", $integral_chpf{$id}?$integral_chpf{$id}:0);		#出货评分
	my $integral_cpsjl_s =sprintf("%0.6f", $integral_cpsjl{$id}?$integral_cpsjl{$id}:0);   	#月产品上架率
	my $integral_dpscl_s =sprintf("%0.6f", $integral_dpscl{$id}?$integral_dpscl{$id}:0);#店铺收藏率 
	my $integral_zhl_s =sprintf("%0.6f", $integral_zhl{$id}?$integral_zhl{$id}:0);   			#转化率 访问
	my $integral_dljl_s =sprintf("%0.6f", $integral_dljl{$id}?$integral_dljl{$id}:0);   	#每天登陆获得速贸币

	
	$integral_ = $integral_spdj_s+$integral_spxl_s+$integral_xjcp_s+$integral_xinsj_s +$integral_cpwz_s +$integral_dppf_s +$integral_jfpf_s +$integral_chpf_s +$integral_cpsjl_s +$integral_dpscl_s +$integral_zhl_s +$integral_dljl_s;
	
	$insth->execute($id,$integral_spdj_s,$integral_spxl_s ,$integral_xjcp_s ,$integral_xinsj_s ,$integral_cpwz_s ,$integral_dppf_s ,$integral_jfpf_s ,$integral_chpf_s ,$integral_cpsjl_s ,$integral_dpscl_s ,$integral_zhl_s ,$integral_dljl_s ,$integral_);          
   }
   CONSUMEROVER:
   print "consume date($tid) has over";
   $dbh->disconnect();
		my $elapseTime=time() - $startTime;
		my $processTime=time() - $processStartTime;
   print "(共$elapseTime秒,处理时间$processTime秒)\n";
}
sub producer{
    print "start producer()....\n";
   my $startTime=time();
   my $dbh=&getDbHandler();
   my $sth=$dbh->prepare('select m_item_id from m_item ') or die $dbh->errstr;
   $sth->execute();
   while(my $res=$sth->fetchrow_hashref()){ 
	  lock(@rows);
	  push(@rows,$res->{m_item_id});
	  cond_signal(@rows);
   }
    push(@rows,"over");
   print "product data() has over";
		$dbh->disconnect();
		my $elapseTime=time() - $startTime;
   print "(共$elapseTime秒)\n";
}

sub prepareData{
  
    print "start prepareData()....\n";
   my $dbh=&getDbHandler();
   my  $q_1 = "select * from m_item_search_score ";
   my $sth = $dbh->prepare($q_1);
   $sth->execute();
   my %_s_arr=();
   while(my $res=$sth->fetchrow_hashref()){	 
	  $_s_arr{$res->{m_item_search_score_name}} = $res->{m_item_search_score_integral};
   }
   	$dbh->disconnect(); 
   while(my ($key,$value)=each(%_s_arr)){
	 my $dataName="integral_".$key;
	 my $funName=$key."_intact";
	 next if !exists &$funName;
	 my $pth=Thread->new(\&$funName,$value);	 
   }  
  
}
sub getDbHandler{
   my $dbh=DBI->connect_cached('DBI:mysql:japan064;host=192.168.1.147','root','root') || die "could not connect to db";
   $dbh->do("SET NAMES 'utf8'");	
   return $dbh;
}
sub main{
    print strftime("开始执行计划： %Y-%m-%d %H:%M \n",localtime);
   my $startTime=time();
   my $n=($ARGV[0] < 1)? 1:$ARGV[0];    
   &prepareData();   
   my $p = Thread->new (\&producer);
   for my $i (1..$n){
	Thread->new(\&consumer);	
   }
   foreach my $pth (threads->list){
	   $pth->join;
   }
   print "all  has over (共",time() - $startTime,"秒)\n";  
  print "-" x 100,"\n\n";
}
&main();
