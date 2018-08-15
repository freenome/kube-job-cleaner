======================
Kubernetes Job Cleaner
======================

Very simple script to delete all completed jobs after X seconds (default: one hour).

Kubernetes jobs are not cleaned up by default and completed pods are never deleted.
Running jobs frequently (like every few minutes) quickly thrashes the Kubernetes API server with unnecessary pod resources. A significant slowdown of the API server can be observed with increasing number of completed jobs/pods hanging around.
To mitigate this, This small ``kube-job-cleaner`` script runs as a CronJob every hour and cleans up completed jobs/pods.

See `Zalando's Running Kubernetes in Production document <https://kubernetes-on-aws.readthedocs.io/en/latest/admin-guide/kubernetes-in-production.html>`_ for more information.

Building the Docker image:

.. code-block:: bash

    $ make

Pushing to the Docker Container Registry:

.. code-block:: bash

    $ make push

Deploying uses files in the kubernetes-deployment repo:

.. code-block:: bash
    
    $ cd <path_to_kubernetes-deployment>
    $ ./bin/deploy.py {dev,production} kube-job-cleaner <image_tag>

There are a few options:

``--success-seconds``
    Number of seconds after successful job completion to remove the job (default: 1 day)
``--failure-seconds``
    Number of seconds after failed job completion to remove the job (default: never)
``--timeout-seconds``
    Kill all jobs after X seconds (default: never)
``--dry-run``
    Do not actually remove any jobs, only print what would be done
    
To change the way this job is run on the clusters, edit `services/kube-job-cleaner/kube-job-cleaner.yaml` in the kubernetes-deployment repo to include the required options.
