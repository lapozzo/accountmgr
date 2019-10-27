#!/bin/bash
 
verification_return(){
if [[ "$?" -ne 0 ]] ; then
		  echo 'Error'; 
		  exit 1;
else 
          echo 'Success'; 
		  exit 0
fi     
} 

case $1 in
   "build") 
		./mvnw package -Dmaven.test.skip=true
		verification_return
         ;;
	"clean") 
		mvn clean test
		verification_return
	 ;;	
   "commit") echo "Executando commit no git..."
			 git add .
			 git commit -m "$2"
			 git push -u origin master
         ;;
   "image")
          if [ -z "$2" ]      
		    then
			echo "Favor passar o nome da imagem no argumento."
		  else 	
		  echo "Em qual porta a aplicacao esta rodando?"
		  read porta
		  echo "Criando e Subindo imagem Docker..."  
          docker login		  
          docker build -t "$2":testing .
          docker run -d -p $porta:$porta "$2":testing       
          fi		  
      ;;
	"test") 
        ./mvnw test
		verification_return
         ;;
	"deploy") 
        ./mvnw deploy -Dmaven.install.skip=true -Dmaven.test.skip=true -DskipITs=true
		verification_return
         ;;
	"--h")
        echo ".............................."  
		echo "|   Parametros disponiveis   |"
		echo ".............................."
		echo "|build                       |"
		echo "|commit 'comentario'         |"
		echo "|image 'nome da imagem'      |"
		echo "|test'                       |"
		echo "|deploy'                     |"
        echo ".............................."
         	  
      ;;
esac

