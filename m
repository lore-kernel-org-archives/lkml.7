Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0882DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC50E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUKZxbQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfHLGzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:55:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PZdszTRyShmFeiL4lAukIzsjrAmPr5ad1fFgyRG+1NI=; b=HUKZxbQ9LoL6T3umVVZKr71Ime
        gjoIrAXfgDzApR2PuWwO1RcvvL94XMEwKj1Twroo+v75acjLcUePDdi0rGmI3SERkFRfYIoLVPht2
        uZCH/B2OODcmg7hH9TULm5W52lRUgRGjSdcqMoFQDDGf1TMw86842yGIbwABXVe+4ypQAbOTSUqUw
        +AHKXTYLqbelvXPaGeAmHHV4pbU30FWXcCCShQHpPkzfH2TxVrpFVYCZdMRbKf1e8h4VGE535DqSa
        gFJ4qCQgL4JsKKpBxBebwOylf5rSSMim3S3Wgt0YDweeWrzvJe35s0le0JxCVloDNvttih5uvbdSr
        67SdguRw==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hx4Es-0000F3-4Y; Mon, 12 Aug 2019 06:55:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ia64: annotate a switch fallthrough in ia64_do_signal
Date:   Mon, 12 Aug 2019 08:55:21 +0200
Message-Id: <20190812065524.19959-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812065524.19959-1-hch@lst.de>
References: <20190812065524.19959-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also reindent the switch statement to use the normal kernel style
while at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index e5044aed9452..d07ed65c9c6e 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -363,19 +363,19 @@ ia64_do_signal (struct sigscratch *scr, long in_syscall)
 
 		if (unlikely(restart)) {
 			switch (errno) {
-			      case ERESTART_RESTARTBLOCK:
-			      case ERESTARTNOHAND:
+			case ERESTART_RESTARTBLOCK:
+			case ERESTARTNOHAND:
 				scr->pt.r8 = EINTR;
 				/* note: scr->pt.r10 is already -1 */
 				break;
-
-			      case ERESTARTSYS:
+			case ERESTARTSYS:
 				if ((ksig.ka.sa.sa_flags & SA_RESTART) == 0) {
 					scr->pt.r8 = EINTR;
 					/* note: scr->pt.r10 is already -1 */
 					break;
 				}
-			      case ERESTARTNOINTR:
+				/*FALLTHRU*/
+			case ERESTARTNOINTR:
 				ia64_decrement_ip(&scr->pt);
 				restart = 0; /* don't restart twice if handle_signal() fails... */
 			}
-- 
2.20.1

