Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902072075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573132416;
	bh=S7EYAs7AgGc+0UCS2gMd+X4tdoJdJ5Mw1loVhaufYEI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xJsY6FFf0YVMW0OfTlKPsvXfbzlX6lOuKFKChj53RmeVkUf/n4hwvCnV1aQAhxd+i
	 mYS8KhIyhFDnTjOZnxzzAUAZMBXnSO/1Z6OoAWkAcT+SNOmoTc6oziqHBl+TPLgXBX
	 0d4JYlWpsE2U+pXlZWHkxfSPHznaWjIPoPSoN/SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfKGNNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:13:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=38fVbCceIZMgFEiWyCwsVp4ocXxtxsckHfbtPAIZshM=; b=NVVjdvdHpydf
        Jg8UEgtoHhVS7JTGMxYG+urZTZu7suy/ZPmb6L1W86C8uTXI97K4KQsFTZ0Hjelk1Bcw42QXiuObJ
        a/+NjDPadNodqtm43ozblqmeHMM/jixf5GI2eiiLQZzmS0gye9Nn/RHggORRiAbUsxCGYGeWPLFyN
        /TQ+M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iShbR-0004NN-8x; Thu, 07 Nov 2019 13:13:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C869627431AF; Thu,  7 Nov 2019 13:13:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id" to the regulator tree
In-Reply-To: <20191106173125.14496-2-stephan@gerhold.net>
X-Patchwork-Hint: ignore
Message-Id: <20191107131332.C869627431AF@ypsilon.sirena.org.uk>
Date:   Thu,  7 Nov 2019 13:13:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id

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

From 458ea3ad033fc86e291712ce50cbe60c3428cf30 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Wed, 6 Nov 2019 18:31:25 +0100
Subject: [PATCH] regulator: ab8500: Remove SYSCLKREQ from enum
 ab8505_regulator_id

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/ab8500.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 505e94a6e3e8..3ab1ddf151a2 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -42,8 +42,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 
-- 
2.20.1

