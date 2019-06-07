Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D8C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952D620B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfFGLam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:30:42 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:50504 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:30:42 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id MnWg2000L3XaVaC06nWgSq; Fri, 07 Jun 2019 13:30:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4y-0004FR-PI; Fri, 07 Jun 2019 13:30:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4y-0003na-Mv; Fri, 07 Jun 2019 13:30:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] dmaengine: Grammar s/the its/its/, s/need/needs/
Date:   Fri,  7 Jun 2019 13:30:39 +0200
Message-Id: <20190607113039.14560-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c92260b1b8972346..03ac4b96117cd8db 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -61,7 +61,7 @@ static long dmaengine_ref_count;
 /* --- sysfs implementation --- */
 
 /**
- * dev_to_dma_chan - convert a device pointer to the its sysfs container object
+ * dev_to_dma_chan - convert a device pointer to its sysfs container object
  * @dev - device node
  *
  * Must be called under dma_list_mutex
@@ -705,7 +705,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		chan = acpi_dma_request_slave_chan_by_name(dev, name);
 
 	if (chan) {
-		/* Valid channel found or requester need to be deferred */
+		/* Valid channel found or requester needs to be deferred */
 		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
 			return chan;
 	}
-- 
2.17.1

