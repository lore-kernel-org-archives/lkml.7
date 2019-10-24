Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8A22166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503287AbfJXPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:31:57 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:37828 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503043AbfJXPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:31:57 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id HTXw2100G5USYZQ01TXwNd; Thu, 24 Oct 2019 17:31:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf5g-00079E-Fx; Thu, 24 Oct 2019 17:31:56 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf5g-00087N-Dm; Thu, 24 Oct 2019 17:31:56 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Karsten Keil <isdn@linux-pingi.de>,
        Jiri Kosina <trivial@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] isdn: hfcsusb: Spelling and grammar fixes
Date:   Thu, 24 Oct 2019 17:31:55 +0200
Message-Id: <20191024153155.31162-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "endpoints", "configuration", and "device's".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/isdn/hardware/mISDN/hfcsusb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.h b/drivers/isdn/hardware/mISDN/hfcsusb.h
index e4fa2a2824af067c..7e2bc5068019eb4b 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.h
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.h
@@ -173,8 +173,8 @@ symbolic(struct hfcusb_symbolic_list list[], const int num)
 
 
 /*
- * List of all supported enpoints configiration sets, used to find the
- * best matching endpoint configuration within a devices' USB descriptor.
+ * List of all supported endpoint configuration sets, used to find the
+ * best matching endpoint configuration within a device's USB descriptor.
  * We need at least 3 RX endpoints, and 3 TX endpoints, either
  * INT-in and ISO-out, or ISO-in and ISO-out)
  * with 4 RX endpoints even E-Channel logging is possible
-- 
2.17.1

