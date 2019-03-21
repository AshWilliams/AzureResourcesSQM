# Nomeclatura - Naming Conventions 
# - Componente:
  #  Grupo       = "rg"
  #  Storage     = "sa"
  #  App         = "ap"
  #  Kubernetes  = "aks"
  #  APIMan      = "api"
  #  ServicePlan = "sp"
#   - Tipo:
   #  Aplicacion      = "app"
   #  Infraestructura = "infra"
#   - Application Code (4 digits)
#   - Ambiente
#   - Version

#az.cmd account list



Grupo="rg"
Storage="sa"
App="ap"
ServicePlan="sp"
appcode="sead"
ambiente="test"
Aplicacion="app"
Infraestructura="infra"
ServicePlan="sp"
Tag="test"


az="az"

unameOut="$(uname -s)"
case "${unameOut}" in
    MINGW*)     az="az.cmd";;
esac

sqmregion="eu2"
azregion="eastus2"

componente="$Grupo"

#0 Usar Subscripción X
$az account set --subscription "Visual Studio Enterprise"

#1. Create Resource Group
componente="rg"
tipo="$Aplicacion"
version="1.0"

rgcompname="$componente$sqmregion$tipo$appcode$ambiente$version"
rgcompname=${rgcompname^^}

#echo "$rgcompname"

echo "Checking resource group $rgcompname"
flagrg=$($az group exists -n $rgcompname)

if [ "$flagrg" = false ]
then
      echo "Step1. Creating resource group $rgcompname"
      $az group create -n $rgcompname -l $azregion --tags Ambiente="$Tag"
else
      echo "Resource group $rgcompname already exist...skip"
      $az group update -n $rgcompname --set tags.Ambiente="UAT"
fi

#2 Crear App Service Plan
componente="$ServicePlan"
spcompname="$componente$sqmregion$tipo$appcode$ambiente$version"
spcompname=${spcompname^^}

$az appservice plan create -g $rgcompname -n $spcompname --tags Ambiente="$Tag"

#3 Crear Web App 
componente="$App"
apcompname="$componente$sqmregion$tipo$appcode$ambiente"
apcompname=${apcompname^^}

$az webapp create -g $rgcompname -p $spcompname -n $apcompname --tags Ambiente="$Tag"


# Recursos para ambiente DEV
ambiente="dev"
Tag="development"

componente="$Grupo"

#1. Create Resource Group
componente="rg"
tipo="$Aplicacion"
version="1.0"

rgcompname="$componente$sqmregion$tipo$appcode$ambiente$version"
rgcompname=${rgcompname^^}

#echo "$rgcompname"

echo "Checking resource group $rgcompname"
flagrg=$($az group exists -n $rgcompname)

if [ "$flagrg" = false ]
then
      echo "Step1. Creating resource group $rgcompname"
      $az group create -n $rgcompname -l $azregion --tags Ambiente="$Tag"
else
      echo "Resource group $rgcompname already exist...skip"
      $az group update -n $rgcompname --set tags.Ambiente="UAT"
fi

#2 Crear App Service Plan
componente="$ServicePlan"
spcompname="$componente$sqmregion$tipo$appcode$ambiente$version"
spcompname=${spcompname^^}

$az appservice plan create -g $rgcompname -n $spcompname --tags Ambiente="$Tag"

#3 Crear Web App 
componente="$App"
apcompname="$componente$sqmregion$tipo$appcode$ambiente"
apcompname=${apcompname^^}

$az webapp create -g $rgcompname -p $spcompname -n $apcompname --tags Ambiente="$Tag"
