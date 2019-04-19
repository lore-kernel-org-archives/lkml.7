Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B616222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698041;
	bh=dmHgVHHqZtzM3dFmCGdi/8P0k8V2v1SEt0C+HTOaWuI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PrSFeSwMS7N45+R680l+LGfxsUcWCsP8oi4U5ikWlRiwjC7X4TT3PJxuSu5Qo5h/u
	 0ajrpO8vv+/nXPsUsaitj9l+ZddDt5RX0n7WOZl/+NIfu0d/9KYeJi0CbLZOra18O2
	 3tqqwHSbb/EKKEdgibR2ReHPoQ9a8SS2FdeDi1LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfDSSUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDSSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=24hsRemrIppvlZwIStjLtWXyp2Ql/b0EROA/zfqXulA=; b=lkd3Z2f7KfLP
        cUUDb4GCev6B0Cr+/bQq3lzLXjeUgDVi/weA/oKuIjukwKHMMLjq0Fr6djrstmcHJGMYc3x948YbR
        soaEOupLnA35qUirtS3FF8UivVKKVyQZrq7qYgGeKj15aAgBtzN6cwTER/eSqnb9uyjirsPO7SqrX
        0aNHI=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHW9j-00007Y-VN; Fri, 19 Apr 2019 16:14:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A723C441D3F; Fri, 19 Apr 2019 17:14:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Applied "regulator: ltc3589: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190418114500.1098-3-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190419161425.A723C441D3F@finisterre.ee.mobilebroadband>
Date:   Fri, 19 Apr 2019 17:14:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3589: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 003540954b0195ce1dd60354156960cd4d53fc66 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 18 Apr 2019 19:45:00 +0800
Subject: [PATCH] regulator: ltc3589: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 077e73715514..9a037fdc5fc5 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -1,21 +1,9 @@
-/*
- * Linear Technology LTC3589,LTC3589-1 regulator support
- *
- * Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Linear Technology LTC3589,LTC3589-1 regulator support
+//
+// Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
+
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.20.1

