xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function local:transform($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return $node
            case element (tei:TEI) return local:transform($node/tei:standOff/node())
            case element (tei:listPerson) return <div><h1>Persons</h1>{local:transform($node/node())}</div>
            case element (tei:listPlace) return <div><h1>Places</h1>{local:transform($node/node())}</div>
            case element (tei:person) return <div><h2 class="namedEntity"><a id="{$node/@xml:id}">{local:transform($node/tei:persName/node())}</a></h2>{local:transform($node/node())}</div>
            case element (tei:place) return <div><h2 class="namedEntity"><a id="{$node/@xml:id}">{local:transform($node/tei:placeName/node())}</a></h2>{local:transform($node/node())}</div>
            case element (tei:gender) return <p>Gender: {local:transform($node/node()) }</p>
            case element (tei:death)  return <p>Death date: {local:transform($node/node()) }</p>
            case element (tei:floruit) return <p>Floruit: {local:transform($node/node()) }</p>
            case element (tei:occupation) return <p>Occupation: {local:transform($node/node()) }</p>
            case element (tei:desc) return <p>Description: {local:transform($node/node()) }</p>
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
                    <li><a href="./1-35.xhtml">Letter</a></li>
                    <li><a href="{concat("./", substring-before(substring-after(document-uri(), "tei/"), ".xml"), ".xhtml")}">Persons/Places</a></li>
                </ul>
            </div>
        {local:transform($doc)}
        </body>
    </html>