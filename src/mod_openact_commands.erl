-module(mod_openact_commands).

-behaviour(gen_mod).

-include("logger.hrl").
-include("ejabberd.hrl").
-include("ejabberd_commands.hrl").

-export([start/2, stop/1, mod_opt_type/1, depends/2]).

-export([app_conv_create/4]).

-define(RES_CONV, {tuple, [{id, string}, {url, string}, {messages_url, string},
						   {created_at, string},
						   {participants, {list, 
										   {data, {tuple, [{id, string}, 
														   {url, string},
														   {user_id, string},
														   {display_name, string},
														   {avatar_url, string}]}}}},
						   {distinct, string},
						   {metadata, {tuple, [{title, string}, {favorite, string},
											   {background_color, string},{likes, string},
											   {likers, {list, {data, string}}}]}}]}).

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
			args = [{app_id, binary}, 
				{participants,
				 {list, {name, binary}}},
					{distinct, atom},
				{metadata, proplist}],
			args_example = [],
			args_desc = [],
			result = [{v1, {response, ?RES_CONV}},
				  {v2, {response, 
					{tuple, [{id, string}, 
						 {code, string},
						 {message, string},
						 {url, string},
						 {data, ?RES_CONV}]}}}],
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"}].

app_conv_create(AppID, Participants, Distinct, Metadata) ->
	Res1 = {<<"id">>, <<"url">>, <<"msg_url">>, <<"time">>, [{<<"idp">>, <<"urlp">>, <<"a">>, <<"b">>, <<"c">>}],
		    <<"true">>, {<<"title">>, <<"fav">>, <<"color">>, <<"likes">>, [<<"likers">>]}},
	Res2 = {<<"id">>, <<"code">>, <<"msg">>, "url", Res1},
    ?DEBUG("Hoang AppID:~p Participants:~p, Distinct:~p, Metadata:~p", [AppID, Participants, Distinct, Metadata]),
    {200, v2, Res2}.

mod_opt_type(_) -> [].
