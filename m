Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3C2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318420;
	bh=bhrr3ZWVj+dHxgV/cLFhs39QcR1zoF3WDGK1+VINzdA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UWXUYRmdjqL9h5b3Xigr06qT7ukSb+HfIiGD8PblzkYyo1oKou3N3zHDZhGB0r5VX
	 A3loYdxzJ+F1dTdjrTyzg7yS96f0Iz97wKTds/qcqXhq5hV+XcXp/dUCyym/hmea/v
	 9arebE5WTT6zA4oYOtWDSvgtmVldHuo7b9J+kDR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfDOIxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:53:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MS4tuqCBFb1/yYEpOWaph8lgQe56L7D4vVA/LDFliDA=; b=rxD5MkayvSGW
        v08jBysKWXgxc7BGvX1Ll5VH3K58A8zcr9K6ESjo74LqioXSvhVbO9FYoL3In1+Cr6hs7wnP+Gklp
        fDhLUCYU9JUw+AGSjQZD1LBBJIon3qKtrmVRuH8MfiJusn0/U3P6ewGV6Aly5+zP37kNOP0uU7rEQ
        IS3N4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMq-0007j5-S2; Mon, 15 Apr 2019 08:53:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5C6611127B96; Mon, 15 Apr 2019 09:53:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Cyril Chemparathy <cyril@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps6524x: Constify regulator_ops" to the regulator tree
In-Reply-To: <20190413073002.764-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085331.5C6611127B96@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6524x: Constify regulator_ops

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

From 357db0279a230e009d4440db71c497f3360311bc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 13 Apr 2019 15:30:01 +0800
Subject: [PATCH] regulator: tps6524x: Constify regulator_ops

The regulator_ops is never changed, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6524x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 67cac2682f50..c09223c34dbf 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -565,7 +565,7 @@ static int is_supply_enabled(struct regulator_dev *rdev)
 	return read_field(hw, &info->enable);
 }
 
-static struct regulator_ops regulator_ops = {
+static const struct regulator_ops regulator_ops = {
 	.is_enabled		= is_supply_enabled,
 	.enable			= enable_supply,
 	.disable		= disable_supply,
-- 
2.20.1

