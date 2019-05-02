Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E33C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438B521743
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763548;
	bh=uLpNT+QAKIoBeHYsOgaMWO+sbImrWQ0HONx128Pe14U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lk+foyNWey44MN0TTPlms5O2nEq6X4qK59XCpondTnbRijbda9iuWK+X1LULhTiYy
	 21ggJ4Hx9dOOzfiK5Yu5ZY+L6PFVGPBdl8yW+QnPi/8swl57gOSJJihU8ObuWY2gCO
	 j1x534PbBCJXYUKsEqAdhnaLBKqOeIbeeRRuBdHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEBCTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEBCS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZcNijybSobRcFQoGTYet85RhrCMx6iNYMPeitpK9a1M=; b=Vis2EvpXRnRY
        bakEPUmYygT1tZrhb8WDbGtzVFYB4tgo+yxNzK/WGRHC9abJ6kUdK2SV8LKXB+6YQQFe3bNL8C4Xu
        wp35GMMdNgFISjP5TqAXMkFrXxjJ7vOq006fNe/VhcFUopvrT6gjRClK18XBUC4P4ss6vWOo56VRH
        VkX5s=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JH-0005uM-G7; Thu, 02 May 2019 02:18:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9A4C8441D41; Thu,  2 May 2019 03:18:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Applied "regulator: vexpress: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190429113542.476-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021852.9A4C8441D41@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vexpress: Switch to SPDX identifier

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

From c5e911add161f356aa5adf6cca33d02946006053 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 29 Apr 2019 19:35:42 +0800
Subject: [PATCH] regulator: vexpress: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vexpress-regulator.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index a15a1319436a..1235f46e633e 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -1,15 +1,6 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2012 ARM Limited
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2012 ARM Limited
 
 #define DRVNAME "vexpress-regulator"
 #define pr_fmt(fmt) DRVNAME ": " fmt
-- 
2.20.1

