Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3819721929
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571856997;
	bh=Uq4tVW0ZwZfaxl+8GlaQuWyugJhPbL/EcPj+QYKZy6I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1lWyDOQ4nTEWeMJkOkGbR5B9bW3tB3g5HDLZ/AcINZXdnfkHVXX7xPDHdDKrefhEe
	 PSFyCZ6PKfnDZlkdNyUvqgJkR6esAma2bcx3zIay0qpIx03UQJmDQmQ6sxBC8iHgXO
	 B0sICaeO+PM8P7FfVk/iSv48H5cdANBjoXHHkhL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbfJWS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:56:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbfJWS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k/lGzSE95qaQc9LVPN5qXwbt/UcIqtdwXTpshhYt58w=; b=rmUuRnN1eEog
        /IbKf5Uzgyosjs0QBqetAmV5uIX+mWYy6Y238FHhDe2cIEeBASvQXVB/9cXbEBvmVx484sVjOufpb
        wGOuttvp2WFb3qqQpQZGBM/yw8VH0WGJynKmdREz5nRIqjJmYN98KjQWdKJAwe/3R4TPAXcAKared
        9UijM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLni-0001Ax-PV; Wed, 23 Oct 2019 18:56:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3A39E2743293; Wed, 23 Oct 2019 19:56:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, kaichieh.chuang@mediatek.com,
        kernel-janitors@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.cz, shunli.wang@mediatek.com, tglx@linutronix.de,
        tiwai@suse.com, tzungbi@google.com, yuehaibing@huawei.com
Subject: Applied "ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency" to the asoc tree
In-Reply-To: <20191023063103.44941-1-maowenan@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185606.3A39E2743293@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From ef5dee551e3e6568fb203ea57fa24f55cb64d451 Mon Sep 17 00:00:00 2001
From: Mao Wenan <maowenan@huawei.com>
Date: Wed, 23 Oct 2019 14:31:03 +0800
Subject: [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency

If SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=y,
below errors can be seen:
sound/soc/codecs/cros_ec_codec.o: In function `send_ec_host_command':
cros_ec_codec.c:(.text+0x534): undefined reference to `cros_ec_cmd_xfer_status'
cros_ec_codec.c:(.text+0x101c): undefined reference to `cros_ec_get_host_event'

This is because it will select SND_SOC_CROS_EC_CODEC
after commit 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV"),
but SND_SOC_CROS_EC_CODEC depends on CROS_EC.

Fixes: 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Link: https://lore.kernel.org/r/20191023063103.44941-1-maowenan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 8b29f3979899..a656d2014127 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -125,7 +125,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 	select SND_SOC_MAX98357A
 	select SND_SOC_BT_SCO
 	select SND_SOC_TS3A227E
-	select SND_SOC_CROS_EC_CODEC
+	select SND_SOC_CROS_EC_CODEC if CROS_EC
 	help
 	  This adds ASoC driver for Mediatek MT8183 boards
 	  with the MT6358 TS3A227E MAX98357A audio codec.
-- 
2.20.1

