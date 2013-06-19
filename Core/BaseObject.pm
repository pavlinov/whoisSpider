=head1 NAME

Core::BaseObject

=head1 DESCRIPTION

This is base class for inheritance in other classes

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

package Core::BaseObject;

use strict;
use warnings;
use config;
use Data::Dumper;

=head1 VERSION

version 0.02

=cut

our $VERSION = '0.02';

=head1 METHODS

=head2 new

	Constructor
	Inialize following hash:
		"DEBUG"   - debug path
		"LOGPATH" - loging path,
		"LOGNAME" - loging name,
		"LOG"     - loging turn on or off,
		"ERROR"   - error string

=cut

sub new {
	my ($proto) = shift;
	my ($class) = ref($proto) || $proto;
	my ($self)  = {};

	$self = {
		"DEBUG"   => DEBUG,
		"LOGPATH" => LOGPATH,
		"LOGNAME" => LOGNAME,
		"LOG"     => LOG,
		"ERROR"   => ""};

	bless ($self, $class);
	return $self;
}

=head2 setError

	Set error string

	Arguments (required):
		error - string

=cut

sub setError {
	my ($self) = shift;
	my ($error) = @_;

	$self->debug("setError: " . $error);

	$self->{"ERROR"} = shift;

	return 1;
}

=head2 getError

	Get error string

=cut

sub getError {
	my ($self) = shift;

	return $self->{"ERROR"};
}

=head2 debugMode

	Get info about debug mode

=cut

sub debugMode {
	my ($self) = shift;

	return $self->{"DEBUG"};
}


=head2 debug

	Logging and prints debug messages

	Arguments (required):
		string or list

=cut

sub debug {
	my ($self) = shift;

	if ($self->{"DEBUG"} == 1) {
		print join("", @_) . "\n";
	}

	return 1 unless ($self->{"LOG"} == 1);

	my ($sec, $min, $hour, $mday, $mon, $year) = localtime(time());
	my ($date) = sprintf("%d%02d%02d", $year + 1900, $mon + 1, $mday);

	local(*LOGFILE);
	if (!open(LOGFILE, ">>" . $self->{"LOGPATH"} 
			. $self->{"LOGNAME"} . ".". $date . ".log")) {
		print "WARNING: Can't open log file:", $!, "\n";
		return undef;
	}

	print LOGFILE sprintf("[%02d:%02d:%02d] %s\n", $hour,
				$min, $sec, join("", @_));

	close(LOGFILE);

	return 1;
}

=head2 dumpVar

	Get dumped content of any variable

	Arguments (required):
		string, list, hash, ref

=cut

sub dumpVar {
	my ($self) = shift;

	$self->debug(Dumper(@_));

	return 1;
}

1;

