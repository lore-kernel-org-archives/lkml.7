Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABEC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D7B20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563301102;
	bh=GASHxbOo+MEj9k7dPiZYha1T0EZUVtD0x31z7aFdpaM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KaQhlFqRyHiGh77LBWOu/DrtvqQLxZf9UZURoEdJoGMsfd5+ewuGegVinLylRhTd5
	 MJbu7zqGiDT6VxeprpNxcjGIifRl+H1D7fmfwfW8THuFx8HfQqTYoRaYj0UH+H/9mY
	 kxkLQ5jY9UXtxzunD4neBPTH1hVVvLHa8pVh0nS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfGPSSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:18:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbfGPSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hTOGIZ23+XRSJbGhMbwTqLV2GZa9UTqr/puYQRNzpJY=; b=dpUsobUmtEGo
        K9iGtdrTbAo2rDThmNuJe2kJGnjjS2sA8gNLcD1PH5oqV3008jpvCDYe7a2egq5UbGnspYbkC/PWb
        QwMDX21FzLZVuG6AnQtR68cIm2OKMjWPd1yssC0INCGBzSIA0wFkKKGTQh/+a4mWamzSBsF59uMac
        CZlS8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnS1m-0005yv-Vv; Tue, 16 Jul 2019 18:18:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 80E062742BD2; Tue, 16 Jul 2019 19:18:13 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mark Brown <broonie@kernel.org>, wens@csie.org
Subject: Applied "regulator: axp20x: fix DCDC5 and DCDC6 for AXP803" to the regulator tree
In-Reply-To: <20190713090717.347-3-jernej.skrabec@siol.net>
X-Patchwork-Hint: ignore
Message-Id: <20190716181813.80E062742BD2@ypsilon.sirena.org.uk>
Date:   Tue, 16 Jul 2019 19:18:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 8f46e22b5ac692b48d04bb722547ca17b66dda02 Mon Sep 17 00:00:00 2001
From: Jernej Skrabec <jernej.skrabec@siol.net>
Date: Sat, 13 Jul 2019 11:07:17 +0200
Subject: [PATCH] regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

Refactoring of axp20x driver introduced a bug in AXP803's DCDC6
regulator definition. AXP803_DCDC6_1120mV_STEPS was obtained by
subtracting 0x47 and 0x33. This should be 0x14 (hex) and not 14
(dec).

Refactoring also carried over a bug in DCDC5 regulator definition.
Number of possible voltages must be for 1 bigger than maximum valid
voltage index, because 0 is also valid and it means lowest voltage.

Fixes: 1dbe0ccb0631 ("regulator: axp20x-regulator: add support for AXP803")
Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Link: https://lore.kernel.org/r/20190713090717.347-3-jernej.skrabec@siol.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index c951568994a1..989506bd90b1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -174,14 +174,14 @@
 #define AXP803_DCDC5_1140mV_STEPS	35
 #define AXP803_DCDC5_1140mV_END		\
 	(AXP803_DCDC5_1140mV_START + AXP803_DCDC5_1140mV_STEPS)
-#define AXP803_DCDC5_NUM_VOLTAGES	68
+#define AXP803_DCDC5_NUM_VOLTAGES	69
 
 #define AXP803_DCDC6_600mV_START	0x00
 #define AXP803_DCDC6_600mV_STEPS	50
 #define AXP803_DCDC6_600mV_END		\
 	(AXP803_DCDC6_600mV_START + AXP803_DCDC6_600mV_STEPS)
 #define AXP803_DCDC6_1120mV_START	0x33
-#define AXP803_DCDC6_1120mV_STEPS	14
+#define AXP803_DCDC6_1120mV_STEPS	20
 #define AXP803_DCDC6_1120mV_END		\
 	(AXP803_DCDC6_1120mV_START + AXP803_DCDC6_1120mV_STEPS)
 #define AXP803_DCDC6_NUM_VOLTAGES	72
-- 
2.20.1

