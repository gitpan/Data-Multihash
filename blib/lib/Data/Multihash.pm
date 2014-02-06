package Data::Multihash;
use 5.006;
use strict;
use warnings FATAL => 'all';
use Set::Object qw(set);

=head1 NAME

Data::Multihash - A hash table that supports multiple values per key.

=head1 SYNOPSIS

  use Data::Multihash;

  my $multihash = Data::Multihash->new();
  $multihash->insert(key => 'value', key => 'other_value');
  $multihash->insert(other_key => 'value');

  print 'There are ' . $multihash->size . ' elements in the multihash.';

=head1 DESCRIPTION

This module implements a multihash, which maps keys to sets of values.
Multihashes are unordered.

=cut

our $VERSION = '0.01';

=head1 CONSTRUCTORS

=head2 new()

Create a new empty multihash.

=cut

sub new {
    my ($class, $self) = (shift, {});
    bless $self, $class;
}

=head1 INSTANCE METHODS

=head2 insert([list])

Insert key-value pairs.

=cut

sub insert {
    my ($self, @pairs) = @_;
    for (my $i = 0; $i < @pairs; $i += 2) {
        my ($key, $value) = @pairs[$i, $i + 1];
        $self->{$key} = set() unless $self->{$key};
        $self->{$key}->insert($value);
    }
}

=head2 elements($key)

Return all elements associated with a key.

=cut

sub elements {
    my ($self, $key) = @_;
    $self->{$key} || set();
}

=head2 size

Return the number of values in the multihash.

=cut

sub size {
    my $self = shift;
    my $result = 0;
    $result += $_->size for (values %$self);
    $result;
}

1;
