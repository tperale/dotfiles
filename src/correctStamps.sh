#/bin/env bash

# PERALE Thomas
# 000408160

# Exemple d'appel:
#   correctStamps.sh /mnt/backup /mnt/nas 1301131112
#                                         YYMMDDhhmm

# desc: Refaire un backup à partir de $1 vers $2
# 1) Parcour des fichiers et chemins relatif dans $1 (le backup).
#
# Si le fichier est dans $2 aussi avec le timestamp ($3):
# NB:
#       Faire une `cp --preserve=timestamps` ou touch pour changer le timestamp
# Sinon:
#       Ne pas faire de copie.

usage () {
cat <<EOF
correctStamps.sh <backup_device> <result_device> <timestamp>
    backup_device |
    result_device |
    timestamp     |
EOF
}

correct_stamp () {
    relative_path=$1
    for file in $backup/$relative_path/*
    do
        if [ -d  $working_dir/$relative_path/$file ]
            # Appel récursif à correct stamp.
            correct_stamp $file
        elif [ -e $working_dir/$relative_path/$file ]
            # Qu'en est-il de l'arg $3 si les copies prennent du temps.
            if [ -eq $(stat -c%Y $working_dir/$relative_path/$file) $timestamp ]
                # oldstamp=$(stat -c%Y $backup/$relative_path)
                touch -r $backup/$relative_path/$file $working_dir/$relative_path/$file
            fi
        fi
    done
}

if (( $# == 3 )); then
    backup=$1
    working_dir=$2
    timestamp=$3
else
    usage && exit 1
fi

correct_stamp "" # On lance la fonction avec rien comme premier argument.
