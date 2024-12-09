{ config }: {
  branchPrefix = "agelter/";
  branchDate = false;
  allowSlashesInGeneratedBranchNames = false;
  branchReplacement = "-";
  submitIncludeCommitMessages = true;
  alternativeProfiles = [
    {
      name = "default";
      hostPrefix = "";
      authToken = config.sops.placeholder.graphite_corp_token;
    }
    {
      name = "personal";
      hostPrefix = "";
      authToken = config.sops.placeholder.graphite_personal_token;
    }
  ];
}