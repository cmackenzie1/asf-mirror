# asf-mirror

Scripts and docs about running an Apache Software Foundation Mirror.

## Installation

### Prerequisites 
- Have data mount at `/data/asf` with at least 150GB of space.

```bash
sudo su
curl https://raw.githubusercontent.com/cmackenzie1/asf-mirror/master/ubuntu/setup_mirror.sh | bash -
```

Yes, the script requires being run with elevated privileges 😬. Always inspect the script first!

## Usage

The ASF Mirror can the be accessed by going to http://localhost/apache/. In this scenario, the mirror is located behind a proxy load balancer to handle the SSL.

The mirror data is updated twice daily. Once at 5 AM and then again at 5 PM server time.