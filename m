Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A8AC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0039021479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560883893;
	bh=UToVhpxv2B3cRBjZ2Ta6zwgEzTJxQAz69kDWtudfj1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTvcXR7+2Gn1I/ZNmlbrIxUvaiV+vg+pcMQ54RWfDDshXr5tDDlgQUMSI88ef8VqF
	 1XsScgIOMI9ERYCl+fQuwZfwOqv63LHoW0EzZXqHTrKt07Z9xmeAyRm4rc288kW2nB
	 yBxnrxkUSSGV4FGcbGl5510IW2toCB0JfJtsuCOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfFRSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:51:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfFRSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d0EmehjDEcPvjTqcuyADKrAIO42zpO1/X9qF5qqS+x0=; b=GuL+f1a4TZRQrA4Qhfph4m6U0L
        I+y1AJoGcCHH+KWW/e8A4LCnl+E6J4/RJqw2eyqLykimGPlSc7ywUnvPr4aSDREuCSd7OBLgj+Yw3
        2hDGENHdND/vQJaiV43Lbs4KVomhjLe8TKtNYKwHDt0A5w/z4getVLEWtpUh6v1gTMBfwqktXX5zL
        xTUKeDRKVov9YOqieoYBF/J6kYWXZJnZGZXgB1rBDzX46UsmDXVg3KYYuEGlT0gdii18oKTrBIK1d
        LOodwleO047qiiU0Ps1AApMRVG6TPa9/pC1j3pxO+CiDWHYweaWMz6e0PciI99Xr5fvPlbKvAuf32
        bt3uuHrA==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJCa-0006RH-6Z; Tue, 18 Jun 2019 18:51:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJCW-0006UJ-CP; Tue, 18 Jun 2019 15:51:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/6] time: hrtimer: use a bullet for the returns bullet list
Date:   Tue, 18 Jun 2019 15:51:20 -0300
Message-Id: <a4cab6020e0475e7a4afc65dc5854756dd1bfbe9.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index edb230aba3d1..49f78453892f 100644
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
+ *  •  0 when the timer was not active
+ *  •  1 when the timer was active
+ *  • -1 when the timer is currently executing the callback function and
  *    cannot be stopped
  */
 int hrtimer_try_to_cancel(struct hrtimer *timer)
-- 
2.21.0

