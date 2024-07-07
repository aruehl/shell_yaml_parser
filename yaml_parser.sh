#!/bin/bash
#
# converts a yaml file into shell variables and arrays

yaml_parser::parse() {
    local file=$1
    local prefix=$2
    local export=$3
    local s='[[:blank:]]*'
    local w='[a-zA-Z0-9_]*'
    local fs=$(echo @|tr @ '\034')

    sed -e ":1;s|^\($s\)-$s\($w\)$s:$s\(.*\)$s|\1-\n\1  \2: \3|;t1" \
        -e "s|^---$s$||g" $file |
    sed -E ":1;s|[-\.]($w\:.+$)|_\1|;t1" |
    sed -ne "s|^\($s\):|\1|" \
        -e "/#.*[\"\']/!s| #.*||g; /^#/s|#.*||g;" \
        -e "s|^\($s\)-$s[\"']\(.*\)[\"']$s\$|\1$fs$fs\2|p" \
        -e "s|^\($s\)-$s\(.*\)$s\$|\1$fs$fs\2|p" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" |

    awk -F$fs '{
        indent = length($1)/2;
        key    = $2;
        value  = $3;
        prefix = "'"$prefix"'"
        export = "'"$export"'"

        keys[indent] = key;
        for (i in keys) {
            if (i > indent) {
                delete keys[i];
                idx[i]=0
            }
        }
        path="";
        step = indent - 1;
        if (length(key) == 0) {
            keys[indent]= idx[indent]++;
            if (length(value) == 0)
                step = indent;
        }
        for (i=0; i<=step; i++) {
            path=(path)(keys[i])("_");
        }
        if (length(value) > 0) {
            if (export)
                printf("export %s%s%s=\"'%s'\";\n", prefix, path, keys[indent], value);
            else
                printf("%s%s%s=\"'%s'\";\n", prefix, path, keys[indent], value);
            if (length(key) == 0)
                printf("%s%sarray+=(\"%s\");\n", prefix, path, value);
            else
                printf("%s%sarray[%s]=\"%s\";\n", prefix, path, key, value);
        } else {
            if (length(key) == 0)
                printf("declare -g -a %s%s%sarray;\n", prefix, path, key);
            else
                printf("declare -g -A %s%s%s_array;\n", prefix, path, key);
        }
    }' |
    sed -e "s|__|_|g"
}
