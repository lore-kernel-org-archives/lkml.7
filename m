Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FA7206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfDDRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:25:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:48800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728663AbfDDRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:25:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51F8BACCF;
        Thu,  4 Apr 2019 17:25:08 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH] dmaengine: bcm2835: Drop duplicate capability setting.
Date:   Thu,  4 Apr 2019 19:25:03 +0200
Message-Id: <20190404172503.12155-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/dma/bcm2835-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index ec8a291d62ba..e38b19dd2895 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -891,7 +891,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
-	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = bcm2835_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = bcm2835_dma_free_chan_resources;
-- 
2.20.1

