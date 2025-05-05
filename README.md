## Skill_Link 

### Companies テーブル（会社）

| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

#### Association
- has_many :users  
- has_many :knowhows, through: :users  
- has_many :quizzes, through: :knowhows  

---

### Users テーブル（Devise使用・管理者区別あり）

| Column              | Type       | Options                          |
|---------------------|------------|----------------------------------|
| name                | string     | null: false                      |
| email               | string     | null: false, unique: true        |
| encrypted_password  | string     | null: false                      |
| company_id          | references | null: false, foreign_key: true   |
| role                | integer    | default: 0（enum使用）           |

#### Association
- belongs_to :company  
- has_many :knowhows  
- has_many :answers  

#### Enum
- `general`（一般ユーザー）
- `admin`（管理者）

---

### Knowhows テーブル（ノウハウ投稿：音声 or キーボード入力）

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| title      | string     | null: false                    |
| body       | text       | ※キーボード入力時のみ         |
| user_id    | references | null: false, foreign_key: true |

#### ActiveStorage
- audio（音声ファイル：任意）

#### Association
- belongs_to :user  
- has_many :quizzes  
- has_many :comments  
- has_many :favorites  

---

### Quizzes テーブル（ノウハウに紐づくクイズ）

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| question       | string     | null: false                    |
| option_1       | string     | null: false                    |
| option_2       | string     | null: false                    |
| option_3       | string     | null: false                    |
| correct_answer | integer    | null: false（1〜3を想定）      |
| knowhow_id     | references | null: false, foreign_key: true |

#### Association
- belongs_to :knowhow  
- has_many :answers  

---

### Answers テーブル（回答履歴）

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| user_id          | references | null: false, foreign_key: true |
| quiz_id          | references | null: false, foreign_key: true |
| selected_option  | integer    | null: false                    |
| correct          | boolean    | default: false                 |

#### Association
- belongs_to :user  
- belongs_to :quiz  