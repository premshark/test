echo $USER
docker build -t test .
docker tag test:latest 0123456789.dkr.ecr.ap-south-1.amazonaws.com/test:0.0.1
eval $(aws ecr get-login --region ap-south-1 --no-include-email | sed "s|https://||")
docker push 0123456789.dkr.ecr.ap-south-1.amazonaws.com/test:0.0.1
if [[ $(docker images -q --filter "dangling=true") ]]; then docker rmi $(docker images --filter "dangling=true" -q --no-trunc); else echo "No dangling images found"; fi
aws ecr list-images  --region ap-south-1 --repository-name test --query "imageIds[?type(imageTag)!='string'].[imageDigest]" --output text | while read line; do aws ecr batch-delete-image  --region ap-south-1 --repository-name test --image-ids imageDigest=$line; done
