Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0412075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266521;
	bh=Fjh9D6jxhmn36g/LBm3vQB1GK/ujxkdAYjpIjEQ0COs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PuxO7btBJjxwGgZFV42spImNb7fdbu6Lajm/9a/oJ9qR23Dz2WYQz7lrF5XXHndzy
	 7NKY4/jL/JO90fkdg75kVsZwOTUKH5mIJwmB2CebKTaBeGgjYqvbADUcE4QSdWYqVn
	 qIpNL6BLesrVhFK8ZV82jFTUrj51uJGJjAYzU6Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfDCEl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:41:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39718 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfDCEl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h+qeIcaQptR7Amaj5228AEr9h3jsDQKvQrc8WUgWiYw=; b=jNP3h41M+O62
        X15Bz3fuPwJIUJCBFenM6G5n647uOuGUpl+xAybg/IuXo1mNsLSwDIu/NTsQ/ne52Qee+Y7YCA6EC
        CFEbq97wpFDFZoEVlnspr5FXlEvgxrm1HJ9Zhtymh1TLDE0h9Rsxj8uL4v3hcW5j26eSeXMRUWOzA
        ZxMjU=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXiS-0003zQ-DX; Wed, 03 Apr 2019 04:41:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5EF89440083; Wed,  3 Apr 2019 05:41:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org,
        Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: tlv320aic31xx: aic31xx_set_jack() can be static" to the asoc tree
In-Reply-To:  <20190402114618.GA8728@lkp-wsm-ep1>
X-Patchwork-Hint: ignore
Message-Id: <20190403044133.5EF89440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:41:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic31xx: aic31xx_set_jack() can be static

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

From 7742a5b418c91b1f27a08ebf90cb662cf4c06604 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 2 Apr 2019 19:46:18 +0800
Subject: [PATCH] ASoC: tlv320aic31xx: aic31xx_set_jack() can be static

Fixes: ebf3326cd969 ("ASoC: tlv320aic31xx: Add headphone/headset detection")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fa47bfcb93e9..9b37e98da0db 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1264,8 +1264,8 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
-int aic31xx_set_jack(struct snd_soc_component *component,
-		     struct snd_soc_jack *jack, void *data)
+static int aic31xx_set_jack(struct snd_soc_component *component,
+			    struct snd_soc_jack *jack, void *data)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
 
-- 
2.20.1

