Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F0C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EE62063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y1Lni35a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfF0Vqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:46:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Vqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:46:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RLk9Zv463188
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 14:46:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RLk9Zv463188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561671969;
        bh=hgK9iD1YVv2yXUV1Tls5bhcWo2VSsYpkJI2AtB3v5YY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y1Lni35aDs6F+unrV3odh79d48bbH/FPKKIYjZtfvTnxKtRHYr2utoAAqbRbVJcgh
         ols3lkYiWtHMjsfkDy7LEKxo4RlYeUNrOWy0eFMp5qZAzaqsNkq2iVP+NdwWLaHU5S
         wIco3Or5xZv/Ks90zSZCkIK1Joyac406IuPogxrPnHjhxTi8bbXphbnIzRnPCaKpxA
         rmL/GVeMeTjmnQ3mHgDOmIzvK6mb0HmfTGV+Omxh63sLay4tW1e/eZYlruF4W61h+z
         30QUxJulqnV3ToiaROr3gnEk9Q+PkDTXxm2F87YZo9UFGL6w4GmQLCBEWbQOUViLWi
         9R+y6/hGJdjMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RLk7Yw463184;
        Thu, 27 Jun 2019 14:46:07 -0700
Date:   Thu, 27 Jun 2019 14:46:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mauro Carvalho Chehab <tipbot@zytor.com>
Message-ID: <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
Cc:     mchehab+samsung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        mchehab@infradead.org, corbet@lwn.net, linux-doc@vger.kernel.org
Reply-To: corbet@lwn.net, linux-doc@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, mchehab@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org
In-Reply-To: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
References: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Use a bullet for the returns bullet list
Git-Commit-ID: 516337048fa40496ae5ca9863c367ec991a44d9a
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

Commit-ID:  516337048fa40496ae5ca9863c367ec991a44d9a
Gitweb:     https://git.kernel.org/tip/516337048fa40496ae5ca9863c367ec991a44d9a
Author:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
AuthorDate: Mon, 24 Jun 2019 07:33:26 -0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 23:30:04 +0200

hrtimer: Use a bullet for the returns bullet list

That gets rid of this warning:

   ./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.

and displays nicely both at the source code and at the produced
documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Link: https://lkml.kernel.org/r/74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org

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
