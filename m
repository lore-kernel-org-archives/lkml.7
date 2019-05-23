Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00879C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B0D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558619354;
	bh=4Il95hFurCSiWD5MR3jt3LmIpYjN0Fsngb0CqqofnzM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EgN745lwbQ61OIHotP3wP5uAMfelRnd8kt3DQMsFSrBa4SeOAIjVij7oPMX1qrAmy
	 cOc/JhjVgIy1p52UWD2cFIaSriGUpDLN/663tD2gEUMogY0iyN+bB3saiQOo/5fZIq
	 sPNxAv5En6lhvMBxacuMGH5nLTlVJ3ckuew4lXaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfEWNtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:49:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfEWNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MCSWTU3HxFj7ynCJyIZdDmGSO9hu5ixRfcDvdzVnf34=; b=a+E0ZHt/fXbn
        lCvmlFivZVYX1dmo3XRpgxSX2WXbiFCdvG1KoIZ1RXyWGryFmf4yej1O4OMtCQP/5hwHRRmUI+HNg
        celWngwwaX5CEBr7keOncz/tt2l8oVKM/IB6HEqFlspaQBw1uHVMZ4AHsnfhCY10QxR+J4AiwowoX
        8/01o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTo5d-0000Eb-F9; Thu, 23 May 2019 13:49:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C757C1126D24; Thu, 23 May 2019 14:48:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        clang-built-linux@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Applied "regulator: max77650: Move max77651_SBB1_desc's declaration down" to the regulator tree
In-Reply-To: <20190523012629.7707-1-natechancellor@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190523134859.C757C1126D24@debutante.sirena.org.uk>
Date:   Thu, 23 May 2019 14:48:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Move max77651_SBB1_desc's declaration down

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

From 59dec1f0fac8107f3bffaa0051afce795e24c3e4 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 22 May 2019 18:26:29 -0700
Subject: [PATCH] regulator: max77650: Move max77651_SBB1_desc's declaration
 down

Clang warns:

drivers/regulator/max77650-regulator.c:32:39: warning: tentative
definition of variable with internal linkage has incomplete non-array
type 'struct max77650_regulator_desc'
[-Wtentative-definition-incomplete-type]
static struct max77650_regulator_desc max77651_SBB1_desc;
                                      ^
drivers/regulator/max77650-regulator.c:32:15: note: forward declaration
of 'struct max77650_regulator_desc'
static struct max77650_regulator_desc max77651_SBB1_desc;
              ^
1 warning generated.

Move max77651_SBB1_desc's declaration below max77650_regulator_desc's
definition so this warning does not happen.

Fixes: 3df4235ac41c ("regulator: max77650: Convert MAX77651 SBB1 to pickable linear range")
Link: https://github.com/ClangBuiltLinux/linux/issues/491
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index ecf8cf7aad20..e3b28fc68cdb 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -29,8 +29,6 @@
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
 
-static struct max77650_regulator_desc max77651_SBB1_desc;
-
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
 	MAX77650_REGULATOR_ID_SBB0,
@@ -45,6 +43,8 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
+static struct max77650_regulator_desc max77651_SBB1_desc;
+
 static const unsigned int max77651_sbb1_volt_range_sel[] = {
 	0x0, 0x1, 0x2, 0x3
 };
-- 
2.20.1

