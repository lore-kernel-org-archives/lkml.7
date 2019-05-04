Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1ACC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E9C206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556963584;
	bh=4xZE1hhgibu5lcOsNSkgzQ4lXnfNOgjAsG93TP2Du3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRTkqyuZY4MNl9ONddgk3mSzFgbP1enK2eEDelt2rQGBD0Sj3HaqRSEVYgzuvPT2S
	 7SM0CdAm7nSMh0wVlGMJSTdsbE5lA8bWPn2RE//S+oMVXbSON4KDfzMzbhCrpxgkbo
	 NgLLCGUuFkYBVo9QLBAokCMfBuVYWXyQh8cY6d7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEDJxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEDJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:53:02 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08B2206DF;
        Sat,  4 May 2019 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556963581;
        bh=4xZE1hhgibu5lcOsNSkgzQ4lXnfNOgjAsG93TP2Du3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIzdCpa6xr5dRpkpZwgR3RpjnexnNhGsahyRYKoLpUbz9RmcYfsAOy/s/bIvXVt9D
         oZ0QY6YKQNnny/W3e4/rkaVqrVsBWn9Dnu2MZZtugW8hSkrBi0CQBt2Tgd6AoPInVd
         s0ycZ8lvH6PgNNuy3E2hXUNLu8a1+lydEdfhhnO0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dmaengine: fsl-edma: Adjust indentation
Date:   Sat,  4 May 2019 11:52:25 +0200
Message-Id: <20190504095225.23883-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504095225.23883-1-krzk@kernel.org>
References: <20190504095225.23883-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation and remove unneeded space after 'return' keyword.  This
fixes checkpatch warning:
    WARNING: Statements should start on a tabstop

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/fsl-edma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 75e8a7ba3a22..d641ef85a634 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -144,21 +144,21 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
-			 return  ret;
+			return ret;
 		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
 				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
-			return  ret;
+			return ret;
 		}
 
 		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
 				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
-			return  ret;
+			return ret;
 		}
 	}
 
-- 
2.17.1

