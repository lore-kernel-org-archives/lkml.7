Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54962183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519345;
	bh=IUY8Ck01B7EwsmuISX1GtSm2uiU0R0Hn9eAUwvBPAHo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EQutjtG+veFKlZsrXGflCOOnU3OXFm5KRlW5SElKW7hrlcwg6uimeYmpju+k3bO7t
	 eY67lYvRrapIU7rKyOaU19AUvSeikDhbwYKCJeGHyMWrGvBleMniP6LfHKr6Nz54Dd
	 h64OsrBRSas3IcF+7WhkJZFBS25YpORrq98BGHFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfDQQmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbfDQQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IuP+5WuNj2/WuLhAyTBWHBhUdUB0hL7J7i4E/p0VpDM=; b=jBIvgRvdFvgG
        hFauuT+fygpNTglZuNzNa1uZ0BvQVv4lo7e2gkuRpkrNIJlmhnWjB1gKDWEU92GzfQLyGKsaDEXcK
        bQfVPjLYe08o+hui+iEc4DHYJJeaQj6O/6gTCtZfVh43Wl3UyM59XGD10jmhUTAWZW7m4onlxDXHQ
        15MvI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndX-000151-6P; Wed, 17 Apr 2019 16:42:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E8E5E1128FC7; Wed, 17 Apr 2019 17:42:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: Applied "regulator: wm8350: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190417141633.4730-3-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190417164214.E8E5E1128FC7@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8350: Switch to SPDX identifier

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

From 87dbc5eb3cff166f8107f5be6a53db858211f23e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 17 Apr 2019 22:16:31 +0800
Subject: [PATCH] regulator: wm8350: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8350-regulator.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 0eb3f3a33caa..56d6168a888d 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1,16 +1,11 @@
-/*
- * wm8350.c  --  Voltage and current regulation for the Wolfson WM8350 PMIC
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- *
- * Author: Liam Girdwood
- *         linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// wm8350.c  --  Voltage and current regulation for the Wolfson WM8350 PMIC
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+//
+// Author: Liam Girdwood
+//         linux@wolfsonmicro.com
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1

