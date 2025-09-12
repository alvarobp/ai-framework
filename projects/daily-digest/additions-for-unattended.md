IMPORTANT: If there are no unread emails in the "Daily Digests" label, do not generate any digest, do not write any files, and do not send any emails. Simply exit with a message saying "No unread emails found in Daily Digests label."

Write down the generated HTML to digests/yyyy-mm-dd.html using today as date in the filename.

If emails could be read and digest was successfully generated, then send an email to `alvarobp@gmail.com` with:

Subject: Daily Digest - <Month> <Day>, <Year>

Body:

```
Daily digest was successfully generated.

<a href="https://alvarobp-digests.s3.eu-west-1.amazonaws.com/daily-digests/2025-09-09.html">Daily Digest - <Month> <Day>, <Year></a>
```

If any part (digest generation, writing file, etc) of the process fails send an email to `alvarobp@gmail.com` with:

Subject: Failed to generate Daily Digest - <Month> <Day>, <Year>
Body: Daily digest failed to generate.

Do not send an email if no emails were read.
