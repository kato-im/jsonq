Querying JSON Terms
-------------------

JSON:

    {"store": {
        "books": [
            {
                "category": "fiction",
                "author": "J. R. R. Tolkien",
                "title": "The Lord of the Rings",
                "isbn": "0-395-19395-8",
                "price": 22.99
            },
            {
                "category": "fiction",
                "author": ["Arkady N. Strugatsky", "Boris N. Strugatsky"],
                "title": "Monday Begins on Saturday",
                "isbn": "0-000-000000-0",
                "price": 22.99
            }
        ],
        "bicycle": {
          "color": "red",
          "price": 19.95
        }
    }}

Erlang JSON term:

    Json = {[{<<"store">>,
        {[{<<"books">>, [
            {[
                {<<"category">>,<<"fiction">>},
                {<<"author">>,<<"J. R. R. Tolkien">>},
                {<<"title">>,<<"The Lord of the Rings">>},
                {<<"isbn">>,<<"0-395-19395-8">>},
                {<<"price">>,22.99}
            ]},
            {[
                {<<"category">>,<<"fiction">>},
                {<<"author">>, [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]},
                {<<"title">>,<<"Monday Begins on Saturday">>},
                {<<"isbn">>,<<"0-000-000000-0">>},
                {<<"price">>,22.99}
            ]}
        ]},
        {<<"bicycle">>, {[
            {<<"color">>,<<"red">>},
            {<<"price">>,19.95}
        ]}
    }]}}]}.

Query example 1:

    jsonq:q([<<"store">>], Json).

    {[{<<"books">>, [
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>,<<"J. R. R. Tolkien">>},
            {<<"title">>,<<"The Lord of the Rings">>},
            {<<"isbn">>,<<"0-395-19395-8">>},
            {<<"price">>,22.99}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>, [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]},
            {<<"title">>,<<"Monday Begins on Saturday">>},
            {<<"isbn">>,<<"0-000-000000-0">>},
            {<<"price">>,22.99}
        ]}
    ]}

Query example 2:

    jsonq:q([<<"store">>, <<"books">>], Json).
    [
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>,<<"J. R. R. Tolkien">>},
            {<<"title">>,<<"The Lord of the Rings">>},
            {<<"isbn">>,<<"0-395-19395-8">>},
            {<<"price">>,22.99}
        ]},
        {[
            {<<"category">>,<<"fiction">>},
            {<<"author">>, [<<"Arkady N. Strugatsky">>,<<"Boris N. Strugatsky">>]},
            {<<"title">>,<<"Monday Begins on Saturday">>},
            {<<"isbn">>,<<"0-000-000000-0">>},
            {<<"price">>,22.99}
        ]}
    ]

Query example 3:

    jsonq:q([<<"store">>, <<"books">>, 0], Json).

    {[
        {<<"category">>,<<"fiction">>},
        {<<"author">>,<<"J. R. R. Tolkien">>},
        {<<"title">>,<<"The Lord of the Rings">>},
        {<<"isbn">>,<<"0-395-19395-8">>},
        {<<"price">>,22.99}
    ]}

Query example 4:

    jsonq:q([<<"store">>, <<"books">>, 1, <<"author">>, 1], Json).

    <<"Boris N. Strugatsky">>

Query example 5:

    jsonq:q([<<"store">>, <<"toys">>], Json).

    undefined
