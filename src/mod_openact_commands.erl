-module(mod_openact_commands).

-behaviour(gen_mod).

-include("logger.hrl").
-include("ejabberd.hrl").
-include("ejabberd_commands.hrl").

-export([start/2, stop/1, mod_opt_type/1, depends/2]).

-export([app_conv_create/1]).


start(_Host, _Opts) ->
    ?DEBUG("Hoang --- Start", []),
    ejabberd_commands:register_commands(get_commands_spec()).

stop(_Host) ->
    ejabberd_commands:unregister_commands(get_commands_spec()).

depends(_Host, _Opts) ->
    [].

get_commands_spec() ->
     [#ejabberd_commands{name = app_conv_create, tags = [erlang],
			desc = "Recompile and reload Erlang source code file",
			module = ?MODULE, function = app_conv_create,
			args = [{abc, string}],
			args_example = [],
			args_desc = [],
			result = {res, rescode},
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"}].

app_conv_create(Abc) ->
    ?DEBUG("Hoang ABC:~p", [Abc]),
    {ok, 0}.

mod_opt_type(_) -> [].
