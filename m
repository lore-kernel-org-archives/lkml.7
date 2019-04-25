Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B895C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F9A20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220404;
	bh=NHJl0SUxgxyYXWzpQsIDofzeLJcgRWFO1HQIBByzqj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0ptzCGAuJjx3x0KnVJ/23avXbD6GMdj/qQJ80sWfA/qSKyFPOiWI9xrgwNUfXTAhZ
	 LO2Yo76085ZfcCyKL2BEV7WkcmGFaMqw2EdjpeBYzhxo1VecPNfjhMjg7HMbqcnkyD
	 UqowXRUem0N6B7pCKD8RCuPgcawyiLB3sZhHBD4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfDYT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:26:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfDYT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0x8Te4hhEI/xHQ81yHY2umN/dm6b1QkiuOwRSKt2718=; b=jVa+AwOyI/tU
        6/oY5p6SQXhKOHbUYbi0bexXOU8/Ex0nWWnnJIDsoCubQWikOWd1gWIMBBoeZNPf3WCJTBM7YSq/Q
        5ATS31HrzhWU3apdyfvAFf/DKAQpNa0IbzGMYYs6gtZTrzkqH+4QcrXMtrEqD1TjKCTFMyuUdRt2K
        5Y0g0=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk0y-0004e5-Lz; Thu, 25 Apr 2019 19:26:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A0209441D3C; Thu, 25 Apr 2019 20:26:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     broonie@kernel.org, jorge.ramirez-ortiz@linaro.org,
        khasim.mohammed@linaro.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: do not report EPROBE_DEFER as error but as debug" to the regulator tree
In-Reply-To: <20190417192443.6501-1-jorge.ramirez-ortiz@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190425192635.A0209441D3C@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: do not report EPROBE_DEFER as error but as debug

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

From 4d0a83b904f4b2b9b814ad950472b50e7e803716 Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date: Wed, 17 Apr 2019 21:24:43 +0200
Subject: [PATCH] regulator: core: do not report EPROBE_DEFER as error but as
 debug

Temporary failures to get a regulator (EPROBE_DEFER) should be logged
as debug information instead of errors.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5a9ebcf7fe7a..08ccabe07fe3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4345,8 +4345,6 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
@@ -4355,6 +4353,13 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 	return 0;
 
 err:
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "Failed to get supply '%s': %d\n",
+			consumers[i].supply, ret);
+	else
+		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
+			consumers[i].supply);
+
 	while (--i >= 0)
 		regulator_put(consumers[i].consumer);
 
-- 
2.20.1

