let PLUGIN_INFO = xml`
<VimperatorPlugin>
    <name>wallabag</name>
    <description lang="en">Pocket</description>
    <version>0.1.1</version>
    <minVersion>3.2</minVersion>
    <author mail="philipp@schmitt.co" homepage="http://lxl.io">Philipp Schmitt</author>
    <updateURL>https://raw.github.com/pschmitt/vimperator-wallabag/master/wallabag.js</updateURL>
    <detail lang="en"><![CDATA[
        // TODO Documentation
    ]]></detail>
</VimperatorPlugin>`;

(function() {

    let wallabag_url = (liberator.globalVariables.wallabag_url) ? liberator.globalVariables.wallabag_url : '';

    commands.addUserCommand(['wallabag', 'wg'], 'Wallabag plugin',
        function(args) {
            let url = buffer.URL;

            if (typeof args != 'undefined' && args.length > 0) {
                url = args;
            }

            if (wallabag_url == '') {
                liberator.echoerr('Wallabag URL undefined. Please add let g:wallabag_url="http://YOURURL" to your vimperatorrc');
            } else {
                liberator.open(wallabag_url + '/?action=add&url=' + btoa(url), liberator.NEW_TAB);
            }
        }
    );


})();
