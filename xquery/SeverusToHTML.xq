xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare variable $doc := tei:TEI;

declare function local:transform($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return $node
            case element (tei:TEI) return 
                <html xmlns="http://www.w3.org/1999/xhtml">{local:transform($node/node())}</html>
            case element (tei:teiHeader) return 
                <head>
                    {local:transform($node/node())}
                    <link rel="stylesheet" href="./CSS/SeverusLetters.css"/>
                    <meta charset="UTF-8"/>
                    <meta name="viewport" content="width=device-width" initial-scale="1.0"/>
                </head>
            case element (tei:fileDesc) return <title>{local:transform($node/tei:titleStmt/tei:title[1]/node())}</title>
            case element (tei:text) return <body>{local:transform($node/node())}</body>
            case element (tei:body) return <div>{local:transform($node/tei:div/node())}</div>
            case element (tei:head) return 
                if ($node/@type eq "main") then <h1>{local:transform($node/node())}</h1>
                else <h2>{local:transform($node/node())}</h2>
            case element (tei:p) return <p>{local:transform($node/node())}</p>
            case element (tei:persName) return 
                <a href="{concat("./Standoff.xhtml", $node/@ref)}">{local:transform($node/node())}</a>
            case element (tei:placeName) return 
                <a href="{concat("./Standoff.xhtml", $node/@ref)}">{local:transform($node/node())}</a>            
            case element (tei:trailer) return <p>{ local:transform($node/node()) }</p>
            
            default return ()
};

local:transform($doc)