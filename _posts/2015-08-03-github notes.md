---
layout: post
title: github notes
date: 2015-08-03
tag: [git, github]
---

# Configuring A records with DNS provider
```
@    185.199.108.153
@    185.199.109.153
@    185.199.110.153
@    185.199.111.153
```

# dig the custom domain to confirm DNS setup
```
$dig +noall +answer wubigo.com
wubigo.com.		285	IN	A	185.199.110.153
wubigo.com.		285	IN	A	185.199.108.153
wubigo.com.		285	IN	A	185.199.111.153
wubigo.com.		285	IN	A	185.199.109.153

```

[https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider](https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider)
