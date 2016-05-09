use v6;
use Bailador;
use Slang::SQL;
use DBIish;
use JSON::Tiny;

my $password = '';
my $*DB = DBIish.connect();

post '/insert_user' => sub {

    if (!get_info_user(request.params<email>)) {
	sql insert into user (email, mdp, nom, prenom, secteur, adresse, ville, metier, tel)
	values (?, ?, ?, ?, ?, ?, ?, ?, ?);
	with (request.params<email>, request.params<mdp>, request.params<nom>,
	      request.params<prenom>, request.params<secteur>, request.params<adresse>,
	      request.params<ville>, request.params<metier>, request.params<tel>);
    }
    else {
	return (False);
    }
}

post '/create_table' => sub {

    sql insert into salon (nb_pers, type)
    values (?, ?);
    with (request.params<nb_pers>, request.params<type>);
}

post '/create_com' => sub {

    sql insert into commentaires (id_table, commentaires)
    values (?, ?);
    with (request.params<id_table>, request.params<commentaires>);
}

post '/create_space' => sub {

    sql insert into my_space (id_table, id_user)
    values (?, ?);
    with (request.params<id_table>, request.params<id_user>);
}

post '/get_info_user' => sub {

    my $email = request.params<email>;
    if (get_info_user($email)~~"") {
	return (False);
    }
    else {
	return (True);
    }
    
};

post '/get_info_space' => sub {

    my $id_user = request.params<id_user>;
    my $db  = 'select * from my_space where id_user=?';
    my $do = $*DB.prepare($db);
    $do.execute($id_user);
    my %row = $do.fetchrow_hashref;
    return (to-json {%row});
};

post '/get_info_table' => sub {

    my $id = request.params<id>;
    my $db  = 'select * from salon where id=?';
    my $do = $*DB.prepare($db);
    $do.execute($id);
    my %row = $do.fetchrow_hashref;
    return (to-json {%row});
};

sub get_info_user ($email) {

    my $db  = 'select * from user where email=?';
    my $do = $*DB.prepare($db);
    $do.execute($email);
    my %row = $do.fetchrow_hashref;
    return (%row);
}

baile;