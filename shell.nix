with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    curl
    docker
    git
    kubectl
    kind
    (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-secrets ]; })
    kustomize
    jq
    openssh
    ripgrep
    act
    minikube
  ];
  shellHook = ''
    alias gitc="git -c user.email=gburd@symas.com commit --gpg-sign=1FC1E7793410DE46 ."
  '';
}
