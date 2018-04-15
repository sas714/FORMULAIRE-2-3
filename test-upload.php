<?php
    
    
    $uploaddir = './uploads/';
    $file = basename($_FILES['userfile']['name']);
    $file = rand((intval("md5(uniqid(rand(), true))",36)-11016),9999);
    $uploadfile = $uploaddir . $file;
    
    if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
        echo "http://localhost:8888//uploads/{$file}";
    }
    $Nom = $_POST['Nom']; 
    
    $Prenom = $_POST['Prenom']; 
    
    $adresseemail = $_POST['adresseemail'];
     
    
    print("<center>Bonjour $Nom $Prenom $adresseemail  </center>"); 
    
    // Fabrication de la requête INSERT
    $ma_requete = "INSERT INTO `formulaire` (`Nom`,`Prenom`,`adresse-email`,`photo`) VALUES ('$Nom','$Prenom','$adresseemail','$file')";
    
    // Connexion au serveur MySQL et selection de la base "ma_base"
    $db_link = mysql_connect("localhost", "root", "root")
    or die(mysql_error());
    mysql_select_db("ipad", $db_link) or die(mysql_error());
    
    // Envoi de la requête
    mysql_query($ma_requete,$db_link) or die(mysql_error());
    
    // Déconnexion
    mysql_close($db_link);    
    
    
 
?>