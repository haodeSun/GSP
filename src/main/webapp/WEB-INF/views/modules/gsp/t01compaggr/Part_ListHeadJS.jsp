<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function () {

    });
    function exportThis(){

        var exportIds="";

        $('#contentTable tbody input[type="checkbox"]').each(function(){
            if(this.checked == true){
                exportIds+=$(this).attr("data-id").trim()+",";
            }
        });
        $("#exportIds").val(exportIds);

        var exportUrl=$("#exportUrl").val();

        var searchUrl= $("#searchForm").attr("action");
        $("#searchForm").attr("action", exportUrl);
        $("#searchForm").submit();
        $("#searchForm").attr("action", searchUrl);
    }
</script>