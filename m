Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA88C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BE4208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562072707;
	bh=nWFyHcHONwd5ENg5+qoppcx6rh2rmVeXt2P5PFNmir8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oNSInQ6lrIsD605l643FSOq8lq7FAXLacMZOEYi/MBjrAMUj2CJyd3Sm1p314hpmx
	 3Buq/gv0mY0aV8L3Gbyk0Nv+UCF+sX3OOxEU78U/FKoIb9lnXSlJQuZMGz51rdI1qy
	 dWdi9MdRGymEfTonpkmsL4EMG2vW45r7uCqBpX6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGBNFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:05:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfGBNFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lCU9+nRey/mEaOgxKDfHQEITQKqaCs5a/M4AOPAoImM=; b=XEMxU/VvqMkf
        9KUmnM5sDBnFcSUSdafJTdMLTpwsvu9JxIjxKWR7aCR5BQ53jPtsxTU5TMaEILE/R5iaQMP32nDqF
        JQZHPcLjRpWITIm3GaB7K5TrbDsyM8f52amo+PUo/oeAmmMyHM/Wo68uapNE3tlObUL0xuBx3LUGR
        cnyMU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISh-0002Na-3d; Tue, 02 Jul 2019 13:04:43 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8C66144004A; Tue,  2 Jul 2019 14:04:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt1308: Fix platform_no_drv_owner.cocci warnings" to the asoc tree
In-Reply-To: <20190702061738.45878-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130442.8C66144004A@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1308: Fix platform_no_drv_owner.cocci warnings

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

From 2d2e331697bfba9dcc59217b1fcbfa2c144f0659 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 2 Jul 2019 06:17:38 +0000
Subject: [PATCH] ASoC: rt1308: Fix platform_no_drv_owner.cocci warnings

Remove .owner field if calls are used which set it automatically
Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index 619a630e982e..d673506c7c39 100755
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -884,7 +884,6 @@ static void rt1308_i2c_shutdown(struct i2c_client *client)
 static struct i2c_driver rt1308_i2c_driver = {
 	.driver = {
 		.name = "rt1308",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(rt1308_of_match),
 		.acpi_match_table = ACPI_PTR(rt1308_acpi_match),
 	},
-- 
2.20.1

