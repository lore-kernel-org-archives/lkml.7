Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8883C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9621F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560452781;
	bh=0SqJ+WB1ySYR6NjKx6ka/S3pJsBpr3EB3SuSyweZO/k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vmXdk7WMx0CipaPu4LJSbuKANLHvnuZI55AGde+p1FIAEiL5l0htSx1OhhsGxT5Ia
	 +sQxVBLrpA4v6TbSYtzvRMdzfHjVZyETaWY34+Peecm2z+dPaFYL4ZnXsNd8njX89s
	 Uzjs8DSdx6oyebb3MXS/H92qKp73x8AHKEteMSgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfFMTGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:06:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfFMTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=odYH5jh5iqYcEq0WcQQwpiFTomDVAY1DZTeNz2YF128=; b=mE+4SSbntrcj
        IkbdRgfjFG2i5xCWfgECoVM2enoZflxejdTzlhPVGny3Ux8q9EPXi2rGDvKBoyrRAaMQxoQ023Djy
        3Y8VY/Vazltmyjph9+zQaiRQwnbCQkkdji3UFTMVLuaJJTlJcB4kxGKPEY/GDfpvsDGqsaBlw/Nnr
        2sokc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbV33-0005SQ-Tg; Thu, 13 Jun 2019 19:06:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6F9F5440046; Thu, 13 Jun 2019 20:06:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cernekee@chromium.org, clang-built-linux@googlegroups.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tas571x: Fix -Wunused-const-variable" to the asoc tree
In-Reply-To: <20190612232502.256846-1-nhuck@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20190613190609.6F9F5440046@finisterre.sirena.org.uk>
Date:   Thu, 13 Jun 2019 20:06:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas571x: Fix -Wunused-const-variable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 2f7e015c1f20cfdbe97df25868abbfa8b7514778 Mon Sep 17 00:00:00 2001
From: Nathan Huckleberry <nhuck@google.com>
Date: Wed, 12 Jun 2019 16:25:02 -0700
Subject: [PATCH] ASoC: tas571x: Fix -Wunused-const-variable

Clang produces the following warning

sound/soc/codecs/tas571x.c:666:38: warning: unused variable
'tas5721_controls' [-Wunused-const-variable]

In the chip struct definition tas5711_controls is used rather than
tac5712_controls. Looks like a typo was made in the original commit.

Since tac5711_controls is identical to tas5721_controls we can just swap
them

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/522
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index ca2dfe12344e..684b7afa9252 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -725,8 +725,8 @@ static const struct regmap_config tas5721_regmap_config = {
 static const struct tas571x_chip tas5721_chip = {
 	.supply_names			= tas5721_supply_names,
 	.num_supply_names		= ARRAY_SIZE(tas5721_supply_names),
-	.controls			= tas5711_controls,
-	.num_controls			= ARRAY_SIZE(tas5711_controls),
+	.controls			= tas5721_controls,
+	.num_controls			= ARRAY_SIZE(tas5721_controls),
 	.regmap_config			= &tas5721_regmap_config,
 	.vol_reg_size			= 1,
 };
-- 
2.20.1

