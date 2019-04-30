Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9A720652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L97/G9Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfD3O4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:56:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:56041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3O4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556636192;
        bh=hAUJrTaBapcQ9hc/LH8HF7oC+ZXLhDBze5viYYmEnNo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=L97/G9AoXUJJ6XMeWsiMey7IQOIHXdXsxlyBe9kGUHoelU93PipJPcdrrYB/PNBmM
         W4R3iR0FYJmjM0hLF0VMRV9yn/eDXAyGqqw9/JJjYD1eP0dXMbBxs5D0l4loIci/iE
         oL7yMLTnM2zLievOkwb8L3j1xUHetV6qsjbvXstc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.66]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1h62no0bqi-00OIxu; Tue, 30
 Apr 2019 16:56:32 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware_loader: Fix a typo ("syfs" -> "sysfs")
Date:   Tue, 30 Apr 2019 16:56:10 +0200
Message-Id: <20190430145610.1291-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AONg5Jtm0GTZCzz+AuIusXlmLI593lTw4KHVw/fjDpKodSosTT8
 9D9BqFZ8DiDBA8274ZCkw3ihWm7iJhpyWj4eWLM1oKvcpxCq7xjx0W6SSWBIS1P+0H9i0rY
 L+X0LtDtLWIAGo9t0Cgz/+29a+wOg+nbiCruKTQ+iCNjvhL8R4nID6FtxFKFqSTqdedZHGo
 pQ58xtVoV+NU+vjviHqaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xl3ViHjlZsY=:J2SczbleUPwgZ9KM9LgvjW
 qtt0CAvdi8om1Lf9UdaFnqmVBtgu1UAyiQ9WfUwCvKSOHmCLXxGPAzbX+U4xAvxwzWyQr+C1q
 af7l88vHHs+FohJ/UcyUG5UeigwX9i47w6ECCz+f5u3qfMamraDCTHdA2cAtPDRRL6N1n4V66
 JPoSS6B5xj5blz2uGehHIvdMCam4b26jxNyJ/1/72s+dVgUeJP1SKhccHwoNp00f3/cH0xlfj
 Mk2J88Fh0VELy9ZnGhRZjIzxjqwiqSwwxXT+0ScLWyUrpY+caY+z/67bJdcbN9W8PjR3C7CeA
 hnL2M92WGaQIxzYQMuELt5o2toZoNEd+dGbpZ0uq+67knFblxsSxUb5kd8UqYbWkOEWDv/Y87
 QiJNh2NhIxRSAxKtHG4PHHlBQipJEOI0pXEI+6Re6R83eEEBdOzd9D7GYSQRlPtM6dSw+1FLR
 5+NbK1q3LviBMHRjl2vj/fVg1VykZTY+WDmNJn1fSzdBvaYg2trTwd39b6Aqz8jwr2Fsul1XW
 lza5qElmVH83lJ7qFqX2BQX6X+XvAacb9IjBBiueagu6PJqOHbsiL7OOquVOwKnYYl0q0SIZY
 zxLytxiM9q2uJIXOyTmWeLoM3EB0hqx0oG1DhYNOT/yy3n8IyP/kvutO0PjpXy00rhgvuLYxT
 l6Da49cWAcn3ufr0y9syHy5Rrgmzwejs/DWSPDohQv6O3CSUW9Na10255RNT3x2H9ln6/J2S9
 GHkektaIkGZxjjLW9MKUliZ9Xe2IY1+W6kTH8h/ZpLO1BzKLL6VbOVXcLZ1jiT9wEV2U+rvr8
 5+YN3WEHcu86v6KDPnINAK0T3IpACHHMXQzpF7dSsNxsP4vXrQCop1BeYfBlSlvIVGpat1Kmc
 I7bb8OngciX8aAyZP73OAkkD2E/NHaKfez5HmqJ6Bu15aqakvZ+mJa9hl7j30gM8XI/KKQigj
 9g3uCTYLVIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"sysfs" was misspelled in a comment and a log message.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/base/firmware_loader/fallback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmwa=
re_loader/fallback.c
index b5c865fe263b..f962488546b6 100644
=2D-- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -674,8 +674,8 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flag=
s)
  *
  * This function is called if direct lookup for the firmware failed, it e=
nables
  * a fallback mechanism through userspace by exposing a sysfs loading
- * interface. Userspace is in charge of loading the firmware through the =
syfs
- * loading interface. This syfs fallback mechanism may be disabled comple=
tely
+ * interface. Userspace is in charge of loading the firmware through the =
sysfs
+ * loading interface. This sysfs fallback mechanism may be disabled compl=
etely
  * on a system by setting the proc sysctl value ignore_sysfs_fallback to =
true.
  * If this false we check if the internal API caller set the @FW_OPT_NOFA=
LLBACK
  * flag, if so it would also disable the fallback mechanism. A system may=
 want
@@ -693,7 +693,7 @@ int firmware_fallback_sysfs(struct firmware *fw, const=
 char *name,
 		return ret;

 	if (!(opt_flags & FW_OPT_NO_WARN))
-		dev_warn(device, "Falling back to syfs fallback for: %s\n",
+		dev_warn(device, "Falling back to sysfs fallback for: %s\n",
 				 name);
 	else
 		dev_dbg(device, "Falling back to sysfs fallback for: %s\n",
=2D-
2.20.1

