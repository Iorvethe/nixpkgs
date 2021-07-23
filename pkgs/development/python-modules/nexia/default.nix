{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, requests
, requests-mock
}:

buildPythonPackage rec {
  pname = "nexia";
  version = "0.9.10";
  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = pname;
    rev = version;
    sha256 = "0k97i243ap1sap5smvfmpsjqzkx5adjvi14awv82pcp52ckzkbi9";
  };

  propagatedBuildInputs = [
    requests
  ];

  checkInputs = [
    requests-mock
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py --replace '"pytest-runner",' ""
  '';

  pythonImportsCheck = [ "nexia" ];

  meta = with lib; {
    description = "Python module for Nexia thermostats";
    homepage = "https://github.com/bdraco/nexia";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
