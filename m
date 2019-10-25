Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D20CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6798F21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571998352;
	bh=JmfdxzfkU2TCarpXfH9/pL6nI8hfIfOX9bGvs8SWXxE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qcjC/zvhbZikX7FH8DZLNSBeeyPX0pGHyII6tLI7Y/mGywWwUSmwVN9v1TWG/3fVJ
	 cWTduHSBHuL8jiF65TUjPJQUxnMLG8E6660I8yFKUbYJ1oUNHmQdz7AVRCiS3+ewMm
	 VDmWGTu1ZhuMrJVMAmmTBye3pMWO67CsSwNlQM5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409107AbfJYKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:12:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409013AbfJYKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SshFH95hlvnohJa9NKLS6Cf2fJ2qBzDlAgOlmqIfTKM=; b=w9XbI4Vt67gR
        Ja/tZ9IXUqWXXEHb4sreas4M7HNAtDRlxbyl3Om+EIGpt+UQuJcMbwIixGWL5rjwvk7vHL2Jqpqvx
        qvylhr8HjuvHYsCSxf97K3SSzj2MSj/0is4eCkDg2Qfk6d5Sj26nWhZa/y1fQV3pbWqS6dxHH8ez/
        7fpy0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNwZo-0006e0-Rl; Fri, 25 Oct 2019 10:12:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 582B3274326E; Fri, 25 Oct 2019 11:12:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Jiri Kosina <trivial@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Spelling s/configr/configur/" to the asoc tree
In-Reply-To: <20191024151603.29043-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20191025101212.582B3274326E@ypsilon.sirena.org.uk>
Date:   Fri, 25 Oct 2019 11:12:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Spelling s/configr/configur/

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

From c19255659b6ed952948ce54a260efb2ad950cc54 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 24 Oct 2019 17:16:03 +0200
Subject: [PATCH] ASoC: Spelling s/configr/configur/

Fix misspellings of "configuration" and "configure".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191024151603.29043-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/wm8904.h     | 2 +-
 sound/soc/codecs/cx2072x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 14074405f501..88ac1870510e 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -120,7 +120,7 @@
  * DRC configurations are specified with a label and a set of register
  * values to write (the enable bits will be ignored).  At runtime an
  * enumerated control will be presented for each DRC block allowing
- * the user to choose the configration to use.
+ * the user to choose the configuration to use.
  *
  * Configurations may be generated by hand or by using the DRC control
  * panel provided by the WISCE - see  http://www.wolfsonmicro.com/wisce/
diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 1c1ba7bea4d8..2ad00ed21bec 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1507,7 +1507,7 @@ static int cx2072x_probe(struct snd_soc_component *codec)
 	regmap_multi_reg_write(cx2072x->regmap, cx2072x_reg_init,
 			       ARRAY_SIZE(cx2072x_reg_init));
 
-	/* configre PortC as input device */
+	/* configure PortC as input device */
 	regmap_update_bits(cx2072x->regmap, CX2072X_PORTC_PIN_CTRL,
 			   0x20, 0x20);
 
-- 
2.20.1

