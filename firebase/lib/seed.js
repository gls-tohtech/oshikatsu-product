const SEEDS_DIR_PATH = "./lib/seeds/firestore"

const { program } = require('commander');
const fs = require('fs');
const { initializeApp } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const { chunk } = require('./utilities')

program
  .option('-h, --host <string>', '接続先のhostを指定します。', 'localhost:8080')
  .option('-c, --credential <string>', '接続に利用するサービスアカウントプロファイルのパスを指定します。', './credentials/dev/service_account.json');
program.parse();

const opts = program.opts();
process.env['FIRESTORE_EMULATOR_HOST'] = opts['host'];
process.env['GOOGLE_APPLICATION_CREDENTIALS'] = opts['credential'];

const app = initializeApp();
const firestore = getFirestore(app);

var filenames = fs.readdirSync(SEEDS_DIR_PATH);
console.log(`found ${filenames.length} files.\n\t${filenames.join("\n\t")}`)

filenames.forEach(filename => {
  const collectionName = filename.split('.').slice(0, -1).join('.');
  var data_str = fs.readFileSync(SEEDS_DIR_PATH + "/" + filename, "utf8");
  var data = JSON.parse(data_str);

  console.log(`import ${filename}.`);

  for (const chunked of chunk(data, 500)) {
    const batch = firestore.batch();
    chunked.forEach(record => {
      batch.create(firestore.collection(collectionName).doc(), record)
    });
    batch.commit();
  }
});


