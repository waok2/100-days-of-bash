
filename='file-tl'
echo Start
while read p; do 
    n="$(echo $p| sed 's/s3\:\/\///g')"
    # echo emptying $p
    # aws s3 rm $p --recursive

    # aws s3api delete-objects \
    # --bucket $n \
    # --delete "$(aws s3api list-object-versions \
    # --bucket $n | \
    # jq '{Objects: [.Versions[] | {Key:.Key, VersionId : .VersionId}], Quiet: false}')"

    # aws s3api delete-objects \
    # --bucket $n \
    # --delete "$(aws s3api list-object-versions \
    # --bucket "$n" \
    # --output=json \
    # --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" #1> /dev/null

    aws s3api delete-objects --bucket $n --delete "$(aws s3api list-object-versions --bucket $n --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" &> /dev/null
    aws s3api delete-objects --bucket $n --delete "$(aws s3api list-object-versions --bucket $n --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')" &> /dev/null

    echo deleting $p
    aws s3 rb $p --force 
    echo "done"

done < "$filename"

echo End