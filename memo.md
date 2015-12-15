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

#### TODO

- [x] Require Github Access Token
- [ ] update pr
- [ ] release tag create
- [ ] hook script

ghr release start xxx
  - [x] fork develop -> release/xxx
  - [x] pr develop -> release/xxx
ghr release freeze xxx
  - [ ] pr mergable?
  - [ ] pr merge develop -> release/xxx
  - [ ] pr release/xxx -> master
ghr release finish xxx
  - [x] pr mergable?
  - [x] pr merge release/xxx -> master
  - [ ] merge master -> develop
  - [ ] release tag create

ghr feature start xxx
  - [x] fork develop -> feature/xxx
  - [x] pr feature/xxx -> develop

ghr feature finish xxx
  - [x] pr mergable?
  - [x] merge feature/xxx -> develop

ghr hotfix start xxx
  - [ ] fork master -> hotfix/xxx
  - [ ] pr hotfix/xxx -> master

ghr hotfix finish xxx
  - [ ] merge pr hotfix/xxx -> master
  - [ ] merge master -> develop
  - [ ] release tag create
