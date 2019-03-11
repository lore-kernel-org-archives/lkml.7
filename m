Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35613C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC220828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325017;
	bh=s0nGsSXrwobrA4hN/ojBXNmEcvra9Ytdytwpdlwd9gg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xWwPz9/RPhdqszaeyY44v5GeOMG4VIVAPMPJiRz7k1jToyDuvf/FFfMEO/cJFJ9UX
	 M406yxMEZVoIZwEoy7xb713+deE/Ifppu4O2ztukH6PHdELYP5fQJxeg033NQCI08k
	 92gT+xYh3VjEmFg2iCV/Rldp/2nkqQKld05TwLf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfCKRXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DvoB6qyEah0M/00t9H7/bNei/T8Yi51MKub0pbjtVHo=; b=kULrsc34qt3S
        KHbrkt3z1/tVM4pyydG/ESTp8BAzVpInouzcjSPXwG77qbyzaYO8tGISH6euzAovhCmvY4oMrAESH
        GHn24K1wsJaVKcXCCC63PQBBHckUye5jlBPl8po6vZ/7S8VE/7PDT6AgG7snWTOLgWGY7kniNkaCO
        2Gf+8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3Oe3-0005Kx-5i; Mon, 11 Mar 2019 17:23:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD1AF1128897; Mon, 11 Mar 2019 17:23:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, jiada_wang@mentor.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: src: Avoid a potential deadlock" to the asoc tree
In-Reply-To:  <20190307061554.26486-2-jiada_wang@mentor.com>
X-Patchwork-Hint: ignore
Message-Id: <20190311172322.AD1AF1128897@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: src: Avoid a potential deadlock

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

From ba164a49f8f7390b036713bf8a70a150a938c670 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Thu, 7 Mar 2019 15:15:53 +0900
Subject: [PATCH] ASoC: rsnd: src: Avoid a potential deadlock

lockdep warns us that priv->lock and k->k_lock can cause a
deadlock when after acquire of k->k_lock, process is interrupted
by src, while in another routine of src .init, k->k_lock is
acquired with priv->lock held.

This patch avoids a potential deadlock by not calling soc_device_match()
in SRC .init callback, instead it adds new soc fields in priv->flags to
differentiate SoCs.

Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 ++
 sound/soc/sh/rcar/rsnd.h | 5 +++++
 sound/soc/sh/rcar/src.c  | 9 +--------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 9834474684b1..8d3758f862f1 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
 	{ .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
 	{ .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
+	/* Special Handling */
+	{ .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 90625c57847b..0e6ef4e18400 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -607,6 +607,8 @@ struct rsnd_priv {
 #define RSND_GEN1	(1 << 0)
 #define RSND_GEN2	(2 << 0)
 #define RSND_GEN3	(3 << 0)
+#define RSND_SOC_MASK	(0xFF << 4)
+#define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
 
 	/*
 	 * below value will be filled on rsnd_gen_probe()
@@ -679,6 +681,9 @@ struct rsnd_priv {
 #define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
 #define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
 #define rsnd_is_gen3(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN3)
+#define rsnd_is_e3(priv)	(((priv)->flags & \
+					(RSND_GEN_MASK | RSND_SOC_MASK)) == \
+					(RSND_GEN3 | RSND_SOC_E))
 
 #define rsnd_flags_has(p, f) ((p)->flags & (f))
 #define rsnd_flags_set(p, f) ((p)->flags |= (f))
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index db81e066b92e..45096a66c074 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -14,7 +14,6 @@
  */
 
 #include "rsnd.h"
-#include <linux/sys_soc.h>
 
 #define SRC_NAME "src"
 
@@ -189,18 +188,12 @@ const static u32 chan222222[] = {
 	0x00000006, /* 1 to 2 */
 };
 
-static const struct soc_device_attribute ov_soc[] = {
-	{ .soc_id = "r8a77990" }, /* E3 */
-	{ /* sentinel */ }
-};
-
 static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 				      struct rsnd_mod *mod)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	const struct soc_device_attribute *soc = soc_device_match(ov_soc);
 	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
@@ -307,7 +300,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	/*
 	 * E3 need to overwrite
 	 */
-	if (soc)
+	if (rsnd_is_e3(priv))
 		switch (rsnd_mod_id(mod)) {
 		case 0:
 		case 4:
-- 
2.20.1

