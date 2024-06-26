#!/bin/bash

wordlist="/usr/share/john/password.lst"
hash="806825f0827b628e81620f0d83922fb2c52c7136"

while read senha; do
        echo -e "Testando senha ====> $senha"
        hashx=$(echo -n "$senha" | md5sum | head -c 32 | base64 -w 0 | sha1sum | head -c 40)
        echo "hash encontrado ====> $hashx"
        if [ "$hash" == "$hashx" ]; then
                echo "####################"
                echo "[+] SENHA ENCONTRADA ====> $senha"
                echo "####################"
                exit 0
        fi
done < $wordlist

exit 1
