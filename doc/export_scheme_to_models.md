## 概览

将表结构对应成models代码

# 用法

使用[Sequelize-Auto](https://github.com/sequelize/sequelize-auto)这个库替我们完成这个工作。

# example

sequelize-auto -h 192.168.1.217 -d stats_center -u root -x vVAcgs#tg6aZ -p 3306 --dialect "mysql" -o "./modelsTest"

假如要使用--config这个选项, 那么就必须使用[sequelize-auto的pull-request](git@github.com:from-nibly/sequelize-auto.git)
使用config目录下面的init_model_config.json, 这个配置用于sequelize-auto这个库进行初始化的时候添加config对象。

# Note

需要注意全局安装node的mysql库, 使用`npm install -g mysql`
