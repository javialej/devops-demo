wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.2/packer_1.0.2_linux_amd64.zip?_ga=2.21598395.127986341.1499723986-43132283.1499723986
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip?_ga=2.234359190.900821311.1499781356-366599474.1499781356
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
packer validate deployments/template.json &&
packer build deployments/template.json &&
export TF_VAR_image_id = $(curl -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" https://api.digitalocean.com/v2/images?private=true | jq ."images[] | select(.name == \"platzi-demo-$CIRCLE_BUILD_NUM\") | .id")
echo $TF_VAR_image_id
cd infra && terraform apply && cd .. &&
git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" && 
git push origin master
