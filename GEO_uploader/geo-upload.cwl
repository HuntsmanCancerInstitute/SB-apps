{
    "class": "CommandLineTool",
    "cwlVersion": "v1.0",
    "$namespaces": {
        "sbg": "https://sevenbridges.com"
    },
    "baseCommand": [
        "ncftpput -V -z -m"
    ],
    "inputs": [
        {
            "sbg:toolDefaultValue": "geo",
            "id": "user",
            "type": "string",
            "inputBinding": {
                "position": 2,
                "prefix": "-u",
                "shellQuote": false
            },
            "doc": "The user for connecting."
        },
        {
            "id": "password",
            "type": "string",
            "inputBinding": {
                "position": 3,
                "prefix": "-p",
                "shellQuote": false
            },
            "doc": "The password. Must log in to NCBI to obtain this password."
        },
        {
            "id": "remote-dir",
            "type": "string",
            "inputBinding": {
                "position": 5,
                "shellQuote": false
            },
            "doc": "The remote directory that the files will be uploaded. It should be unique on the FTP directory. It will be created automatically if it doesn't exist."
        },
        {
            "id": "file",
            "type": "File",
            "inputBinding": {
                "position": 6,
                "shellQuote": false
            },
            "doc": "The file to be uploaded."
        }
    ],
    "outputs": [],
    "label": "GEO upload",
    "arguments": [
        {
            "position": 1,
            "prefix": "-B",
            "shellQuote": false,
            "valueFrom": "33554432"
        },
        {
            "position": 4,
            "prefix": "",
            "shellQuote": false,
            "valueFrom": "ftp-private.ncbi.nlm.nih.gov"
        }
    ],
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        },
        {
            "class": "ResourceRequirement",
            "ramMin": 100,
            "coresMin": 1
        },
        {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/xxx/xxx/geo_uploader:1"
        }
    ],
    "sbg:image_url": null,
    "sbg:appVersion": [
        "v1.0"
    ],
    "sbg:sbgMaintained": false,
    "sbg:validationErrors": [],
    "sbg:latestRevision": 1,
}
