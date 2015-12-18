Ohai.plugin(:Packages) do
  provides 'packages'
  depends 'platform_family'
  require 'date'

  collect_data(:linux) do
    packages Mash.new

    if platform_family.eql?('debian')
      so = shell_out('dpkg-query -W')
      pkgs = so.stdout.split("\n")

      pkgs.each do |pkg|
        pkg = pkg.split("\t")
        packages[pkg[0]] = { 'version' => pkg[1] }
      end
    elsif platform_family.eql?('rhel')
      so = shell_out("rpm -qa --queryformat '%{NAME}: %{VERSION}-%{RELEASE}: %{INSTALLTIME}\n'")
      pkgs = so.stdout.split("\n")

      pkgs.each do |pkg|
        pkg = pkg.split(': ')
        installtime = DateTime.strptime(pkg[2],'%s')
        packages[pkg[0]] = { 'version' => pkg[1], 'installed_time' => installtime }
      end
    end
  end
end
