class MetasploitModule < Msf::Auxiliary

  include Msf::Exploit::Remote::Ftp
  include Msf::Auxiliary::Scanner
  include Msf::Auxiliary::Report
  def initialize

    super(
      'Name'           => 'FTP Version Scanner Customaize module',
      'Description'    => 'Detect  FTP version from target',
      'Author'         => 'Sami',
      'License'        =>  MSF_LICENSE

      )

      register_options(
      [
      Opt::RPORT(21),
      ])
      end

def run_host(target_host)
    connect(true, false)
    if(banner)
    print_status("#{rhost} is running #{banner}")
    report_service(:host => rhost, :port => rport, :name=> "ftp" :info => banner)    end
    disconnect
    end
  end
