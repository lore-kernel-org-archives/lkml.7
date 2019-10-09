Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED6FC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88918218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641739;
	bh=+T3HrBaC8iJw79I/fjPsmIR+l5WzLqBxllDdKvIpNVg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KDgC2x1w48EPIfKZ5Znk7eGtF/mC/0ivtLDlVjtEVCcMr6Oya7UWxaUyjgheOrZPN
	 VuRiRFEMBIPBvgmCQ0CHLNThG3WjvVzXGA6te8d5oDTUEl4F+/GMlrZ15rHPPDrQuD
	 xt9LJwq9nPismBE2rfYZlRpbHfUFj17Fo9XIJ2pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfJIRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:22:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbfJIRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZqoRPUiivC6EpdSad1Ty+09CGENkeEfQlMO3yMsb9R8=; b=VshWyjC8OQXd
        pZ7klgvUITEzZKn8bmo2GI9g1276VVYg9qmw3A/yk4Hvj5UCqItQPkn36yn+m1j22qY1Z4ZwwZByx
        0msQxA87c1WkdzT+IKV3qZc3f5YmM7ofIGzN9lvFOHmfRPqkZymKOsXRkrsJN8F7v26GQ2jsGR2sS
        +m0xs=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFf5-0005KP-3i; Wed, 09 Oct 2019 17:22:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 96F10D03ED3; Wed,  9 Oct 2019 18:22:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, yamada.masahiro@socionext.com
Subject: Applied "regulator: uniphier: use devm_platform_ioremap_resource() to simplify code" to the regulator tree
In-Reply-To: <20191009150203.8052-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172200.96F10D03ED3@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:22:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: use devm_platform_ioremap_resource() to simplify code

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

From 907becb2638df95b78581381bed225c4f3e35799 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 9 Oct 2019 23:02:03 +0800
Subject: [PATCH] regulator: uniphier: use devm_platform_ioremap_resource() to
 simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191009150203.8052-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/uniphier-regulator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 2311924c3103..2e02e26b516c 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -45,7 +45,6 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct regmap *regmap;
-	struct resource *res;
 	void __iomem *base;
 	const char *name;
 	int i, ret, nr;
@@ -58,8 +57,7 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
 	if (WARN_ON(!priv->data))
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.20.1

