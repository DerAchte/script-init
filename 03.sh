uid=9f72acb50284a55221180ff283c1b6b2e55f21aee682bf018075e96e888050b5
secret=e20ffd0b4e28fd1dd048d3e360607131446a86aa57abc31d69d63c78cf9289ea
token=$(curl -s POST --data "grant_type=client_credentials&client_id=$uid&client_secret=$secret" https://api.intra.42.fr/oauth/token | awk -F '"' '{print $4}')

echo Entrez un 42_login:
read login
retour=$(curl -sH "Authorization: Bearer $token" "https://api.intra.42.fr/v2/users/$login" | awk -F '"' {'print $50'})

if [ $retour = wallet ]
then echo Le student est absent.
else curl -sH "Authorization: Bearer $token" "https://api.intra.42.fr/v2/users/$login" | awk -F '"' {'print $50, $26'}
fi
