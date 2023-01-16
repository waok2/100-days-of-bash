!/bin/bash
# filename='ca2'
# echo Start
# while read p; do 
#     aws sqs tag-queue --queue-url "$p" --tags "tagName=value"
#     echo "$p"

# done < "$filename"


# aws sqs tag-queue --queue-url "$p" --tags tagName=value
#aws sqs list-queues --output text |grep 'criteria'| awk '{print $2}'

filename='delete'
echo Start
while read p; do 
    echo $p
    aws sqs delete-queue --queue-url $p
    echo "done"

done < "$filename"