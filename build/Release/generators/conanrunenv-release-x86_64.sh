script_folder="/home/tianhao/Documents/workspace_uav/AirMobiSim_libveins/build/Release/generators"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
for v in GRPC_DEFAULT_SSL_ROOTS_FILE_PATH PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH OPENSSL_MODULES
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
    fi
done


export GRPC_DEFAULT_SSL_ROOTS_FILE_PATH="/home/tianhao/.conan2/p/b/grpc1553df62cdfbf/p/res/grpc/roots.pem"
export PATH="/home/tianhao/.conan2/p/b/grpc1553df62cdfbf/p/bin:/home/tianhao/.conan2/p/b/proto27229e4c65db5/p/bin:$PATH"
export LD_LIBRARY_PATH="/home/tianhao/.conan2/p/b/grpc1553df62cdfbf/p/lib:/home/tianhao/.conan2/p/b/proto27229e4c65db5/p/lib:$LD_LIBRARY_PATH"
export DYLD_LIBRARY_PATH="/home/tianhao/.conan2/p/b/grpc1553df62cdfbf/p/lib:/home/tianhao/.conan2/p/b/proto27229e4c65db5/p/lib:$DYLD_LIBRARY_PATH"
export OPENSSL_MODULES="/home/tianhao/.conan2/p/b/opens949bdb947364a/p/lib/ossl-modules"