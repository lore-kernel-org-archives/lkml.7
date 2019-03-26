Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB96C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5831E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611401;
	bh=wajvGMbKUhpRJ2GRkSwS8kIdAbO0Y57UGlNTZG4LbTE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nOOvNogdkVyt9uuNPCEKFTrV03ivbvjj/7T+SpWZn3ixVeKzMqEv/lZcEDna38qAH
	 lv9KDyx240cVrntpvnbUsClqeA6qavZhnyNS5ilxIMMV+ddzRjszvWvasNJbA6e7yl
	 sfkKkM3XrJ84/5VLPNJ5Nb0QabUCKHSIo+sAwlSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfCZOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfCZOnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MmIX4e8v1e4TR19jOOnBEZb9V+TvL47Cje2rkY3jWv0=; b=E0rwALuvDdWq
        /02ELUVYlsBxykmK7PfxG6CCeCsHjXF3MyxSYdzPsYlsPcgp41VzvkXdmOQUZw2y1MF6MKFcfnZqC
        dqZpHwNKb6qiC7zfz4nQwmhnuabIFSj1dVweM/TucGZBeHj2Z6G267K534Cx0/hznZProdFeeH1U4
        lU4fA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nI9-0007jM-8R; Tue, 26 Mar 2019 14:43:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 83D461121B57; Tue, 26 Mar 2019 14:43:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9063: convert header to SPDX" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190326144304.83D461121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:43:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: convert header to SPDX

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 5de219ccc1a7e1dab98848de53166e15af44bbff Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 25 Mar 2019 21:31:55 +0100
Subject: [PATCH] regulator: da9063: convert header to SPDX

Covnert the header of the source file to SPDX.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c5d1ae5265ab..6f9ce1a6e44d 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1,18 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator driver for DA9063 PMIC series
+//
+// Copyright 2012 Dialog Semiconductors Ltd.
+// Copyright 2013 Philipp Zabel, Pengutronix
+//
+// Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
 
-/*
- * Regulator driver for DA9063 PMIC series
- *
- * Copyright 2012 Dialog Semiconductors Ltd.
- * Copyright 2013 Philipp Zabel, Pengutronix
- *
- * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
2.20.1

