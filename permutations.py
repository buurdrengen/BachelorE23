import numpy as np 
def create_permutations(list_jobs, job):
        " Create permutations"
        " [1,2], 3 -> [3,1,2], [1,3,2], [1,2,3]"
        " Input list_jobs and job"
        " list_jobs: A list of the jobs to make permutations of "
        " job: The job that is inserted into the list_jobs "
        " Output list_permutations "
        list_permutations = np.array([])

        for i in range(0,len(list_jobs) + 1):
            #print(i)
            perm = np.copy(list_jobs)
            #print(perm)
            perm = np.insert(perm, i, job)
            list_permutations = np.append(list_permutations,perm)
            #print(list_permutations)
        return list_permutations
print(create_permutations(np.array([1,2]),3))