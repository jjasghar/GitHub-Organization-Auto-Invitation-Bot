from github import Github
import os

token = os.environ.get("TOKEN")
organization_name = os.environ.get("ORG_NAME")

def main():

    with open("../names.txt") as names_file:
        names = names_file.readlines()

    total = 0

    for name in names:
        try:
            gh = Github(token)
            org = gh.get_organization(organization_name)
            ghuser = gh.get_user(name.strip())
            ghlablovers = org.get_team_by_slug("Labrador-Lovers")

            while total < 500:
                try:
                    org.invite_user(ghuser, teams=[ghlablovers])
                    print(f"{name} was successfully invited")
                    total = total + 1
                    if total == 500:
                        break
                except Exception as e:
                    print(f"{name.strip()} failed: {e}")


        except:
            print(f"Error happened with GitHub initial connection")
            exit(1)

    print(f"Successfully invited a total of: {total} people to the org")

if __name__ == "__main__":
    main()
