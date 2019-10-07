Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB943ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453446;
	bh=YSC3asbOpUtfjb5R2Et5LqjdjfQh49hT8Ak2S1gq/RQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PxHI5TmKoJoXcX7ZE1kbRpm2/nPbSuhX8uGRJuytwtWJTJJYJb/FEzF5l8S0yepok
	 IgVd/gJbvcsTN3fRKGyAnWOHnzerA4lxGNTVeR0eRS/WsmYIz20w3y5skGXWLkyPt5
	 Xd+C4oANKRuxkNyaDnM4xVCm2MXdZO55/qO5tZHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfJGNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:04:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfJGNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wiHxYuiV5ogRe/Z9rynEjd2eT8m8wC32eHirRSOjcnU=; b=N0vBTOfIlVw1
        4+/dfwYhtMMkK8NcUORZd64J4dmbW3Di6QuCSQ5p0632APdBe/yIIFrz/I6nxiG/ER6KXfrqgck5I
        umdP4hwoOvUgoGmRn+sd2YttHHa0t8kMQl6NJkOKNeUG24PUB6g6+odcX3OxiOvXrr1MHXWPlkPrB
        vgycA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfY-0003SP-7c; Mon, 07 Oct 2019 13:03:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BA9EC2741EF0; Mon,  7 Oct 2019 14:03:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9062: Simplify the code iterating all regulators" to the regulator tree
In-Reply-To: <20191007115009.25672-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130319.BA9EC2741EF0@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Simplify the code iterating all regulators

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

From 151b03791e4acb09bb9a9af2a87bca1240937d6c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 7 Oct 2019 19:50:08 +0800
Subject: [PATCH] regulator: da9062: Simplify the code iterating all regulators

It's more straightforward to use for statement here.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Link: https://lore.kernel.org/r/20191007115009.25672-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 56f3f72d7707..1028db242f91 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -966,8 +966,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	regulators->n_regulators = max_regulators;
 	platform_set_drvdata(pdev, regulators);
 
-	n = 0;
-	while (n < regulators->n_regulators) {
+	for (n = 0; n < regulators->n_regulators; n++) {
 		/* Initialise regulator structure */
 		regl = &regulators->regulator[n];
 		regl->hw = chip;
@@ -1026,8 +1025,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				regl->desc.name);
 			return PTR_ERR(regl->rdev);
 		}
-
-		n++;
 	}
 
 	/* LDOs overcurrent event support */
-- 
2.20.1

