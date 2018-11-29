#!/opt/puppetlabs/puppet/lib/ruby

# Puppet Task Name: print_worker_token
#
# @Usage
# You MUST run this task on a UCP manager node.
# Outputs the token need to join the UCP as a worker.
#


# #!/usr/bin/env ruby
# require 'json'
# params = JSON.parse(STDIN.read)
# action = params['action'] || params['_task']
# if ['start',  'stop'].include?(action)
#   `systemctl #{params['_task']} #{params['service']}`
# end

#require 'json'
#params = JSON.parse(STDIN.read)
#puts .to_json



# When a task includes the files property, all files listed in the top-level
# property and in the specific implementation chosen for a target
# will be copied to a temporary directory on that target.
# The directory structure of the specified files will be preserved
# such that paths specified with the files metadata option will be
# available to tasks prefixed with _installdir.
# The task executable itself will be located in its module location
# under the _installdir as well,
# so other files can be found at ../../mymodule/files/
# relative to the task executable's location.

# For example, you can create a task and metadata in a module at ~/.puppetlabs/bolt/site/mymodule/tasks/task.{json,rb}.

# Metadata
{
  "files": ["multi_task/files/rb_helper.rb"]
}

# File resource

# multi_task/files/rb_helper.rb
def useful_ruby
  { helper: "ruby" }
end

# Task

#!/usr/bin/env ruby
require 'json'

params = JSON.parse(STDIN.read)
require_relative File.join(params['_installdir'], 'multi_task', 'files', 'rb_helper.rb')
# Alternatively use relative path
# require_relative File.join(__dir__, '..', '..', 'multi_task', 'files', 'rb_helper.rb')
puts useful_ruby.to_json

# Output

# Started on localhost...
# Finished on localhost:
#   {
#     "helper": "ruby"
#   }
# Successful on 1 node: localhost
# Ran on 1 node in 0.12 seconds


# Task helpers
# To simplify writing tasks, Bolt includes python_task_helper and ruby_task_helper.
# It also makes a useful demonstration of including code from another module.

# Ruby example
# Create task and metadata in a new module at
# ~/.puppetlabs/bolt/site/mymodule/tasks/mytask.{json,rb}.

# Metadata

{
  "files": ["ruby_task_helper/lib/task_helper.rb"],
  "input_method": "stdin"
}

# Task

#!/usr/bin/env ruby
require_relative '../lib/task_helper.rb

class MyTask < TaskHelper
  def task(name: nil, **kwargs)
    { greeting: "Hi, my name is #{name}" }
  end
end

MyTask.run if __FILE__ == $0
