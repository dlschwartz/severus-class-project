xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function local:transform($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return $node
            case element (tei:TEI) return local:transform($node/tei:text/node())
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

let $doc := tei:TEI

return 
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>{$doc//tei:teiHeader//tei:titleStmt/tei:title/text()}</title>
            <link rel="stylesheet" href="../CSS/SeverusLetters.css"></link>
            <meta name="viewport" content="width=device-width" initial-scale="1.0"></meta>
        </head>
        <body>
            <div>
                <ul class="nav">
                    <li><a href="./home.xhtml">Home</a></li>
                    <li><a href="{concat("./", substring-before(substring-after(document-uri(), "tei/"), ".xml"), ".xhtml")}">Letter</a></li>
                    <li><a href="./Standoff.xhtml">Persons/Places</a></li>
                </ul>
            </div>
            {local:transform($doc)}
        </body>
    </html>
    
    