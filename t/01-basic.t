use Test;
use Text::Sorensen :ALL;

plan 21;

my $w1 = 'compleat';
my $w2 = 'complete';
my $w3 = 'compition';

my @list = <coalition cognition commotion companion competition compilation completion
            composition compunction computation condition decomposition incompletion>;

my %hash = @list.map: { $_ => .&bi-gram };

my @sd = [7/9, 'competition'],
         [7/9, 'compilation'],
         [7/9, 'composition'],
         [12/17, 'completion'],
         [0.7, 'decomposition'];

my @j = [7/11, 'competition'],
        [7/11, 'compilation'],
        [7/11, 'composition'],
        [6/11, 'completion'],
        [7/13, 'decomposition'];


is-deeply( bi-gram($w1), ("at"=>1,"pl"=>1,"mp"=>1,"co"=>1,"om"=>1,"ea"=>1,"le"=>1).Bag, 'bi-gram routine ok' );


# Sorensen tests
is( sorensen($w1, $w2, $w3), '0.714286 complete', "basic sorenson ok" );

is( sorensen($w1, $w2, $w3, :ge(0)), '0.714286 complete 0.4 compition', "basic sorenson with threshold ok" );

is-deeply( sorensen($w3, @list).head(5).Array, @sd, 'sorensen list processing' );

is-deeply( sorensen($w3, %hash).head(5).Array, @sd, 'sorensen hash processing' );

is-deeply( sorensen($w3, @list, :ge(.75)), @sd[^3].list, 'sorensen list with threshold processing' );

is-deeply( sorensen($w3, %hash, :ge(.75)), @sd[^3].list, 'sorensen hash with threshold processing' );


# Jaccard tests
is( jaccard($w1, $w2, $w3), '0.555556 complete', "basic jaccard ok" );

is( jaccard($w1, $w2, $w3, :ge(0)), '0.555556 complete 0.25 compition', "basic jaccard with threshold ok" );

is-deeply( jaccard($w3, @list).head(5).Array, @j, 'jaccard list processing' );

is-deeply( jaccard($w3, %hash).head(5).Array, @j, 'jaccard hash processing' );

is-deeply( jaccard($w3, @list, :ge(.6)), @j[^3], 'jaccard list with threshold processing' );

is-deeply( jaccard($w3, %hash, :ge(.6)), @j[^3], 'jaccard hash with threshold processing' );


# test Aliases
is-deeply( sorenson($w3, @list).head(5).Array, @sd, 'sorenson alias list processing' );

is-deeply( sorenson($w3, %hash).head(5).Array, @sd, 'sorenson alias hash processing' );

is-deeply( sdi($w3, @list).head(5).Array, @sd, 'sdi alias list processing' );

is-deeply( sdi($w3, %hash).head(5).Array, @sd, 'sdi alias hash processing' );

is-deeply( dsc($w3, @list).head(5).Array, @sd, 'dsc alias list processing' );

is-deeply( dsc($w3, %hash).head(5).Array, @sd, 'dsc alias hash processing' );

is-deeply( dice($w3, @list).head(5).Array, @sd, 'dice alias list processing' );

is-deeply( dice($w3, %hash).head(5).Array, @sd, 'dice alias hash processing' );

done-testing;
