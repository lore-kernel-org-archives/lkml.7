Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CBC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7520B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641737;
	bh=mVkn2xknL+/uxHqVLY1CEWSBIayji6gwGnPo2bdBrgE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=G8Ldpezk1IUPSIUGHJ4PZPn+jEAQnW13yRiGaDrLyayNYxWkN553NL/ZLPGtHrVGB
	 qCkQCSc3UHROAFddPfJ9oD1s4jMdavuD4j9SUJ7X9N4S7sfb7KofTU2/+R+jqgDLLF
	 HQQ2tFBhumomh0VSR1yXMZk8FY119GT9fWsd7eBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfJIRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:22:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AgWnjlZAFUrv+6CY3vyh0hr4coqm0wM6sLuijPqMvKY=; b=naffpdgtUjh+
        fEbhr+ml04umJPZmHH3mWIm8pScv9NwFg6o2FeCt9/KcVVhEdRIF6fvObWddvmfd3SUAm4ZdZfrGI
        ntgdgr8ITaq8xgtzZmJpGgTDy6271p1cF+79Os0xhT2Eus0rNpKFhgFOh5Hvs1kK268R/VWyF5b8a
        MSDcc=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFf5-0005KQ-4t; Wed, 09 Oct 2019 17:22:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B36F7D03ED4; Wed,  9 Oct 2019 18:22:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexandre.torgue@st.com, broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com
Subject: Applied "regulator: stm32-vrefbuf: use devm_platform_ioremap_resource() to simplify code" to the regulator tree
In-Reply-To: <20191009150138.11640-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172200.B36F7D03ED4@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:22:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-vrefbuf: use devm_platform_ioremap_resource() to simplify code

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

From 73511a90b74c9cfb6509dae63ec4db2d96b7b203 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 9 Oct 2019 23:01:38 +0800
Subject: [PATCH] regulator: stm32-vrefbuf: use
 devm_platform_ioremap_resource() to simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191009150138.11640-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-vrefbuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 8919a5130bec..bdfaf7edb75a 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -181,7 +181,6 @@ static const struct regulator_desc stm32_vrefbuf_regu = {
 
 static int stm32_vrefbuf_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct stm32_vrefbuf *priv;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -192,8 +191,7 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.20.1

