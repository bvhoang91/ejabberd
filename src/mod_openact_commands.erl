-module(mod_openact_commands).

-behaviour(gen_mod).

-include("logger.hrl").
-include("ejabberd.hrl").
-include("ejabberd_commands.hrl").

-export([start/2, stop/1, mod_opt_type/1, depends/2]).

-export([app_conv_create/4, app_conv_retrieve/2]).

-define(RES_CONV, {tuple, [{id, string}, {url, string}, {messages_url, string},
						   {created_at, string},
						   {participants, {list, 
										   {data, {tuple, [{id, string}, 
														   {url, string},
														   {user_id, string},
														   {display_name, string},
														   {avatar_url, string}]}}}},
						   {distinct, string},
						   {metadata, proplist}]}).

start(_Host, _Opts) ->
    ?DEBUG("Hoang --- Start", []),
    ejabberd_commands:register_commands(get_commands_spec()).

stop(_Host) ->
    ejabberd_commands:unregister_commands(get_commands_spec()).

depends(_Host, _Opts) ->
    [].

get_commands_spec() ->
     [#ejabberd_commands{name = app_conv_create, tags = [conv],
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
			result_desc = "Status code: 0 on success, 1 otherwise"},
	  #ejabberd_commands{name = app_conv_retrieve, tags = [conv],
			desc = "Recompile and reload Erlang source code file",
			module = ?MODULE, function = app_conv_retrieve,
			args = [{app_id, binary},
					{convID, binary}],
			args_example = [],
			args_desc = [],
			result = [{v1, {response, empty}},
					  {v2, {response, ?RES_CONV}}],
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"},
	  #ejabberd_commands{name = app_conv_makeasread, tags = [conv],
			desc = "Recompile and reload Erlang source code file",
			module = ?MODULE, function = app_conv_makeasread,
			args = [{app_id, binary},
					{convID, binary},
					{position, integer}],
			args_example = [],
			args_desc = [],
			result = [{v1, {response, {tuple, [{position, integer}]}}},
					  {v2, {response, {tuple, [{id, binary}, {code, integer},
											   {message, binary}, {url, binary}]}}}],
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"},
	  #ejabberd_commands{name = app_conv_delete, tags = [conv],
			desc = "Recompile and reload Erlang source code file",
			module = ?MODULE, function = app_conv_delete,
			args = [{app_id, binary},
					{convID, binary}],
			args_example = [],
			args_desc = [],
			result = [{v1, {response, empty}}],
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"},
	  #ejabberd_commands{name = app_conv_update, tags = [conv],
			desc = "Recompile and reload Erlang source code file",
			module = ?MODULE, function = app_conv_update,
			args = [{app_id, binary},
					{convID, binary}],
			args_example = [],
			args_desc = [],
			result = [{v1, {response, empty}}],
			result_example = ok,
			policy = open,
			result_desc = "Status code: 0 on success, 1 otherwise"}
					  
						 ].

app_conv_create(AppID, Participants, Distinct, Metadata) ->
	Res1 = {<<"id">>, <<"url">>, <<"msg_url">>, <<"time">>, [{<<"idp">>, <<"urlp">>, <<"a">>, <<"b">>, <<"c">>}],
		    <<"true">>, {<<"title">>, <<"fav">>, <<"color">>, <<"likes">>, [<<"likers">>]}},
	Res2 = {<<"id">>, <<"code">>, <<"msg">>, "url", Res1},
    ?DEBUG("Hoang AppID:~p Participants:~p, Distinct:~p, Metadata:~p", [AppID, Participants, Distinct, Metadata]),
    {200, v2, Res2}.

app_conv_retrieve(AppID, ConvID) ->
	Res1 = [],
	Res2 = Res1 = {<<"id">>, <<"url">>, <<"msg_url">>, <<"time">>, [{<<"idp">>, <<"urlp">>, <<"a">>, <<"b">>, <<"c">>}],
		    <<"true">>, {<<"title">>, <<"fav">>, <<"color">>, <<"likes">>, [<<"likers">>]}},
	{200, v2, Res2}.

app_conv_makeasread(AppID, ConvID, Pos) ->
	%% Pos = undefine | integer
	{202, v1, {500}}.

app_conv_delete(AppID, ConvID) ->
	{204, v1, ok}.

mod_opt_type(_) -> [].
