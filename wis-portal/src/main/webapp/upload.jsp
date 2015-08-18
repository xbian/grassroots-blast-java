<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>GeoJSON and Leaflet</h2>


        <div id="sheetformdiv" class="simplebox ui-corner-all">
            <table class="in">
                <tr>
                    <td>
                        <form method='post'
                              id='sheet_upload_form'
                              action='<c:url value="/wis-portal/upload/importyr/sheet"/>'
                              enctype="multipart/form-data"
                              target="uploadYRSheet"
                              onsubmit="Utils.fileUpload.fileUploadProgress('sheet_upload_form', 'statusdiv', sheetUploadSuccess);">
                            <input type="file" name="file"/>
                            <button type="submit" class="br-button ui-state-default ui-corner-all">Upload</button>
                            <button type="button" class="br-button ui-state-default ui-corner-all"
                                    onclick="cancelSheetUpload();">Cancel
                            </button>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <div id="statusdiv"></div>
    </div>


</div>
</div>

</div>

<script type="text/javascript">

    jQuery(document).ready(function () {
    });

    function sheetUploadSuccess(json) {
        jQuery('#statusdiv').html("Processing...");
        processSheetUpload(json.frameId);
    }

    function cancelSheetUpload() {
        jQuery('#sheetformdiv').css("display", "none");
    }

    function processSheetUpload(frameId) {
        jQuery('#statusdiv').html("Processing...done");

        var iframe = document.getElementById(frameId);
        var iframedoc = iframe.document;
        if (iframe.contentDocument)
            iframedoc = iframe.contentDocument;
        else if (iframe.contentWindow)
            iframedoc = iframe.contentWindow.document;
        var response = jQuery(iframedoc).contents().find('body:first').find('#uploadresponsebody').val();
        if (!Utils.validation.isNullCheck(response)) {
            jQuery('#statusdiv').html(response.toString());
        }
        else {
            setTimeout(function () {
                processSheetUpload(frameId)
            }, 2000);
        }

    }
</script>

<%@ include file="footer.jsp" %>