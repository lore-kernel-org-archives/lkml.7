Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC70C2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564744928;
	bh=OpomYkOOEgBmbGlc1tYQ4RaZofxZczQqoe2C3Rri7GM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=l9V9P69HnFIY0Z4ZHElovQ1Gq0xp9Il6xNgK3ofhq/D7EVLEB2MEmO5dXBM8D7pVD
	 59xQrUS3ZnQIByETxw5zQMGfmthx15eK5kTMmHSQpaJeFePrdFBP4MyzA/rEnso/3m
	 a59/t3I4Oc8qjXBTM+Obzf4A5xK/4WLoJIl2FWq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392338AbfHBLWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:22:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfHBLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sRVpmEd1HwhUZ8tiZgc+M3rNKlICfbElVDkqumjeUyM=; b=MLthvNDnWde4
        ZUJrt68QzVG0vt01iWG52pp6AkKt8d7506TeLQx49WhQBlx7uqDg7SMd3jUDgsU7TQX7ezYbaFGo8
        YckuFSS95hIEtWnZdbGuRIvP/J11mLX+jCaZNeaWQkJ8755NHtVyM3TP/XrwUL6HDhqsnY8w/Kq3B
        7GgSc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVdM-0007Ru-9F; Fri, 02 Aug 2019 11:22:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 86E1A2742DA7; Fri,  2 Aug 2019 12:22:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: Remove dev_err() usage after platform_get_irq()" to the regulator tree
In-Reply-To: <20190730181557.90391-38-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190802112203.86E1A2742DA7@ypsilon.sirena.org.uk>
Date:   Fri,  2 Aug 2019 12:22:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Remove dev_err() usage after platform_get_irq()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 47241933b43dec5b10d067e6e094f4d31a1cf3e7 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 30 Jul 2019 11:15:37 -0700
Subject: [PATCH] regulator: Remove dev_err() usage after platform_get_irq()

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20190730181557.90391-38-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 4 +---
 drivers/regulator/da9063-regulator.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..56f3f72d7707 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1032,10 +1032,8 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 	regulators->irq_ldo_lim = irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 02f816318fba..28b1b20f45bd 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -863,10 +863,8 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 				NULL, da9063_ldo_lim_event,
-- 
2.20.1

