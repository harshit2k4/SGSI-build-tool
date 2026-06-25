#!/bin/bash

LOCALDIR=$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)
cd $LOCALDIR
source $LOCALDIR/../../bin.sh
source $LOCALDIR/../../language_helper.sh

systemdir="$TARGETDIR/system/system"
configdir="$TARGETDIR/config"
current_sdk_ver=$(cat $systemdir/build.prop | grep "ro.build.version.sdk" | head -n 1 | cut -d "=" -f 2)

# Detect APEX State
apex_check() {
  apex_extract=""
  if ls $systemdir/apex | grep -q ".apex$"; then
    echo "$DETECTED_APEX"
  fi
  if ! (ls $systemdir/apex | grep -q ".apex$"); then
    echo "$DETECTED_FLATTEN_APEX"
  fi
}

apex_check
echo "$EXTRACTING_EXTRA_APEX"

# Prebuilt vndk.current
rm -rf $systemdir/apex/com.android.vndk.current*
if [ "$current_sdk_ver" -ge 31 ]; then
  VNDK_FILE="com.android.vndk.v${current_sdk_ver}.apex"
  VNDK_7Z="com.android.vndk.v${current_sdk_ver}.apex.7z"
  if [ ! -f "$systemdir/$VNDK_FILE" ]; then
    if [ ! -f "$LOCALDIR/$VNDK_7Z" ]; then
      echo "Downloading $VNDK_7Z..."
      wget -q "https://github.com/harshit2k4/SGSI-build-tool/releases/download/vndk/$VNDK_7Z" -O "$LOCALDIR/$VNDK_7Z" || true
    fi
    if [ -f "$LOCALDIR/$VNDK_7Z" ]; then
      7z x -y "$LOCALDIR/$VNDK_7Z" -o"$systemdir/apex/" >/dev/null 2>&1
      mv "$systemdir/apex/$VNDK_FILE" "$systemdir/apex/com.android.vndk.current.apex"
    fi
  fi
fi

# different vndk version
for v in 29 30 31 32 33 34 35 36; do
  if [ "$current_sdk_ver" -ge "$v" ]; then
    VNDK_FILE="com.android.vndk.v${v}.apex"
    VNDK_7Z="com.android.vndk.v${v}.apex.7z"
    if [ ! -f "$systemdir/apex/$VNDK_FILE" ] && [ ! -f "$systemdir/$VNDK_FILE" ]; then
      if [ ! -f "$LOCALDIR/$VNDK_7Z" ]; then
        echo "Downloading $VNDK_7Z..."
        wget -q "https://github.com/harshit2k4/SGSI-build-tool/releases/download/vndk/$VNDK_7Z" -O "$LOCALDIR/$VNDK_7Z" || true
      fi
      if [ -f "$LOCALDIR/$VNDK_7Z" ]; then
        7z x -y "$LOCALDIR/$VNDK_7Z" -o"$systemdir/apex/" >/dev/null 2>&1
      fi
    fi
  fi
done

cd $bin/apex_tools
./apex_extractor.sh "$TARGETDIR" "$systemdir/apex"
cd $LOCALDIR

# Clean up default apex state
sed -i '/ro.apex.updatable/d' $systemdir/build.prop
sed -i '/ro.apex.updatable/d' $systemdir/product/etc/build.prop
sed -i '/ro.apex.updatable/d' $systemdir/system_ext/etc/build.prop

apex_flatten() {
  # Force use flatten apex
  echo "" >>$systemdir/product/etc/build.prop
  echo "# Apex state" >>$systemdir/product/etc/build.prop
  echo "ro.apex.updatable=false" >>$systemdir/product/etc/build.prop

  echo "$ENABLE_CLEAN_APEX_FILES"
  local apex_files=$(ls $systemdir/apex | grep ".apex$")
  for apex in $apex_files; do
    if [ -f $systemdir/apex/$apex ]; then
      rm -rf $systemdir/apex/$apex
    fi
  done

  # Not mount apex setup
  [ -f $systemdir/etc/init/apex-sharedlibs.rc ] && rm -rf $systemdir/etc/init/apex-sharedlibs.rc
}

apex_enable() {
  # Force enable apex
  echo "" >>$systemdir/product/etc/build.prop
  echo "# Apex state" >>$systemdir/product/etc/build.prop
  echo "ro.apex.updatable=true" >>$systemdir/product/etc/build.prop
  echo "$ENABLE_CLEAN_APEX_DIRS"

  local apex_dirs=$(find $systemdir/apex -maxdepth 1 -type d | grep -v "$systemdir/apex$")
  for apex_dir in $apex_dirs; do
    if [ -d $apex_dir ]; then
      rm -rf $apex_dir
    fi
  done
}

if [ $(cat $TARGETDIR/apex_state) = true ]; then
  apex_enable
elif [ $(cat $TARGETDIR/apex_state) = false ]; then
  apex_flatten
fi

# Create vndk symlinks
for v in 29 30 31 32 33 34 35 36; do
  if [ "$current_sdk_ver" -ge "$v" ]; then
    rm -rf $systemdir/lib/vndk-$v $systemdir/lib/vndk-sp-$v
    rm -rf $systemdir/lib64/vndk-$v $systemdir/lib64/vndk-sp-$v
  fi
done

ln -s /apex/com.android.vndk.v29/lib $systemdir/lib/vndk-29
ln -s /apex/com.android.vndk.v29/lib $systemdir/lib/vndk-sp-29

ln -s /apex/com.android.vndk.v29/lib64 $systemdir/lib64/vndk-29
ln -s /apex/com.android.vndk.v29/lib64 $systemdir/lib64/vndk-sp-29

# Fix vintf for different vndk version
manifest_file="$systemdir/system_ext/etc/vintf/manifest.xml"
if [ -f $manifest_file ]; then
  sed -i "/<\/manifest>/d" $manifest_file
  for v in 29 30 31 32 33 34 35 36; do
    if [ "$current_sdk_ver" -gt "$v" ] || [ "$current_sdk_ver" -ge 29 ] && [ "$v" -le 30 ]; then
      cat >>"$manifest_file" <<EOF
    <vendor-ndk>
        <version>${v}</version>
    </vendor-ndk>
EOF
    fi
  done
  echo "" >>$manifest_file
  echo "</manifest>" >>$manifest_file
fi
