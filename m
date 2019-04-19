Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68FC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB7222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698094;
	bh=Md63aeBiheZhPohAZD/a9qkpmLDP/KULEqF0gpQGBUY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=l4vVMyhwoSSJOMn4yDZcXnSF7brQ+IjGKrWbH2qaJazHoyMbpqz7W3JtMov6AgAxV
	 p6YtZP70wB8Am9+ovc8930khquitVGKT0PQxSMG9O3wBYTfQnJfrrbcAxkiu/l1y8f
	 wtHQM9YFJeRIFbmYHJnGGHXoEXnaYVGarOHUh9sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfDSSUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfDSSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=g0IjKnXDoyaYvs2Kqg0dnQ9FOItsHljHt9NUaT90KEk=; b=BQK5xK4fQfpR
        ZfNiERdtXvJsLszxuvhVbM8YcCLE1IX/9MlKQRqVJwWD3zIbK3n+MCO9tSirFQ+UJ2NUqFmCwS1X9
        fAeQFnjAaZHcoBM5u1Dh9p/TojPyAmYRuhN85dOS2SRBl7Kv/csRSFDumofW9VRiph4PRSap8Hh0+
        reNxM=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHW9m-00007O-Cj; Fri, 19 Apr 2019 16:14:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 22D70441D3E; Fri, 19 Apr 2019 17:14:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Wadim Egorov <w.egorov@phytec.de>,
        Yunfan Zhang <yfzhang@marvell.com>
Subject: Applied "regulator: fan53555: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190419005824.21533-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190419161424.22D70441D3E@finisterre.ee.mobilebroadband>
Date:   Fri, 19 Apr 2019 17:14:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fan53555: Switch to SPDX identifier

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

From c9bab8f5a9655609491d4fa0c27e0fff357110ec Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 19 Apr 2019 08:58:24 +0800
Subject: [PATCH] regulator: fan53555: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fan53555.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index e2caf4173ab5..dbe477da4e55 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -1,17 +1,13 @@
-/*
- * FAN53555 Fairchild Digitally Programmable TinyBuck Regulator Driver.
- *
- * Supported Part Numbers:
- * FAN53555UC00X/01X/03X/04X/05X
- *
- * Copyright (c) 2012 Marvell Technology Ltd.
- * Yunfan Zhang <yfzhang@marvell.com>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// FAN53555 Fairchild Digitally Programmable TinyBuck Regulator Driver.
+//
+// Supported Part Numbers:
+// FAN53555UC00X/01X/03X/04X/05X
+//
+// Copyright (c) 2012 Marvell Technology Ltd.
+// Yunfan Zhang <yfzhang@marvell.com>
+
 #include <linux/module.h>
 #include <linux/param.h>
 #include <linux/err.h>
-- 
2.20.1

