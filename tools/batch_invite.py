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

            try:
                org.invite_user(ghuser, teams=[org.get_team_by_slug("Labrador-Lovers")])
                print(f"successfully invited {name}")
                total = total + 1
            except:
                print(f"Something didn't work for {name}")

        except:
            print(f"Error happened with GitHub intital connection")
            exit(1)

    print(f"Successfully invited a total of: {total} people to the org")

if __name__ == "__main__":
    main()
