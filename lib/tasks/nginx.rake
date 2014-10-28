namespace :nginx do
  task :restart do
    Rake::Task["nginx:build_config"].execute
    %x{pkill nginx} # kills only ones we have access to by default
    %x{nginx -c #{Dir.getwd() + "/upvid.nginx.conf"}}
  end

  task :build_config do
    template = File.read("#{Rails.root}/upvid.nginx.conf.erb")

    @app_root = "#{Rails.root}"

    renderer = ERB.new(template)
    result = renderer.result(binding)

    # Let's write the result out to a file for Charles.
    File.open("#{Rails.root}/upvid.nginx.conf", 'w') {|f| f.write(result) }
  end
end