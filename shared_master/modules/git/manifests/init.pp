class git
{
	exec { 'install git':
		command => 'sudo apt-get install -y git',
		}
}