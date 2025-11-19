#/usr/bash

echo
echo
echo "payment.xskとaddr.addrをshareディレクトリにコピーして"
echo

echo
echo "署名キーを入力してください。"
echo
read -r -p "> " KEY


cardano-signer sign --cip8 \
  --data "$KEY" \
  --secret-key /root/share/payment.xsk \
  --address $(cat /root/share/addr.addr) \
  --json-extended \
 | jq .

