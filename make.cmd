@echo off
IF [%1]==[] (
         echo Availables arguments [commit;build;image;test;deploy].
)ELSE IF  "%1" == "build" (
          mvnw package -Dmaven.test.skip=true
)ELSE IF "%1" == "commit%" (
          git add .
          git commit -m "%2"
          git push -u origin master
)ELSE IF "%1" == "image%" (
	IF [%2]==[] (
		   echo Favor passar o nome da imagem no argumento.
	)ELSE ( 
		  set /p port=Em qual porta a aplicacao esta rodando? 
		  docker login
          docker build -t "%2":testing .
          docker run -d -p %port%:%port% "%2":testing 
			) 
)ELSE IF "%1" == "test" (
		  mvnw test
)ELSE IF "%1" == "deploy" (
		  mvnw deploy -Dmaven.test.skip=true
)
