Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8872089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271627;
	bh=Fpu+mqoDNAuNO2TAWPFdx06pupM+5IZjtuumF0Ps7Wg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aODJzLbD4LXfu7INGH12AYNGGAPRhD1ydKwCgyEsVlRvGPfIBo24c4E9ZnBo2x/7z
	 v5Sek6sR2NMkDEsgkaYnvArZU1vrNqNKjWaJCIjnVzTbWOdPWoLpeCsabLAwm6sbaa
	 e7Ek6W7HeqL1jMdQcQW+j0LLQpVodPQIUMJBAPH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDZJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pKyBwrPT0Ce34Lb+6/JH94x1mghDjlg4ACPxal00jDc=; b=JaxD6aZY8yvX
        /k0sfaLtwfUljUAkjJQfiNJAGyaCy1kBGo8TJl039oe/HRyqb/YiaqxmMFgZGUMMhwq/rxQsX9WKp
        yxelIWdQrpTs5G4fOD3hDl2k90w1KzzDRsT/83U8YnNxioha2kwiVNDSSlAZeGhCHujohLyRI6etJ
        1OfIo=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLC-0003Ir-1p; Fri, 26 Apr 2019 09:40:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F1700441D3B; Fri, 26 Apr 2019 10:40:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: wm8400: Switch to SPDX identifier" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094020.F1700441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8400: Switch to SPDX identifier

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

From 362af736508134dddcc4cccd575fbb7c22c29712 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 17 Apr 2019 22:16:32 +0800
Subject: [PATCH] regulator: wm8400: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8400-regulator.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 5ce86b92851b..6f331b51e479 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -1,16 +1,10 @@
-/*
- * Regulator support for WM8400
- *
- * Copyright 2008 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator support for WM8400
+//
+// Copyright 2008 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/bug.h>
 #include <linux/err.h>
-- 
2.20.1

