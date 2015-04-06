# @todo 这个文件的内容能够自动生成
# 所有的路由
module.exports = [
  '/nc'

  # 商户相关
  require './mall/shops'
  require './mall/business_district'

  # 百度相关
  require './baidu/map_server'

  # 用户相关
  require './user_center/deliver'
  require './user_center/deliver_team'

  # 商户其他相关 f_db_user_sh
  require './f_db_user_sh/withdraw'

  require './f_db_event_ps/event_ps'

  # 统计
  require './stat/city'
  require './empire/outexcel'

  # 风帝国相关
  require './empire/login'
  require './empire/department_structure'
  require './empire/daily_report'
  require './empire/role'
  require './empire/authority'
  require './empire/user'
  require './empire/comment'
  require './empire/reimbursement'
  require './empire/company_file'
  require './empire/news'
]
