## 概览
风先生配送平台nodejs的API接口

此分支主要是test dev

## 依赖
* `nodejs`
* `coffee-script`使用`npm install -g coffee-script`安装
* `mocha`使用`npm install -g mocha`
* `nodemon`使用`npm install -g nodemon`

## 使用
1. development `npm start` 或者 `coffee app.coffee`
2. prodcution  `npm run prod`  线上环境

## 脚本
### 测试数据库连通性
到项目根路径执行`DEBUG=testConnect ./bin/testConnect`。返回success则表示数据库可以连通，返回fail则表示数据库暂时无法连接。
### 根据自己写的model自动创建表
到项目跟路径执行`NODE_ENV=development ./bin/syncTableSchema` NODE_ENV待选值有localhost, development和production.分别表示在不同的环境创建表. NOTE: 假如数据库不存在，那么将无法创建表，所以请先创建数据库。
## 流程
1. 本地写好代码提交到git
2. 到gitlab审查代码
3. 到229pull代码
4. 重启服务器 `supervisorctl -c /home/hadoop/config/supervisord.conf restart NodeJS`

## 代码lint
1. 安装[arcanist](https://secure.phabricator.com/book/phabricator/article/arcanist_quick_start/)
2. 使用arc lint进行代码验证

## ceshi
