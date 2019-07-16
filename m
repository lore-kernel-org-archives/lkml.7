Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F1C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50B320659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563301111;
	bh=vRekJ511YQxzaA6GBXbmteyzC16Ok2DIQfXQpiykRwM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YIwE2Q3jxMaillJ+s4WUvDPQq7xqLAI6ia0sKyHIO6spXwhU54mONb2BlR7NQFCv9
	 SCtHiLej16b2IzerwxAxWreTzlozQ6zp0jeGJJsNQzqFM+aqDRff1xpgn4sjeI21zv
	 CT99a9AtQiKpDq+KIWgYVB/gmor0m9dzdvbOrTGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbfGPSSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:18:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387934AbfGPSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gl/ER3CAc9iTxDNrHUNt6+9/WROXYL+w+kSUpiBqivc=; b=axxkLtX5JNM8
        mNI/ezOy25a8BZYGExyaoMCLNOkzdg7eYdde1UaAGnb/VhfictcWVj4LMbH5HL+DBslPLxn5eTbf2
        JZmUvIG3p0Z8LruUGT53rTcx+C5LocKEHZst1TiVazGX3xLvCk/4LPC0E61ZYtmiB8TgjnSoc4Sc9
        GqANQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnS1m-0005yw-Tf; Tue, 16 Jul 2019 18:18:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B1E0E2742BD4; Tue, 16 Jul 2019 19:18:13 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mark Brown <broonie@kernel.org>, wens@csie.org
Subject: Applied "regulator: axp20x: fix DCDCA and DCDCD for AXP806" to the regulator tree
In-Reply-To: <20190713090717.347-2-jernej.skrabec@siol.net>
X-Patchwork-Hint: ignore
Message-Id: <20190716181813.B1E0E2742BD4@ypsilon.sirena.org.uk>
Date:   Tue, 16 Jul 2019 19:18:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix DCDCA and DCDCD for AXP806

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

From 1ef55fed9219963359a7b3bc7edca8517c6e45ac Mon Sep 17 00:00:00 2001
From: Jernej Skrabec <jernej.skrabec@siol.net>
Date: Sat, 13 Jul 2019 11:07:16 +0200
Subject: [PATCH] regulator: axp20x: fix DCDCA and DCDCD for AXP806

Refactoring of the driver introduced bugs in AXP806's DCDCA and DCDCD
regulator definitions.

In DCDCA case, AXP806_DCDCA_1120mV_STEPS was obtained by subtracting
0x47 and 0x33. This should be 0x14 (hex) and not 14 (dec).

In DCDCD case, axp806_dcdcd_ranges[] contains two ranges with same
start and end macros, which is clearly wrong. Second range starts at
1.6V so it should use AXP806_DCDCD_1600mV_[START|END] macros. They are
already defined but unused.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Link: https://lore.kernel.org/r/20190713090717.347-2-jernej.skrabec@siol.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 152053361862..c951568994a1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -240,7 +240,7 @@
 #define AXP806_DCDCA_600mV_END		\
 	(AXP806_DCDCA_600mV_START + AXP806_DCDCA_600mV_STEPS)
 #define AXP806_DCDCA_1120mV_START	0x33
-#define AXP806_DCDCA_1120mV_STEPS	14
+#define AXP806_DCDCA_1120mV_STEPS	20
 #define AXP806_DCDCA_1120mV_END		\
 	(AXP806_DCDCA_1120mV_START + AXP806_DCDCA_1120mV_STEPS)
 #define AXP806_DCDCA_NUM_VOLTAGES	72
@@ -774,8 +774,8 @@ static const struct regulator_linear_range axp806_dcdcd_ranges[] = {
 			       AXP806_DCDCD_600mV_END,
 			       20000),
 	REGULATOR_LINEAR_RANGE(1600000,
-			       AXP806_DCDCD_600mV_START,
-			       AXP806_DCDCD_600mV_END,
+			       AXP806_DCDCD_1600mV_START,
+			       AXP806_DCDCD_1600mV_END,
 			       100000),
 };
 
-- 
2.20.1

