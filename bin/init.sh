echo 'import mavon-editor icons'

if [ -f ../public/assets/vendor/mavon-editor/fontello.eot ]; then
  echo 'exist!!'
else
  echo 'not exist!!'
  mkdir -p ../public/assets/vendor/mavon-editor
  cp ../node_modules/mavon-editor/dist/font/* ../public/assets/vendor/mavon-editor
fi
