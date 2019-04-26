Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC507C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B38206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271877;
	bh=I2FNRtczGzk21Vm89j5uL18xDHbNlA/XLHAu4k4tG54=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cDUL7BNVcBUGcPfVlabKV4uGiiDbRDj9dXaw2D3dR/3Ykx8fzCsw9Qjk4LARzr2n/
	 FpkvgnGwGBObTr7TFlGmlei7ZCjBYUQ3BDEEdFe/DMphHZ07rclsMQ/9QhJkqbGCCr
	 cmlxxXc6181l6Sd8inVqtIoLHbkz1ja4rKl8Iyq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDZJog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfDZJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=E3N1mqlK16rcDuCwK6cL46faH8yVA6X6urV3DBCfcoA=; b=sJZ4ao7aeJBR
        pXJ8zmu6l4LH8YWdUjcKZDJPfli3i5nAX0fTeRu1dirRbmMRvf6Fg/10U13DwzZAfD3UVzCt5JwiW
        LkgsqHPOavFP+oIIn5NDW6YMfF1lGhWQ4ZsjmRRMmRUQi4HUPX5rX43NHuFYvbuOcWLG7HHalUFHm
        y6oxU=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxP3-0003Ns-AC; Fri, 26 Apr 2019 09:44:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 57248441D3C; Fri, 26 Apr 2019 10:44:20 +0100 (BST)
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
Message-Id: <20190426094420.57248441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:20 +0100 (BST)
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

From 6a1beee2fe379f7a846ec095c82f181ca36a8437 Mon Sep 17 00:00:00 2001
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

