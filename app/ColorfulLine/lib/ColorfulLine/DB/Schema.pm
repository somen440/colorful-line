package ColorfulLine::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'ColorfulLine::DB::Row';

table {
    name 'colors';
    pk 'id';
    columns qw(id value created modified);
};

1;
