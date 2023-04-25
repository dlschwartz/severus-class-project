<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <sch:pattern>
        
        <sch:rule context="tei:text//tei:persName/@ref">
            <sch:let name="standoff"
                value="doc('https://raw.githubusercontent.com/dlschwartz/sandbox/master/HIST630SampleProject/Standoff.xml')"/>
            <sch:let name="personIDs"
                value="$standoff//tei:listPerson/tei:person/@xml:id"/>
            <sch:let name="personRefValues" value="for $i in $personIDs return concat('#', $i)"/>
            <sch:let name="error" value="."/>
            <sch:assert
                test=". = $personRefValues">
                <sch:value-of select="$error"/> is not an identified person in the standoff markup for 
                Severus' Letters. Acceptable values: <sch:value-of select="string-join($personRefValues, ', ')"/>.
            </sch:assert>
        </sch:rule>
        
        
        <sch:rule context="tei:text//tei:placeName/@ref">
            <sch:let name="standoff"
                value="doc('https://raw.githubusercontent.com/dlschwartz/sandbox/master/HIST630SampleProject/Standoff.xml')"/>
            <sch:let name="placeIDs"
                value="$standoff//tei:listPlace/tei:place/@xml:id"/>
            <sch:let name="placeRefValues" value="for $i in $placeIDs return concat('#', $i)"/>
            <sch:let name="error" value="."/>
            <sch:assert
                test=". = $placeRefValues">
                <sch:value-of select="$error"/> is not an identified person in the standoff markup for 
                Severus' Letters. Acceptable values: <sch:value-of select="string-join($placeRefValues, ', ')"/>.
            </sch:assert>
        </sch:rule>
        
        
        
    </sch:pattern>
    
    
    
</sch:schema>