Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D0CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DDF20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005250;
	bh=UqJPcDMJj8tiD+sfXJLDio30459juWnK0YA7wuv8hW8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tdsVlzjagAvPyw/Eo1qybQ16cGoYdZJmW2og4jzwOKxpe1QUd1xikyAsVVBBedE8C
	 hmoYiZqliCFon37VQbz02bcIpSUIKtCCWK66aHKeXXRF235ULv6+YsaSpOVTBThtQ5
	 /nFhcTgQZ83ml85geuvFa039Wmc/FrN/CAwqr9n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfEPLOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:14:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEPLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PRtfzYSKqOYpZelyhxsJ4vKt9MCdhGadv8d+copgjEk=; b=bvFFOecigq3s
        /KB4RFJF70ICxBJDGD4TVcX0fs3ytykbZlqxhyhvpZy9js0sDEVFLJagc44uAicJCGHCMN1/5c1kQ
        oTAnaaJ+846WJzBehU40hldMrSwKygyL113bbois+boJeekbsX4Z3T9FbTRXwe/RHe98tsPQuhKPu
        cCUz0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREKj-00066h-Fe; Thu, 16 May 2019 11:13:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6E96D1126D48; Thu, 16 May 2019 12:13:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Applied "ASoC: dapm: allow muxes to force a disconnect" to the asoc tree
In-Reply-To: <20190515131858.32130-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516111354.6E96D1126D48@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 12:13:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: allow muxes to force a disconnect

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

From c3456a4b2142550944f73a87a8f338074508b249 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 15 May 2019 15:18:55 +0200
Subject: [PATCH] ASoC: dapm: allow muxes to force a disconnect

Let soc_dapm_mux_update_power() accept NULL as 'e' enum.

It makes the code a bit more robust and, more importantly, let the calling
mux force a disconnect of the output path if necessary.

This is useful if the dapm elements following the mux must be off
while updating the mux, to avoid glitches or force a (re)configuration.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81a7a12196ff..a4d6c068b545 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2245,7 +2245,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux])))
+		if (e && !(strcmp(path->name, e->texts[mux])))
 			connect = true;
 		else
 			connect = false;
-- 
2.20.1

