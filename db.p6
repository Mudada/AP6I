use v6;
use Slang::SQL;
use DBIish;

my $password = '';
my $*DB is export = DBIish.connect();

sql create table if not exists user(
    id		int unsigned not null auto_increment,
    email	varchar(50),
    mdp		varchar(50),
    nom		varchar(50),
    prenom	varchar(50),
    secteur	varchar(50),
    adresse	varchar(50),
    ville	varchar(50),
    metier	varchar(50),
    tel		varchar(50),
    primary key(id)
);

sql create table if not exists salon(
    id		int unsigned not null auto_increment,
    nb_pers	integer,
    type	integer,
    primary key(id)
);

sql create table if not exists commentaires(
    id		 integer auto_increment,
    id_table	 int unsigned not null,
		 constraint
		 foreign key (id_table) references salon(id),
    commentaires varchar(255),
    primary key(id)
);

sql create table if not exists my_space(
    id_table	int unsigned not null,
		constraint
		foreign key (id_table) references salon(id),
    id_user	int unsigned not null,
		constraint
		foreign key (id_user) references user(id)
);
