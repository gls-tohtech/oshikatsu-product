## 追加している機能

- Firestore: Configure security rules and indexes files for Firestore
- Functions: Configure a Cloud Functions directory and its files
- Storage: Configure a security rules file for Cloud Storage
- Emulators: Set up local emulators for Firebase products
  - Authentication Emulator
  - Functions Emulator
  - Firestore Emulator
  - Storage Emulator
  - Emulator UI
- Remote Config: Configure a template file for Remote Config

## Emulator の使い方

https://firebase.google.com/docs/emulator-suite?hl=ja

Emulator では、擬似的に firebase の各機能をローカル環境で再現することができ、
実際の firebase プロジェクトに接続することなく、デバッグなどの検証をすることができます。

### 実行方法

```bash
# functionsに更新がある場合は、事前にビルドしておく
cd ./functions # functionsフォルダに移る
npm run build  # ビルド
cd ..          # firebaseフォルダに戻る

# エミュレーターの起動
firebase emulators:start

# 起動に成功すると以下のような表示がされる
# 各機能のURL（host, port）が表示されるので、ローカル環境ではそこに向けてリクエストを送る
# Emulator UIを使いたい場合は、http://127.0.0.1:4000/ をブラウザで開く
✔  functions: Loaded functions definitions from source: helloWorld.
✔  functions[us-central1-helloWorld]: http function initialized (http://127.0.0.1:5001/oshikatsu-dev-8bb0d/us-central1/helloWorld).

┌─────────────────────────────────────────────────────────────┐
│ ✔  All emulators ready! It is now safe to connect your app. │
│ i  View Emulator UI at http://127.0.0.1:4000/               │
└─────────────────────────────────────────────────────────────┘

┌────────────────┬────────────────┬─────────────────────────────────┐
│ Emulator       │ Host:Port      │ View in Emulator UI             │
├────────────────┼────────────────┼─────────────────────────────────┤
│ Authentication │ 127.0.0.1:9099 │ http://127.0.0.1:4000/auth      │
├────────────────┼────────────────┼─────────────────────────────────┤
│ Functions      │ 127.0.0.1:5001 │ http://127.0.0.1:4000/functions │
├────────────────┼────────────────┼─────────────────────────────────┤
│ Firestore      │ 127.0.0.1:8080 │ http://127.0.0.1:4000/firestore │
├────────────────┼────────────────┼─────────────────────────────────┤
│ Storage        │ 127.0.0.1:9199 │ http://127.0.0.1:4000/storage   │
└────────────────┴────────────────┴─────────────────────────────────┘
  Emulator Hub running at 127.0.0.1:4400
  Other reserved ports: 4500, 9150
```
