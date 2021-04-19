my $db = $ENV{DB_NAME};
my $host = $ENV{DB_HOST};
my $port = $ENV{DB_PORT};
my $user = $ENV{DB_USER};
my $password = $ENV{DB_PASSWORD};

+{
    'DBI' => [
        "dbi:mysql:dbname=${db};host=${host};port=${port}", $user, $password,
        +{
            mysql_enable_utf8 => 1,
        }
    ],
};
