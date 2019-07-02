Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347DC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662FB21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kvj70JGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfGBGql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:46:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfGBGqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:46:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x626kPN42679416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 1 Jul 2019 23:46:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x626kPN42679416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562049985;
        bh=tc+3MGWwOPGFUeNmkK7snJSdzpY37HasBC67eFECo2o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Kvj70JGiGoAX+Xl1M8h4Y6zd4BIU+UKFQ2ad3ga93vy2Ar6PMdKQ3uuGMgIwjIkoL
         Yoh6kz3XroQx9KmaoHf4aN9WekPZ/SMBDUSbROhRG/2azl0cDaCoXvOBrMVcXKX8vN
         acVxcSYZVytT+AqKBK/VnBIX5yaemUTYKVst6Iq++Pw0C8/Mqv0fSYd6i5/tKwfgIS
         3fIHozsWMSnR0wIg2aq6ujeyBQzvaMboeYOrMtEUChQ0HFeGpEOXmvMoGcQJKSdD4t
         aqrw8chKiGLvVHJjCm4y8fvUMszu0sO+Yl95dHD34kH2L8k6cQATYZFzGI6JDlQz4C
         Fu4ecm5YHbMqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x626kO8l2679413;
        Mon, 1 Jul 2019 23:46:24 -0700
Date:   Mon, 1 Jul 2019 23:46:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-ede7c247abfaeef62484cfff320b072ec2b1dca0@git.kernel.org>
Cc:     ferdinand.blomqvist@gmail.com, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        hulkci@huawei.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          hulkci@huawei.com, mingo@kernel.org, yuehaibing@huawei.com,
          ferdinand.blomqvist@gmail.com
In-Reply-To: <20190702061847.26060-1-yuehaibing@huawei.com>
References: <20190702061847.26060-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: Make some functions static
Git-Commit-ID: ede7c247abfaeef62484cfff320b072ec2b1dca0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ede7c247abfaeef62484cfff320b072ec2b1dca0
Gitweb:     https://git.kernel.org/tip/ede7c247abfaeef62484cfff320b072ec2b1dca0
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Tue, 2 Jul 2019 14:18:47 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Jul 2019 08:41:37 +0200

rslib: Make some functions static

Fix sparse warnings:

lib/reed_solomon/test_rslib.c:313:5: warning: symbol 'ex_rs_helper' was not declared. Should it be static?
lib/reed_solomon/test_rslib.c:349:5: warning: symbol 'exercise_rs' was not declared. Should it be static?
lib/reed_solomon/test_rslib.c:407:5: warning: symbol 'exercise_rs_bc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <ferdinand.blomqvist@gmail.com>
Link: https://lkml.kernel.org/r/20190702061847.26060-1-yuehaibing@huawei.com

---
 lib/reed_solomon/test_rslib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index eb62e0393c80..4eb29f365ece 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -310,8 +310,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
 	stat->nwords += trials;
 }
 
-int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
-		int len, int trials, int method)
+static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
+			int len, int trials, int method)
 {
 	static const char * const desc[] = {
 		"Testing correction buffer interface...",
@@ -346,8 +346,8 @@ int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
 	return retval;
 }
 
-int exercise_rs(struct rs_control *rs, struct wspace *ws,
-		int len, int trials)
+static int exercise_rs(struct rs_control *rs, struct wspace *ws,
+		       int len, int trials)
 {
 
 	int retval = 0;
@@ -404,8 +404,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
 	stat->nwords += trials;
 }
 
-int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
-		int len, int trials)
+static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
+			  int len, int trials)
 {
 	struct bcstat stat = {0, 0, 0, 0};
 	int nroots = rs->codec->nroots;
