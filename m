Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB01C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBBC208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723967;
	bh=XdDXsy0FUsAQasU9sgQ7z5ymRov7zhDTsXYLIODdN4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msa4F+XCLdaN+DM0jeeTAp91m9uxcRGIK4BURJn9CnigV9ijRFn3xvCiakvrZSGeC
	 DjGItuqkspsvXcg9mgBhgyb3pws0962EF52EJY4AG0+NcwdtDW8lnYgRRZ027X3LzQ
	 v5hZGGckhMWwRbSLkz8YpXfTLqYiIslC52Gy/618=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfF1MMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:12:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfF1MMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ji+LEzct1gO+rOUVMv9h3wg1RMldLFrUw4bQiH9G5ho=; b=VY1EuUHpp7+72o3HTNSWm/jI9c
        oB0U5nZudzsoGTCncznFm4oKcbBi6wq+QRC5dCR4U+TWBLvG9H+seGV8GIoMRttBDrrWbGgyz2bFh
        c6WKqg816lE7lhniWouFf3hdk+fnMn0zflcQdd5845uJt8zcERpt3hQUBpb0ZcI4nTGr1oG7E7+of
        oVXZ+ijiyKUX24/rnsUNGV+h1TJ2pjATpRw3BYQNgUTXHEqQyhmR79SODAqpOsuc/iRXUIVteyFLs
        Fwm+QWk7lgoPl6+tT4sCVUJMBTWqs/+odK2avmxXEkrOHKScyJG5X6G7wb59DNGPbVfrxmNEpVpXv
        eAFMv7QA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BU-8g; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zL-6n; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/9] hrtimer: Use a bullet for the returns bullet list
Date:   Fri, 28 Jun 2019 09:12:23 -0300
Message-Id: <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That gets rid of this warning:

	./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.

and displays nicely both at the source code and at the produced
documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 kernel/time/hrtimer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb230aba3d1..5ee77f1a8a92 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
  * @timer:	hrtimer to stop
  *
  * Returns:
- *  0 when the timer was not active
- *  1 when the timer was active
- * -1 when the timer is currently executing the callback function and
+ *
+ *  *  0 when the timer was not active
+ *  *  1 when the timer was active
+ *  * -1 when the timer is currently executing the callback function and
  *    cannot be stopped
  */
 int hrtimer_try_to_cancel(struct hrtimer *timer)
-- 
2.21.0

