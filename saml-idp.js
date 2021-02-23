
var cfr = require('cfn-response');
var AWS = require('aws-sdk');
var iam = new AWS.IAM();
var https = require('https');
var fs = require('fs');

exports.handler = function (event, context) {

    console.log(event);
    var resID = event.PhysicalResourceId || context.awsRequestId;
    // Instead of using cloudformation resource properties the env vars will be used
    // var metadataUrl = event.ResourceProperties.metadataUrl;
    // var idpName = event.ResourceProperties.idpName;
    let metadataUrl = process.env.METADATA_URL;
    let idpName = process.env.IDP_NAME;
    var filename = '/tmp/metadata.xml'
    var file = fs.createWriteStream(filename);

    if (event.RequestType == 'Create' || event.RequestType == 'Update') {

        var request = https.get(metadataUrl, function (response) {
            response.pipe(file);
            file.on('finish', function () {
                file.close(function () {
                    let rawdata = fs.readFileSync(filename, 'utf8');
                    if (event.RequestType == 'Update') {
                        var paramslist = {};
                        iam.listSAMLProviders(paramslist, function (err, data) {
                            if (err) cfr.send(event, context, cfr.FAILED, err, resID);
                            else {
                                var arn = '';
                                for (var provider in data.SAMLProviderList) {
                                    if (data.SAMLProviderList[provider].Arn.split('/')[1] == idpName) {
                                        console.log('Update provider. ' + data.SAMLProviderList[provider].Arn + ' already exists.')
                                        arn = data.SAMLProviderList[provider].Arn;
                                    }
                                }
                                if (arn == '') {
                                    var params = { Name: idpName, SAMLMetadataDocument: rawdata };
                                    iam.createSAMLProvider(params, function (err, data) {
                                        if (err) cfr.send(event, context, cfr.FAILED, err, resID);
                                        else cfr.send(event, context, cfr.SUCCESS, data, resID);
                                    });
                                } else {
                                    var params = { SAMLProviderArn: arn, SAMLMetadataDocument: rawdata };
                                    iam.updateSAMLProvider(params, function (err, data) {
                                        if (err) cfr.send(event, context, cfr.FAILED, err, resID);
                                        else cfr.send(event, context, cfr.SUCCESS, data, resID);
                                    });
                                }
                            }
                        });
                    } else {
                        var params = { Name: idpName, SAMLMetadataDocument: rawdata };
                        iam.createSAMLProvider(params, function (err, data) {
                            if (err) cfr.send(event, context, cfr.FAILED, err, resID);
                            else cfr.send(event, context, cfr.SUCCESS, data, resID);
                        });
                    }
                });
            });
        }).on('error', function (err) {
            fs.unlink(filename);
            cfr.send(event, context, cfr.FAILED, err);
        });
    } else if (event.RequestType == 'Delete') {

        var paramslist = {};
        iam.listSAMLProviders(paramslist, function (err, data) {
            if (err) cfr.send(event, context, cfr.FAILED, err, resID);
            else {
                var deleteResource = false;
                var arn;
                console.log(data.SAMLProviderList);
                for (var provider in data.SAMLProviderList) {
                    if (data.SAMLProviderList[provider].Arn.split('/')[1] == idpName) {
                        console.log('Delete provider. ' + data.SAMLProviderList[provider].Arn + ' already exists.')
                        deleteResource = true;
                        arn = data.SAMLProviderList[provider].Arn;
                    }
                }
                var params = { SAMLProviderArn: arn };
                if (deleteResource == true) {
                    iam.deleteSAMLProvider(params, function (err, data) {
                        if (err) cfr.send(event, context, cfr.FAILED, err, resID);
                        else cfr.send(event, context, cfr.SUCCESS, data, resID);
                    });
                } else {
                    cfr.send(event, context, cfr.SUCCESS, { success: 'Provider did not exist' }, resID);
                }
            }
        });
    } else {
        cfr.send(event, context, cfr.FAILED, { error: 'Method not supported' }, resID);
    }
};