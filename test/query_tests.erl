-module(query_tests).

-include_lib("eunit/include/eunit.hrl").

%    {
%        "store": {
%            "book": [
%                {
%                    "category": "reference",
%                    "author": "Nigel Rees",
%                    "title": "Sayings of the Century",
%                    "price": 8.95
%                },
%                {
%                    "category": "fiction",
%                    "author": "Evelyn Waugh",
%                    "title": "Sword of Honour",
%                    "price": 12.99
%                },
%                {
%                    "category": "fiction",
%                    "author": "Herman Melville",
%                    "title": "Moby Dick",
%                    "isbn": "0-553-21311-3",
%                    "price": 8.99
%                },
%                {
%                    "category": "fiction",
%                    "author": "J. R. R. Tolkien",
%                    "title": "The Lord of the Rings",
%                    "isbn": "0-395-19395-8",
%                    "price": 22.99
%                },
%                {
%                    "category": "fiction",
%                    "author": ["Arkady N. Strugatsky", "Boris N. Strugatsky"],
%                    "title": "Monday Begins on Saturday",
%                    "isbn": "0-000-000000-0",
%                    "price": 22.99
%                }
%            ],
%            "bicycle": {
%              "color": "red",
%              "price": 19.95
%            }
%        }
%    }

% jiffy:decode the above produces the term below
-define(JSON,
    {[{<<"store">>,
       {[{<<"book">>,
          [{[{<<"category">>,<<"reference">>},
             {<<"author">>,<<"Nigel Rees">>},
             {<<"title">>,<<"Sayings of the Century">>},
             {<<"price">>,8.95}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"Evelyn Waugh">>},
             {<<"title">>,<<"Sword of Honour">>},
             {<<"price">>,12.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"Herman Melville">>},
             {<<"title">>,<<"Moby Dick">>},
             {<<"isbn">>,<<"0-553-21311-3">>},
             {<<"price">>,8.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"J. R. R. Tolkien">>},
             {<<"title">>,<<"The Lord of the Rings">>},
             {<<"isbn">>,<<"0-395-19395-8">>},
             {<<"price">>,22.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,
              [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]},
             {<<"title">>,<<"Monday Begins on Saturday">>},
             {<<"isbn">>,<<"0-000-000000-0">>},
             {<<"price">>,22.99}]}]},
         {<<"bicycle">>,
          {[{<<"color">>,<<"red">>},{<<"price">>,19.95}]}
         }
    ]}}]}
    ).

level_one_test() ->
    X = jsonq:q([<<"store">>], ?JSON),
    ?assertMatch(
       {[{<<"book">>,
          [{[{<<"category">>,<<"reference">>},
             {<<"author">>,<<"Nigel Rees">>},
             {<<"title">>,<<"Sayings of the Century">>},
             {<<"price">>,8.95}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"Evelyn Waugh">>},
             {<<"title">>,<<"Sword of Honour">>},
             {<<"price">>,12.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"Herman Melville">>},
             {<<"title">>,<<"Moby Dick">>},
             {<<"isbn">>,<<"0-553-21311-3">>},
             {<<"price">>,8.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,<<"J. R. R. Tolkien">>},
             {<<"title">>,<<"The Lord of the Rings">>},
             {<<"isbn">>,<<"0-395-19395-8">>},
             {<<"price">>,22.99}]},
           {[{<<"category">>,<<"fiction">>},
             {<<"author">>,
              [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]},
             {<<"title">>,<<"Monday Begins on Saturday">>},
             {<<"isbn">>,<<"0-000-000000-0">>},
             {<<"price">>,22.99}]}]},
         {<<"bicycle">>,
          {[{<<"color">>,<<"red">>},{<<"price">>,19.95}]}
         }
      ]},
    X),
    ok.

