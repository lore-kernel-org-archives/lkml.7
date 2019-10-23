Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA150CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771462086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIfO1rYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfJWD5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:57:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWD5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pOPhMl13JOcU34vSF+PGWK0TLfdWSZkNf3ZBTG2OMRU=; b=gIfO1rYa8ZZfsCcZ6ldbDmvoU
        AwQ3f9kl8l+wxNQSXq3t11pxzaZLEVKr2UfkHcktTDCZSzz9LbtU5Xvgk0MZgcyx07RXpmI7EEbBY
        ttD1D3Eosw2hZwG0Mhc/LQ0u1CijKDeT/FBklOMpyLg5c7rFmd51vXvFxNsMIrfsN+Zw02P+D3i2D
        2vycJgDoB1p2ABSmp39g045VspQkNOsX/AIyD9Q/0ofSXp8wUxGRImHFFGG0GpTVDxTPWNjelmV1o
        xd1XKmsLW6eX+Q05rn0tNngScmGCNNa0UF/JVxinn/eDxpPqA9nG+BOKTj6aGrsKjUo6frSR6nQk0
        hRsAqq/Eg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN7lj-000523-3f; Wed, 23 Oct 2019 03:57:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] reset: fix kernel-doc warnings
Message-ID: <6e166445-2a3d-dd4d-22ea-3ab77d3d3b11@infradead.org>
Date:   Tue, 22 Oct 2019 20:57:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings discovered in the reset controller API chapter.
Fixes these warnings:

./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
./drivers/reset/core.c:838: warning: Function parameter or member 'node' not described in 'of_reset_control_get_count'
./include/linux/reset-controller.h:45: warning: Function parameter or member 'con_id' not described in 'reset_control_lookup'
./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c             |    4 ++--
 include/linux/reset-controller.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20191022.orig/drivers/reset/core.c
+++ linux-next-20191022/drivers/reset/core.c
@@ -76,7 +76,6 @@ static const char *rcdev_name(struct res
  * of_reset_simple_xlate - translate reset_spec to the reset line number
  * @rcdev: a pointer to the reset controller device
  * @reset_spec: reset line specifier as found in the device tree
- * @flags: a flags pointer to fill in (optional)
  *
  * This simple translation function should be used for reset controllers
  * with 1:1 mapping, where reset lines can be indexed by number without gaps.
@@ -823,9 +822,10 @@ int __device_reset(struct device *dev, b
 }
 EXPORT_SYMBOL_GPL(__device_reset);
 
-/**
+/*
  * APIs to manage an array of reset controls.
  */
+
 /**
  * of_reset_control_get_count - Count number of resets available with a device
  *
--- linux-next-20191022.orig/include/linux/reset-controller.h
+++ linux-next-20191022/include/linux/reset-controller.h
@@ -7,7 +7,7 @@
 struct reset_controller_dev;
 
 /**
- * struct reset_control_ops
+ * struct reset_control_ops - reset controller driver callbacks
  *
  * @reset: for self-deasserting resets, does all necessary
  *         things to reset the device
@@ -33,7 +33,7 @@ struct of_phandle_args;
  * @provider: name of the reset controller device controlling this reset line
  * @index: ID of the reset controller in the reset controller device
  * @dev_id: name of the device associated with this reset line
- * @con_id name of the reset line (can be NULL)
+ * @con_id: name of the reset line (can be NULL)
  */
 struct reset_control_lookup {
 	struct list_head list;

