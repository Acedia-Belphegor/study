sidekiq
https://qiita.com/tanutanu/items/dabd550e3f969f72d64c

redis
https://qiita.com/hirotakasasaki/items/9819a4e6e1f33f99213c

sidekiq インストール
```
Gemfile
gem 'sidekiq'
```
```
bundle install
```

redis インストール
```
brew install redis
```

redis サーバー起動
```
redis-server
```

sidekiq 起動
```
bundle exec sidekiq -C config/sidekiq.yml
```

sidekiq コンソール起動
```
http://localhost:3000/sidekiq/
```

sample job 作成
```
rails generate job sample
```

rails c からjobを実行(エンキュー)
```
irb(main):001:0> SampleJob.perform_later
Enqueued SampleJob (Job ID: 3434767c-e688-47f1-8b8c-1651eee69b26) to Sidekiq(default)
=>                                                             
#<SampleJob:0x00007fc8b56607a8                                 
 @arguments=[],                                                
 @exception_executions={},                                     
 @executions=0,                                                
 @job_id="3434767c-e688-47f1-8b8c-1651eee69b26",               
 @priority=nil,                                                
 @provider_job_id="9c28785a216081bebf42dae2",                  
 @queue_name="default",                                        
 @successfully_enqueued=true,                                  
 @timezone="UTC"> 
```