package ColorfulLine::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Log::Minimal;
use Data::Page::Navigation;

any '/' => sub {
    my ($c) = @_;

    my $page = $c->req->param('page') || 1;

    my ($colors, $pager) = $c->db->search_with_pager('colors', {}, { page => $page, order_by => { 'id' => 'desc' }, rows => 10 });
    infof('select colors %s', ddf($colors));

    return $c->render('index.tx', {
        colors => $colors,
        pager => $pager,
    });
};

get '/user' => sub {
    my ($c) = @_;
    return $c->render('user.tx', {
        user_id => 1212,
        user_name => 'hoge',
    });
};

post '/post' => sub {
    my ($c) = @_;

    my $color = $c->req->parameters->{color};

    $c->db->insert(colors => {
        value => $color,
    });

    infof('insert color %s', $color);

    return $c->redirect('/');
};

1;
