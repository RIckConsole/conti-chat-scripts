# Put this script in a dir with all of the JSON chat files.
# This script will NOT work with the jabber and rocketchat leaks. I'll be uploading those soon

for jsonfile in *.json
do
echo "===== OPENING $jsonfile ====="
range=$(grep body $jsonfile | wc -l)
	for item in $(seq 1 $range)
	do
		timestamp=$(jq '.ts' $jsonfile | sed "${item}q;d" | cut -d '"' -f 2 | cut -d '.' -f 1)
		to=$(jq '.to' $jsonfile | sed "${item}q;d" | cut -d '@' -f 1 | cut -d '"' -f 2)
		from=$(jq '.from' $jsonfile | sed "${item}q;d" | cut -d '@' -f 1 | cut -d '"' -f 2)
		translation=$(jq '.body' $jsonfile | sed "${item}q;d" | trans -b)
		echo "[$timestamp][$to -> $from]: $translation"
		echo "[$timestamp][$to -> $from]: $translation" >> out.txt
		sleep 5
	done
echo -e "\n"
done
echo "DONE!"
