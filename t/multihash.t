#!perl -T
use strict;
use warnings FATAL => 'all';
use Set::Object qw(set);
use Test::More;

BEGIN { plan tests => 11; }

BEGIN {
    use_ok('Data::Multihash');
}

my $multihash = Data::Multihash->new();
is($multihash->size, 0);

for (0..1) {
    $multihash->insert(key1 => 'value1');
    is($multihash->elements('key1'), set('value1'));
    is($multihash->size, 1);
}

$multihash->insert(key2 => 'value1', key3 => 'value1');
is($multihash->elements('key2'), set('value1'));
is($multihash->elements('key3'), set('value1'));
is($multihash->size, 3);

$multihash->insert(key1 => 'value2');
is($multihash->elements('key1'), set('value1', 'value2'));
is($multihash->size, 4);
