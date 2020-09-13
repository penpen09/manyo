README

## データベース

モデル名：User

| カラム名| データ型|
|:-------|:-------|
|name            |string |
|email           |string |
|password_digest |string |
|boolean |admin |

モデル名：Task

| カラム名| データ型|
|:-------|:-------|
|title     |string   |
|content   |text     |
|limit_date|datetime |
|status    |integer  |
|priority  |integer  |
|user_id   |bigint  |


モデル名：Label

| カラム名| データ型|
|:-------|:-------|
|name    |string  |
|name    |string  |
|task_id |bigint  |

モデル名：TaksLabel

| カラム名| データ型|
|:-------|:-------|
|task_id |bigint  |
|label_id|bigint  |


## Herokuへのデプロイ手順

1. Herokuにログイン<br>
`$ heroku login`

2. アセットプリコンパイルを行う<br>
`$ rails assets:precompile RAILS_ENV=production`

3. コミットする<br>
```
$ git add -A
$ git commit -m "コミットメッセージ"
```

4. herokuに新しいアプリケーションを作成<br>
`$ heroku create`<br>
（`$ heroku config`でアドレスを確認）

5. 必要であれば Heroku buildpackを追加<br>
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
6. Herokuにデプロイ<br>
`$ git push heroku master`

7. マイグレーションを行う<br>
`$ heroku run rails db:migrate`
