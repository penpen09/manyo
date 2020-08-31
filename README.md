README

# データベース

モデル名：User

| カラム名| データ型|
|:-------|:-------|
|name            |string |
|email           |string |
|password_digest |string |

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
