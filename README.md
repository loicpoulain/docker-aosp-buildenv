## Preparations

    $ sudo ./build-aosp-docker
    
## Usage

This docker just executes a bash from which you can build Android in a regular way. Without parameter the current directory will be used as aosp directory and your home .ccache dir will be used for ccache persistent data.

    $ sudo ./run-aosp-docker
    
You can also give argument to define aosp dir (first arg) and an optional ccache dir (second arg)

    $ sudo ./run-aosp-docker /home/workspace/aosp /home/workspace/myccachedir
