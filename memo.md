Github Release

Githubを利用しているリポジトリでリリース作業を簡略化するためのツールキット

できること

- スクリプトを利用して git-flow に則ったリリース作業
 - プルリクの自動作成
   - master
   - develop
   - release/xxx
   - hotfix/xxx
 - プルリクの自動マージ
 - プルリクの自動更新
   - リリースに何が入るのか自動的に列挙します
 - マージ後のリリースの自動作成

Require Github Access Token

ghr release:start xxx
  - fork develop -> release/xxx
  - pr develop -> release/xxx
  - update pr
ghr release:start xxx
  - pr merge develop -> release/xxx
  - pr release/xxx -> master
  - update pr
ghr release:finish xxx
  - pr merge release/xxx -> master
  - merge master -> develop
  - release tag create

ghr hotfix:start xxx
  - fork master -> hotfix/xxx
  - pr hotfix/xxx -> master
  - update hotfix/xxx

ghr hotfix:finish xxx
  - merge pr hotfix/xxx -> master
  - merge master -> develop
  - release tag create