level_two_a_test() ->
    X = jsonq:q([<<"store">>, <<"book">>], ?JSON),
    ?assertMatch([
        {[
            {<<"category">>,<<"reference">>},
            {<<"author">>,<<"Nigel Rees">>},
            {<<"title">>,<<"Sayings of the Century">>},
            {<<"price">>,8.95}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
             {<<"author">>,<<"Evelyn Waugh">>},
             {<<"title">>,<<"Sword of Honour">>},
             {<<"price">>,12.99}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>,<<"Herman Melville">>},
            {<<"title">>,<<"Moby Dick">>},
            {<<"isbn">>,<<"0-553-21311-3">>},
            {<<"price">>,8.99}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>,<<"J. R. R. Tolkien">>},
            {<<"title">>,<<"The Lord of the Rings">>},
            {<<"isbn">>,<<"0-395-19395-8">>},
            {<<"price">>,22.99}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>,
                [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]
            },
            {<<"title">>,<<"Monday Begins on Saturday">>},
            {<<"isbn">>,<<"0-000-000000-0">>},
            {<<"price">>,22.99}
        ]}], X),
    ok.

level_two_b_test() ->
    X = jsonq:q([<<"store">>, <<"bicycle">>], ?JSON),
    ?assertMatch({[
        {<<"color">>,<<"red">>},
        {<<"price">>,19.95}
    ]}, X),
    ok.

level_three_0_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 0], ?JSON),
    ?assertMatch({[
        {<<"category">>,<<"reference">>},
        {<<"author">>,<<"Nigel Rees">>},
        {<<"title">>,<<"Sayings of the Century">>},
        {<<"price">>,8.95}
    ]}, X),
    ok.

level_three_1_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 1], ?JSON),
    ?assertMatch({[
        {<<"category">>,<<"fiction">>},
        {<<"author">>,<<"Evelyn Waugh">>},
        {<<"title">>,<<"Sword of Honour">>},
        {<<"price">>,12.99}
    ]}, X),
    ok.

level_three_2_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 2], ?JSON),
    ?assertMatch({[
        {<<"category">>,<<"fiction">>},
        {<<"author">>,<<"Herman Melville">>},
        {<<"title">>,<<"Moby Dick">>},
        {<<"isbn">>,<<"0-553-21311-3">>},
        {<<"price">>,8.99}
    ]}, X),
    ok.

level_three_3_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 3], ?JSON),
    ?assertMatch({[
        {<<"category">>,<<"fiction">>},
        {<<"author">>,<<"J. R. R. Tolkien">>},
        {<<"title">>,<<"The Lord of the Rings">>},
        {<<"isbn">>,<<"0-395-19395-8">>},
        {<<"price">>,22.99}
    ]}, X),
    ok.

level_three_4_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 4], ?JSON),
    ?assertMatch({[
        {<<"category">>,<<"fiction">>},
        {<<"author">>,
            [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]
        },
        {<<"title">>,<<"Monday Begins on Saturday">>},
        {<<"isbn">>,<<"0-000-000000-0">>},
        {<<"price">>,22.99}
    ]}, X),
    ok.

level_three_5_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 5], ?JSON),
    ?assertMatch(undefined, X),
    ok.

undefined_b_test() ->
    X = jsonq:q([<<"a">>, <<"b">>], ?JSON),
    ?assertMatch(undefined, X),
    ok.

undefined_c_test() ->
    X = jsonq:q([<<"a">>, <<"b">>, 43], ?JSON),
    ?assertMatch(undefined, X),
    ok.

undefined_d_test() ->
    X = jsonq:q([42], ?JSON),
    ?assertMatch(undefined, X),
    ok.

list_a_test() ->
    X = jsonq:q([0], [{<<"a">>, 5}]),
    ?assertMatch({<<"a">>, 5}, X),
    ok.

list_b_test() ->
    X = jsonq:q([1], [{<<"a">>, 5}]),
    ?assertMatch(undefined, X),
    ok.

list_c_test() ->
    X = jsonq:q([<<"store">>, <<"book">>, 4, <<"author">>, 0], ?JSON),
    ?assertMatch(<<"Arkady N. Strugatsky">>, X),
    ok.
