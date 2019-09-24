<cfscript>
if (isdefined("url.amount") and isnumeric(url.amount)) {
    server.a.forcereward(url.amount);
}
</cfscript>
