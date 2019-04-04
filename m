Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939BAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413D2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365832;
	bh=DePeaSK2kugW9oZqdFSXAe41j8ps9i8VG0t68kqZ/Fk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qXHNUAjH7bc6WEuoSnnGRmDWRK3/WSOWIzLpEcUfH3XKrEC02OOQ9WFfbZ+ZHpgxv
	 ncqLFLHAt0hEBya90it5AJejNlqVQC2kx8kHCCITFD8TIAvlCQ0Ny6s0Csj6uDwpDZ
	 UkQS3ysDYcI4lcknQ6Vs763H/qhTIlre2pzysNwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfDDIRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51080 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfDDIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fx5GSk7LFH3K5EJTEAcHEaqFvqeVb2j8QlXZdlbyR2o=; b=Z2dWV+MyIuvs
        sOCVotPXDRoMcai0qpy3il359zbe7R8j60kbJeb8tMOPw2Hzrmr+ztCBWki22dwF2jb0LSx1RfoAs
        He2W8QAMjT9Wgj65GfzlljNBJ7PnVPH0hUZp0nsrUrkFMQS1zZR+DoXaYVxOn1dnj1ox9qf6eXXvj
        Pk1cs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYO-00052W-HW; Thu, 04 Apr 2019 08:16:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A4066441D3C; Thu,  4 Apr 2019 15:16:53 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: add default regs" to the asoc tree
In-Reply-To:  <1554298856-59028-4-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081653.A4066441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:53 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: add default regs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From a7980cd212cef9002fe9683f440d27609d1aae37 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 3 Apr 2019 21:40:47 +0800
Subject: [PATCH] ASoC: rockchip: pdm: add default regs

This patch add default regs value for controller.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index ba61a4b27d39..984d99889a65 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -361,11 +361,19 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_default rockchip_pdm_reg_defaults[] = {
+	{0x04, 0x78000017},
+	{0x08, 0x0bb8ea60},
+	{0x18, 0x0000001f},
+};
+
 static const struct regmap_config rockchip_pdm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = PDM_VERSION,
+	.reg_defaults = rockchip_pdm_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rockchip_pdm_reg_defaults),
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
-- 
2.20.1

