package ColorfulLine::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx', {
        text => 'hello',
    });
};

get '/user' => sub {
    my ($c) = @_;
    return $c->render('user.tx', {
        user_id => 1212,
        user_name => 'hoge',
    });
};

1;
