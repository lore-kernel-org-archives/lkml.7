Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFABC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BA020674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561372413;
	bh=XdDXsy0FUsAQasU9sgQ7z5ymRov7zhDTsXYLIODdN4g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AaKfPsVk75ZTaccR0EER3oyF4PtpF1U92Aak7Im5J7O8tvQcDqjwtWIp+sBI+AKcx
	 RyIM14S7O2/DoGhGMYRU3+KwR4/q89wpylIDejvrWdq7efkMkfakKhAW/2nv4BcJB+
	 AVSRGapYo4SUUwupY7bXQ0/d5XWv8SYLIbsECjO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfFXKdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:33:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfFXKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ji+LEzct1gO+rOUVMv9h3wg1RMldLFrUw4bQiH9G5ho=; b=iLuLhSOpmo6D8kgU3V7uAJluY
        wMIfFofNzeYXOzbFw/B8nKOQhZjGHzJyNHjrBAPxMjJUT00VKvqLpW/lV3r7LU0evHsvXtAiTqqUE
        eLcF2i1Bd824sdMtNXZgAoeWTzhn4RZBMDK722T2Pd1gU/cZXCS7y75AvI6Rno1tsCFq9wu7NH119
        g8h9W/YzABEnfhJmF6BVXVHS+ievQpq1n+JD8bq0plJto7xLTwE9MlT/P6LT9dswNT4yWq3cEBKw+
        8i/HKdbFmLDdlhiLd9BT0qbs1ToC6FvbgA5p/poh66m/iIa+T2F1K0gEl5JXns4I0d5533QIwjH5O
        E7hYj6ILw==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfMHz-0008JI-2d; Mon, 24 Jun 2019 10:33:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hfMHw-0005PY-Kh; Mon, 24 Jun 2019 07:33:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] hrtimer: Use a bullet for the returns bullet list
Date:   Mon, 24 Jun 2019 07:33:26 -0300
Message-Id: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
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


