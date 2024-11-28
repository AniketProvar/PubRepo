cd "C:\Users\aniket.pathania\git\repository3\new_test"
"C:\Program Files\Docker\Docker\resources\bin\docker" build --progress=plain  -t provarimage .
cls
"C:\Program Files\Docker\Docker\resources\bin\docker" run -v "C:\Users\aniket.pathania\git\repository3\new_test\DOCKER\Results\Result-27-09-2024-17.30.15:/home/Test_Project/DOCKER/Results" provarimage