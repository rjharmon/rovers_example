task :default => [ :test ]

task :test => [ :spec, :cucumber ]

task :spec do
  system('rspec --color --require spec/spec_helper spec $*')
end
task :cucumber do
  system('cucumber features')
end

