-module(jsonq).

-export([q/2]).

q(_, undefined) ->
    undefined;
q([], Obj) ->
    Obj;
q([Key | Rest], {Obj}) ->
    q(Rest, proplists:get_value(Key, Obj));
q([Index | _Rest], []) when is_integer(Index) ->
    undefined;
q([Index | Rest], Obj) when is_integer(Index), is_list(Obj) ->
    case Index < length(Obj) of
        true -> q(Rest, lists:nth(Index + 1, Obj));
        false -> undefined
    end;
q([Key | Rest], Obj) when is_list(Obj) ->
    q(Rest, proplists:get_all_values(Key, Obj)).
