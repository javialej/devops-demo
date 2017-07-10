npm install -g now
echo "Deploying..."
URL=$(now --docker -t $NOW_TOKEN)
echo "Running acceptance on $URL"
curl --silent -L URL
