Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF587C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD6215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272059;
	bh=pOa87PBCiYnHj7dTLvic5bMv6YY22wY8K1gMNVh3wOI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2K3+KDX46nUNypLFQbgY9Ax0edWkfHsKr26JQmvafjzw2Ty2Njrf4boFU3QX8Me5+
	 SYeUsj0nncOuWWf9fxOzhRrtfORJAc0jmuCQ8VzcqH68clk0JP139CcQ7/YuWAixAO
	 btfG5LlijaVYervZehJ4DYjgcGad+6tDzIh9+Y1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfDZJri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:47:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfDZJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fBZkPOekWpp//nTjusBuvLT1xpm6CydQjrsv6wGTMR0=; b=atbY1T29wqpN
        bu1MsarOiW3vpNw1vTeJItUFFVM9QF387isJljHqoqwBZpqU1KXKxy5bXsa/t0hT/1O2a7gfAnHKc
        kkMBokoPbSlvxVhai5vrHkJ5Ek4EXbWk3mTEh61JulYcvnD64enitQEwOkiGMz2Vm2fubK5DH4PjM
        dhg1w=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPX-0003Q2-HJ; Fri, 26 Apr 2019 09:44:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 930C8441D3B; Fri, 26 Apr 2019 10:44:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps80031: Remove unused *rdev from struct tps80031_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094450.930C8441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps80031: Remove unused *rdev from struct tps80031_regulator

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

From de110f387371337cf90f40055cf1ebdf01b6f427 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 16 Apr 2019 18:17:27 +0800
Subject: [PATCH] regulator: tps80031: Remove unused *rdev from struct
 tps80031_regulator

The ri-rdev is assigend but not used, so remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps80031-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 1001147404c3..d97cd55b6850 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -85,7 +85,6 @@ struct tps80031_regulator_info {
 
 struct tps80031_regulator {
 	struct device			*dev;
-	struct regulator_dev		*rdev;
 	struct tps80031_regulator_info	*rinfo;
 
 	u8				device_flags;
@@ -736,7 +735,6 @@ static int tps80031_regulator_probe(struct platform_device *pdev)
 					ri->rinfo->desc.name);
 			return PTR_ERR(rdev);
 		}
-		ri->rdev = rdev;
 	}
 
 	platform_set_drvdata(pdev, pmic);
-- 
2.20.1

