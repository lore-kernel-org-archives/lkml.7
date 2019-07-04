Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA4C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7592189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562243114;
	bh=0XNggfZ0XKIgfcDp77wJwdkDweoErH6EtViwgw0jn+I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Prtw4NRz72PWivyjztCuzsQQUaDPNGJg98frXSalnbbIKauEAxreo74F0LDal/Re/
	 TKnc5iLybfUm9uhRLaroYJxHVR115w7C2KZ8K1u0uaqFfw01YJf7GRoa3DQyBMsSNm
	 EZIv8+hzmZTeFGbtrBkPRnF/+IYYcg40+NdZVoW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGDMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:25:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35554 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfGDMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=O6t7DHXPR1LVA6BY9uJ2lKsVFed1OWvtb4Y8mivFETc=; b=Iuuw01M3MhDy
        PcLmzk6J+d6kCxKqS2Hqj6tafvWoIZfbcaP27sfhKqMTRbsTNBuesWP2S5KG0cqHBUuet2MXnFc2/
        PaVYDGyygRwDP+LsHpG3ileBhZxwIRC73srP283WEvldMqP4gmp+h22Z8QMIF4c+Pg5yht0e2Dv8o
        olD9E=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0nS-0000jY-4i; Thu, 04 Jul 2019 12:25:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7EA6E274388A; Thu,  4 Jul 2019 13:25:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77650: add MODULE_ALIAS()" to the regulator tree
In-Reply-To: <20190703084849.9668-1-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
Message-Id: <20190704122505.7EA6E274388A@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 13:25:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: add MODULE_ALIAS()

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

From ba2bf340ade89e71c53273ea115c7872865782c1 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 3 Jul 2019 10:48:49 +0200
Subject: [PATCH] regulator: max77650: add MODULE_ALIAS()

Define a MODULE_ALIAS() in the regulator sub-driver for max77650 so that
the appropriate module gets loaded together with the core mfd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20190703084849.9668-1-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index e3b28fc68cdb..b79fe93c8edb 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -452,3 +452,4 @@ module_platform_driver(max77650_regulator_driver);
 MODULE_DESCRIPTION("MAXIM 77650/77651 regulator driver");
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:max77650-regulator");
-- 
2.20.1

