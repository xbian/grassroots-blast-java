<%@ include file="header.jsp" %>

<div class="container center-block">

    <div class="jumbotron">
        <h2>Grassroots Infrastructure Services</h2>

        <p>Services provide the ability to perform one or more operations.
            The Services are completely self-describing, the Server has no prior knowledge or
            need any configuration changes when installing a Service. Simply copy the service
            module into the services directory and it will be available for use straight away.</p>

        <p>Available services:</p>

        <ul>
            <li><a href="<c:url value='/grassroots-portal/blast'/>">Blast searches on HPC</a></li>
            <li>iRODS file management</li>
            <li>Solr indexer</li>
            <li>Elasticsearch indexer</li>
            <li>Geo-location information</li>

        </ul>

    </div>
</div>

</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
    });

</script>

<%@ include file="footer.jsp" %>