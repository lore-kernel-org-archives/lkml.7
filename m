Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A0A2147A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arashfotouhi.com header.i=@arashfotouhi.com header.b="bsawDBvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfCWCtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:49:08 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:15436 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727900AbfCWCtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:49:07 -0400
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 22:49:07 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E670C3BCFE1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:28:56 -0500 (CDT)
Received: from box5525.bluehost.com ([162.241.218.13])
        by cmsmtp with SMTP
        id 7WP2hFmALYTGM7WP2hRwop; Fri, 22 Mar 2019 21:28:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=arashfotouhi.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xfpE2ALaR6F8Afq474fwRRXtcYXzHMnJ623icZks8y4=; b=bsawDBvB158Ur+JN6LFCWadUHy
        1/Y0eOkSOD9wa+NbM0zV8uZkoXU0JJtrRefHkB/nYzYwEE8WlcG58teOq6zTUf733SFeWYKTuHMv+
        A+YLY31pq10ek97Jo1Ui9PmhtCzt6D24CwW1bU8mtcX40TUCgQ5tnzbR+aPdviycssUxZiKy1HNUa
        UbJvTT/R6HZ58nJQORfg38+33A2EAuFhmKs/vHncD0m3KW1Y8DvDqL+/HW5VGOwHVOecy8YvaVLZG
        /g3HLtJi/z5tuQb0lvZY4inaqR3W4kQdtvWMbnQYhGop+VMS4MTnZ3zahbd4QfRmnMtGW38s8NhQ1
        ESgE5FxQ==;
Received: from cpe-172-89-201-91.socal.res.rr.com ([172.89.201.91]:59444 helo=ubuntu.localdomain)
        by box5525.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <arash@arashfotouhi.com>)
        id 1h7WP2-001ue7-Gw; Fri, 22 Mar 2019 21:28:56 -0500
From:   Arash Fotouhi <arash@arashfotouhi.com>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, loberman@redhat.com,
        vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org,
        Arash Fotouhi <arash@arashfotouhi.com>
Subject: [PATCH] kernel: watchdog: fixed spelling mistake
Date:   Fri, 22 Mar 2019 19:28:32 -0700
Message-Id: <1553308112-3513-1-git-send-email-arash@arashfotouhi.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5525.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arashfotouhi.com
X-BWhitelist: no
X-Source-IP: 172.89.201.91
X-Source-L: No
X-Exim-ID: 1h7WP2-001ue7-Gw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cpe-172-89-201-91.socal.res.rr.com (ubuntu.localdomain) [172.89.201.91]:59444
X-Source-Auth: arash@arashfotouhi.com
X-Email-Count: 1
X-Source-Cap: bXltaWNybzU7bXltaWNybzU7Ym94NTUyNS5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a spelling mistake.

Signed-off-by: Arash Fotouhi <arash@arashfotouhi.com>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8fbfda9..7e23e5e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -588,7 +588,7 @@ static void lockup_detector_reconfigure(void)
  * Create the watchdog thread infrastructure and configure the detector(s).
  *
  * The threads are not unparked as watchdog_allowed_mask is empty.  When
- * the threads are sucessfully initialized, take the proper locks and
+ * the threads are successfully initialized, take the proper locks and
  * unpark the threads in the watchdog_cpumask if the watchdog is enabled.
  */
 static __init void lockup_detector_setup(void)
-- 
2.7.4

