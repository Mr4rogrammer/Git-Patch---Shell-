#!/bin/bash



branch1= "branch1"
branch2= "branch2"

mkdir -p patches/$branch1 patches/$branch2

generate_patches() {
    local branch=$1
    local patch_dir=$2
    git checkout $branch

    git format-patch -1 $branch -o $patch_dir

    submodules=(
        "submodule-1"
        "submodule-2"
        "submodule-3"
    )

    for submodule in "${submodules[@]}"; do
        cd $submodule || continue
        mkdir -p "../../$patch_dir/$submodule"
        git format-patch -1 HEAD -o "../../$patch_dir/$submodule"
        cd - || exit
    done
}

# Generate patches for both branches
generate_patches $branch1 patches/$branch1
generate_patches $branch2 patches/$branch2

echo "Patches for $branch1 and $branch2 have been generated in the patches/ directory."
