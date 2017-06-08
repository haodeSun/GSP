<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jB2ox-2.3.min.js" type="text/javascript"></script>

<script>
    $("#contentTable tbody tr").each(function () {
        if($(this).find("td:eq(3)").html()=="2"){
            return false;
        }
    });
</script>