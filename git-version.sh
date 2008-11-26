#!/usr/bin/env ruby

# Xcode auto-versioning script for git by Andre Arko
#   This script will set your CFBundleVersion number to the name of the most recent
#   git tag, and include the current commit's distance from that tag and sha1 hash

# With tag "v1.0", and two commits since then, the build will be:
#   v1.0 (b2 h12345)

# Create new tags with "git tag <version> -m <message>"

# based on the ruby script by Abizern which was
# based on the git script by Marcus S. Zarra and Matt Long which was
# based on the Subversion script by Axel Andersson

# Uncomment to only run when doing a Release build
# if ENV["BUILD_STYLE"] != "Release"
#   puts "Not a Release build."
#   exit
# end


gitnum = `/usr/bin/env git describe --long`.chomp.split("-")

version = gitnum[0] + " (b#{gitnum[1]} #{gitnum[2]})"

info_file = File.join(ENV['BUILT_PRODUCTS_DIR'], ENV['INFOPLIST_PATH'])
info = File.open(info_file, "r").read

version_re = /([\t ]+<key>CFBundleVersion<\/key>\n[\t ]+<string>).*?(<\/string>)/
info =~ version_re
bundle_version_string = $1 + version + $2

info.gsub!(version_re, bundle_version_string)
File.open(info_file, "w") { |file| file.write(info) }
puts "Set version string to '#{version}'"
