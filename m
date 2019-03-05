Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE23C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC5C20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfCERbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:31:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47469 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCERbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:31:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h1DuL-00083R-Dy; Tue, 05 Mar 2019 17:31:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][bpf-next] bpf: hbm: fix spelling mistake "deault" -> "default"
Date:   Tue,  5 Mar 2019 17:31:13 +0000
Message-Id: <20190305173113.26119-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of typos, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 samples/bpf/hbm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 8408ccb7409f..a79828ab273f 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -18,7 +18,7 @@
  *		Default is /hbm1
  *    -r <rate>	Rate limit in Mbps
  *    -s	Get HBM stats (marked, dropped, etc.)
- *    -t <time>	Exit after specified seconds (deault is 0)
+ *    -t <time>	Exit after specified seconds (default is 0)
  *    -w	Work conserving flag. cgroup can increase its bandwidth
  *		beyond the rate limit specified while there is available
  *		bandwidth. Current implementation assumes there is only
@@ -376,7 +376,7 @@ static void Usage(void)
 	       "               Default is /hbm1\n"
 	       "    -r <rate>  Rate in Mbps\n"
 	       "    -s         Update HBM stats\n"
-	       "    -t <time>  Exit after specified seconds (deault is 0)\n"
+	       "    -t <time>  Exit after specified seconds (default is 0)\n"
 	       "    -w	       Work conserving flag. cgroup can increase\n"
 	       "               bandwidth beyond the rate limit specified\n"
 	       "               while there is available bandwidth. Current\n"
-- 
2.20.1

