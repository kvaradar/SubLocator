require 'net/ssh'

module SshHelper

  def query_all_names(query)
    host = "localhost"
    dbname = teachers_list
    Net::SSH.start(dbname,query) do |ssh|
     command=  "mysql -uroot #{dbname} -e #{query}"
      puts "command is #{command}"
      result = ssh.exec!(command)
      puts "result is #{result}"
      result
    end
  end
end