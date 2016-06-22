<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="mainx.css">
</head>
<body>
<center>
 <table class="table-hover" >
  <tr>
    <th class="text-left">Contact domain</th>
    <th class="text-left">tor hidden service</th>
  </tr>

<?php
//**************!!!!!!!!!!!!!!!!!!!!!!!!!*************************
//	Very important: we need to add athentification
//	Data that are displayed are critical.
//**************!!!!!!!!!!!!!!!!!!!!!!!!!*************************
  $link2 =  mysql_connect('localhost', 'own-mailbox', 'own-mailbox');
    if (!$link2) {echo "tls_proxy: conection à la base de donnée impossible\n"; return;}
  
    $db_selected = mysql_select_db("postfix",$link2);

       $query=sprintf(" SELECT address, transportation  FROM transport");
    $reponse= mysql_query($query,$link2);   
      
      if (!$reponse) {
	    $message  = 'Invalid query: ' . mysql_error() . "\n";
	    $message .= 'Whole query: ' . $query;
	    echo $message;
	    return ;
	  }
	  
      // On affiche chaque entrée une à une
	
    while ($donnees = mysql_fetch_assoc($reponse))
	{
	$onion=substr($donnees['transportation'], 9);
	$onion=substr($onion, 0, -1);
	echo "<tr>\n";
	echo "<td class=\"text-left\">".$donnees['address']."</td>\n";
	echo "<td class=\"text-left\">".$onion."</td>\n";	
	echo "</tr>\n";
	}
?>

</table> 
</center>
</body>

</html>
