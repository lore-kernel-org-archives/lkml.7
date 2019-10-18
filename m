Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A2BCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76220869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422111;
	bh=C82unrMS9yRfdSW57TCZSr6B66P2pmlbe8oeNW+w1LM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cPNHMh2xypjsK/V6CE5IrDToQ1s82lKHBe36dT+3b+f3n8HzeAN8dLRTELVcOiukN
	 40zEyrk9eKirc7UoElGN9MIPKOprFRBxavELIeyxHmYdI+Lmf0867wsP9LvrKgDgnW
	 TiIqT0BUyO+UUDo0BUDnuav1l12y41DSQKdTsz0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505841AbfJRSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45122 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505729AbfJRSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yZ5ihh+JlZp10ClOg05PmwAuVkRD1OdpzVwW9zBqAmM=; b=s3bnqBwhK7O0
        HJcbkXuG0VHf4/PUJPylcJro5WEwFskA95EHWzdgREHmbnbcccuH2+0TeKhzEScFhOMzXxVEyKzLV
        LqkIJJ2oADEB/jK2mdsjj1Wv0w9AdSvecR+/UGKdC9kKcP3lV8n0g3I0vDfq4qkBzwGSd0Lu/qYko
        KSrjY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeR-0004Ev-5Z; Fri, 18 Oct 2019 18:06:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A66102743259; Fri, 18 Oct 2019 19:06:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt1011: fix spelling mistake "temperture" -> "temperature"" to the asoc tree
In-Reply-To: <20191018082317.11971-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180658.A66102743259@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:06:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1011: fix spelling mistake "temperture" -> "temperature"

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

From 349959a9c767cee04b7362fda230cc2433246fd9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 18 Oct 2019 09:23:17 +0100
Subject: [PATCH] ASoC: rt1011: fix spelling mistake "temperture" ->
 "temperature"

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20191018082317.11971-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index ad049cfddcb0..dcd397a83cb4 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -2373,7 +2373,7 @@ static int rt1011_parse_dp(struct rt1011_priv *rt1011, struct device *dev)
 	device_property_read_u32(dev, "realtek,r0_calib",
 		&rt1011->r0_calib);
 
-	dev_dbg(dev, "%s: r0_calib: 0x%x, temperture_calib: 0x%x",
+	dev_dbg(dev, "%s: r0_calib: 0x%x, temperature_calib: 0x%x",
 		__func__, rt1011->r0_calib, rt1011->temperature_calib);
 
 	return 0;
-- 
2.20.1

