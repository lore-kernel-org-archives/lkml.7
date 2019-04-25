Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99231C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C102F2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220360;
	bh=7rTmrTrxhop8MUj70t6sLTQCqwUpQACvHEsmSi+y6sk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A5CKlNrSgUPwWg+yjS7vMZY8yZL8tJqkRbfA9yLeJdoLRrluY0ii374nT6N7sZk9N
	 5bYvvNWAcA5Z6aDNvZeE2hcEEo1WpzzyJ0m8yt/vM8cinWVci3xOUei7Z/aN4aJN/x
	 n9X41PClXSksV8epVuQ46NaAnB1k0E4wAga1oEvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfDYTZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDYTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VqilEpU0zcs5UID60f+ZH1pJ3ZhXj2B3wEwvevnvqGU=; b=H8UEbZa2SqVk
        l/ev5+WYoHuNGyWIP+JwsWI9J96tVH1OsBNLydS5am77fVOduKPWqduQ34sqXMf5F6uflrv612QK3
        lF/HRXGVo4a4pkO5EIBZRWqd55B9Bgap9eg+0Rb8oCUg4DKnDJVqbW2qVLy1HkiG1PMy6ZWlTEuOe
        h8ESU=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjz8-0004Zo-Pk; Thu, 25 Apr 2019 19:24:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7E77B441D3F; Thu, 25 Apr 2019 20:24:41 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Zhang <markz@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: Applied "regulator: max77620: Fix regulator info setting for max20024" to the regulator tree
In-Reply-To: <20190422053531.23123-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192441.7E77B441D3F@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:41 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77620: Fix regulator info setting for max20024

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.1

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

From 734008e714d8c757613c43ff57c1bf7ef1bb5b5d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 22 Apr 2019 13:35:31 +0800
Subject: [PATCH] regulator: max77620: Fix regulator info setting for max20024

Current code always set pmic->rinfo[id] = &max77620_regs_info[id];
It should set to either max77620_regs_info or max20024_regs_info
depends on the chip_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77620-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 1607ac673e44..0ad91a7f9cb9 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -803,7 +803,7 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 			continue;
 
 		rdesc = &rinfo[id].desc;
-		pmic->rinfo[id] = &max77620_regs_info[id];
+		pmic->rinfo[id] = &rinfo[id];
 		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
 		pmic->reg_pdata[id].active_fps_src = -1;
 		pmic->reg_pdata[id].active_fps_pd_slot = -1;
-- 
2.20.1

