Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A4C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295621D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573132419;
	bh=9BR4nHS/Is91XjcmqDJDsgcTc+ogluHTSsXuMmeHC5c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QZVdvIaQXE4+8KTuG/wE1atdhgDFpfw9C85gv+CTPmzCAuIAbMkDCbFwQSpThkwTW
	 onwD1gh49tNNykzgQRa1GTcZk6QGPHTrEUflNS04mzYuQRCz5Rn48dcgY5nVsMcKFj
	 WMfjGPok+CVclvz6IOml+EnZjxjHnZUlSNB8XDNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbfKGNNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:13:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKGNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UffryeukgEqHpnL1iS02+Ha43Ee+Aa1ndhyYeV576Zg=; b=OE7xEJQ40g16
        K2AAJCIuVeVpPmffJuQFOPDCD4iRbZH7xwdlNuMqkF7bdytYH1O4Mml9lmEQ84eoz65Q9zMZ5eGPQ
        sxAo7ol1CPNfBQNt75rcRt8d2ugdcDB/HNgSVkT4a59jipxL62HNN3oM1AxjPAqrKgKhNHAix5hfe
        DSueI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iShbR-0004NO-He; Thu, 07 Nov 2019 13:13:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0B62D27431C3; Thu,  7 Nov 2019 13:13:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: Remove AB8505 USB regulator" to the regulator tree
In-Reply-To: <20191106173125.14496-1-stephan@gerhold.net>
X-Patchwork-Hint: ignore
Message-Id: <20191107131333.0B62D27431C3@ypsilon.sirena.org.uk>
Date:   Thu,  7 Nov 2019 13:13:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Remove AB8505 USB regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 99c4f70df3a6446c56ca817c2d0f9c12d85d4e7c Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Wed, 6 Nov 2019 18:31:24 +0100
Subject: [PATCH] regulator: ab8500: Remove AB8505 USB regulator

The USB regulator was removed for AB8500 in
commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
It was then added for AB8505 in
commit 547f384f33db ("regulator: ab8500: add support for ab8505").

However, there was never an entry added for it in
ab8505_regulator_match. This causes all regulators after it
to be initialized with the wrong device tree data, eventually
leading to an out-of-bounds array read.

Given that it is not used anywhere in the kernel, it seems
likely that similar arguments against supporting it exist for
AB8505 (it is controlled by hardware).

Therefore, simply remove it like for AB8500 instead of adding
an entry in ab8505_regulator_match.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c       | 17 -----------------
 include/linux/regulator/ab8500.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index efb2f01a9101..f60e1b26c2d2 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -953,23 +953,6 @@ static struct ab8500_regulator_info
 		.update_val_idle	= 0x82,
 		.update_val_normal	= 0x02,
 	},
-	[AB8505_LDO_USB] = {
-		.desc = {
-			.name           = "LDO-USB",
-			.ops            = &ab8500_regulator_mode_ops,
-			.type           = REGULATOR_VOLTAGE,
-			.id             = AB8505_LDO_USB,
-			.owner          = THIS_MODULE,
-			.n_voltages     = 1,
-			.volt_table	= fixed_3300000_voltage,
-		},
-		.update_bank            = 0x03,
-		.update_reg             = 0x82,
-		.update_mask            = 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-	},
 	[AB8505_LDO_AUDIO] = {
 		.desc = {
 			.name		= "LDO-AUDIO",
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 7cf8f797e13a..505e94a6e3e8 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -37,7 +37,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_AUX6,
 	AB8505_LDO_INTCORE,
 	AB8505_LDO_ADC,
-	AB8505_LDO_USB,
 	AB8505_LDO_AUDIO,
 	AB8505_LDO_ANAMIC1,
 	AB8505_LDO_ANAMIC2,
-- 
2.20.1

