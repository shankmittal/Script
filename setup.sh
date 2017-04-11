SCRIPT_PATH="`realpath \"$0\" | xargs dirname`"
BACKUP=$HOME/scripts-backup/$(date -d "today" +"%Y-%m-%d_%H:%M")
FILES=`ls -1 "$SCRIPT_PATH"`
for f in $FILES; do
	LINK=`echo $f | sed 's/^dot-/./'`;
	if [ -e "$HOME/$LINK" ]
	then
		mkdir -p $BACKUP
		mv $HOME/$LINK $BACKUP/$f
	fi
	#ln -s $SCRIPT_PATH/$f $HOME/$LINK
	cp -rf $SCRIPT_PATH/$f $HOME/$LINK
done
