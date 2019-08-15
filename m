Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9805C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B129F2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernelthusiast.com header.i=@kernelthusiast.com header.b="AAz3QXgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfHOR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:59:09 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:49033
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731528AbfHOR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:59:08 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 13:59:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelthusiast.com; s=20140924;
        h=message-id:date:subject:cc:to:from:from;
        bh=72iD1l8ny9OkbNhpcgiU4FFUBqOtwt+0hcXw2zkqwMo=;
        b=AAz3QXgTfP4hadrp+tND+8K2ZBP2CVhz65jBVLeJud2Tk2R6EFER3QrBsYS1EWC0JWtfaLYkWXWRN
         8jXef36aH5yY7pX4xvjD3KfLVc8eT7FmXogM3nw/nHuKAiYUBRDFTIlkwQ+3aDdt1W1P0x6m9RNCx3
         VhsS0yk2UEcaSVuM=
X-HalOne-Cookie: 7db38abda4ecec3c90f12d9bc3f0ca9d887f376b
X-HalOne-ID: 2075a044-bf84-11e9-b5ee-d0431ea8bb03
Received: from jacob-MS-7A62 (unknown [105.159.19.48])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2075a044-bf84-11e9-b5ee-d0431ea8bb03;
        Thu, 15 Aug 2019 17:43:02 +0000 (UTC)
Received: by jacob-MS-7A62 (sSMTP sendmail emulation); Thu, 15 Aug 2019 18:43:01 +0100
From:   Jacob Huisman <jacobhuisman@kernelthusiast.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>
Subject: [PATCH] usb: make comment block in line with coding style
Date:   Thu, 15 Aug 2019 18:42:10 +0100
Message-Id: <20190815174210.580-1-jacobhuisman@kernelthusiast.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment block was not in accordance with coding style.
Fixes two checkpatch warnings:
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Jacob Huisman <jacobhuisman@kernelthusiast.com>
---
 drivers/usb/usb-skeleton.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index f101347e3ea3..c31d17d05810 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -35,9 +35,11 @@ MODULE_DEVICE_TABLE(usb, skel_table);
 
 /* our private defines. if this grows any larger, use your own .h file */
 #define MAX_TRANSFER		(PAGE_SIZE - 512)
-/* MAX_TRANSFER is chosen so that the VM is not stressed by
-   allocations > PAGE_SIZE and the number of packets in a page
-   is an integer 512 is the largest possible packet on EHCI */
+/*
+ * MAX_TRANSFER is chosen so that the VM is not stressed by
+ * allocations > PAGE_SIZE and the number of packets in a page
+ * is an integer 512 is the largest possible packet on EHCI
+ */
 #define WRITES_IN_FLIGHT	8
 /* arbitrarily chosen */
 
-- 
2.17.1

