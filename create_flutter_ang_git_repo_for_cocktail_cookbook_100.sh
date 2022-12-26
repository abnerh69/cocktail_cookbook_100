# Flutter 2022 Create Flutter Project and GitHub Repository
# f2_create_flutter_project_and_github_repo
# Generated on: 2022-12-26 18:45:43

# Cocktail Cookbook
# Crear Aplicación/Paquete y su proyecto en GitHub 
  
export NOMBRE_PROYECTO="Cocktail Cookbook"
export DESCRIPCION="Proyecto $NOMBRE_PROYECTO"

echo Definir un nombre de proyecto
echo $DESCRIPCION

export PROYECTO=cocktail_cookbook
export SUFIJO=_100

# Definir un nombre de proyecto
export ORG=com.ashware

# export CARPETA_DEV=~/Dev
# export CARPETA_BASE=$CARPETA_DEV/_mlb
export CARPETA_BASE=/Users/abnershernandez/DevTemp/fulltimeforce/

# Variables para Flutter Create ...
export F_TEMPLATE="--template=package"
export F_TEMPLATE="--template=app"

export F_ORG=--org=$ORG
export F_PROJECT_NAME=--project-name=$PROYECTO
export F_DESCRIPTION="--description=\"$NOMBRE_PROYECTO\""
export F_IOS_LANGUAGE="--ios-language=swift"
export F_ANDROID_LANGUAGE="--android-language=kotlin"
export F_ANDROIDX="--androidx"
export F_PUB="--no-pub"
export F_OFFLINE="--no-offline"
export F_WITH_DRIVER_TEST="--no-with-driver-test"
export F_OVERWRITE="--no-overwrite"

# definir Usuario de GitHub
export NOMBRE="Abner Hernandez"
export USUARIO=abnerh69
export CORREO=abnerh69@gmail.com
# export CLAVE=2o2oV1rg1n14

# Token para abnerh69
# export GITHUB_TOKEN=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
export GITHUB_TOKEN=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
export GITHUB_USER=abnerh69
# export GITHUB_PASSWORD=2o2oV1rg1n14

echo Crear un nuevo proyecto: $PROYECTO
mkdir $CARPETA_BASE
cd $CARPETA_BASE

fvm global stable

echo Ejecutando flutter create
echo "flutter create $F_PUB $F_OFFLINE $F_WITH_DRIVER_TEST $F_TEMPLATE $F_OVERWRITE $F_ORG $F_PROJECT_NAME $F_IOS_LANGUAGE $F_ANDROID_LANGUAGE $PROYECTO$SUFIJO"
flutter create $F_PUB $F_OFFLINE $F_WITH_DRIVER_TEST $F_TEMPLATE $F_OVERWRITE $F_ORG $F_PROJECT_NAME $F_IOS_LANGUAGE $F_ANDROID_LANGUAGE $PROYECTO$SUFIJO

# se ha eliminado $F_DESCRIPTION por errores
# se ha eliminado $F_ANDROIDX porque ya no es una opción disponible

# Inicializar el proyecto en GitHub
cd $CARPETA_BASE/$PROYECTO$SUFIJO

fvm use stable

echo Inicializando Git
git init
git config --local user.email $CORREO
git config --local user.name "$NOMBRE"
git add .
git commit -m "$DESCRIPCION"

git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$PROYECTO$SUFIJO.git
git remote set-url origin  https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$PROYECTO$SUFIJO.git
git remote add master https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$PROYECTO$SUFIJO.git
git remote set-url master  https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$PROYECTO$SUFIJO.git

echo Ejecutando hub...
hub create -d "$DESCRIPCION" && git push --set-upstream origin master && git push -u origin master && open https://github.com/$GITHUB_USER/$PROYECTO$SUFIJO.git


# open ~/Applications/JetBrains\ Toolbox/IntelliJ\ IDEA\ Community\ Edition.app $CARPETA_BASE/$PROYECTO$SUFIJO
#
# Changes for iOS:
# -> Podfile
# remove comment in line platform :ios, '9.0'
#
#On Xcode
#Set developer team.
#
# Asignar el environment al IntelliJ IDEA
#
