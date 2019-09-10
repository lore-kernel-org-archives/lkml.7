Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F9BC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEDC2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568110028;
	bh=sugD8d7P/hdIgXsNGQcQSb8SHzKvrU+8Yjcn8UZe2c4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DRDHJeVNtTfCmvzUir+7eHzDSaDkC0OGoZmQQTo2WGUR/Mt1d1zMYI/EZq7A0W+Hc
	 xXjHCtrayPYXAzASziUz0MByKQqrNnor5QFe4AC8CeZdomc6y8KhlQnN7un7mdoOY4
	 pyd9W4k8elBMGXJhv+NPhmTXLNsJiywmTrX3eYnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405646AbfIJKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:07:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47576 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbfIJKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rSWF4enHkdRTYcF1KH14HvviXZQ+MYgAvo7p7sd69rY=; b=poOAlplhypjb
        GxHQ2Cy93fBMlai+4xHT/FACT2rvA6NyywSUFiA8a66fmHZlDJhBlZ3j+fxSCKidL+6S+J8i7JH+A
        rvaUu2idBlPkQh1B9GXaOTyt7nxBYlKDKZXDsf7rmtCzn86jqBgY8AxwhmE1/GErQT/a5+co7kyaa
        dXREU=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7d36-0006jA-T6; Tue, 10 Sep 2019 10:07:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 2F4B8D02D74; Tue, 10 Sep 2019 11:07:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>
Subject: Applied "regulator: s2mps11: Consistently use local variable" to the regulator tree
In-Reply-To: <20190909155723.24734-1-krzk@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190910100700.2F4B8D02D74@fitzroy.sirena.org.uk>
Date:   Tue, 10 Sep 2019 11:07:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Consistently use local variable

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

From d57d90f4443bd725b3facdc6130a1940af4560c4 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 9 Sep 2019 17:57:23 +0200
Subject: [PATCH] regulator: s2mps11: Consistently use local variable

The value under 's2mps11->ext_control_gpiod[i]' is assigned to local
variable and used in probe in one place before.  Use it consistently
later so code will be easier to read.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20190909155723.24734-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 054baaadfdfd..5bc00884cf51 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1226,7 +1226,7 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (s2mps11->ext_control_gpiod[i]) {
+		if (config.ena_gpiod) {
 			ret = s2mps14_pmic_enable_ext_control(s2mps11,
 					regulator);
 			if (ret < 0) {
-- 
2.20.1

