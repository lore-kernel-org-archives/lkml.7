Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC9206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559056029;
	bh=p/ymJSmaoHBlUrGCp6Co76k+07UimWncnI4MTPYJGY0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vu1rGI6gj5bQqewn19luOygiwhM7GhCYbOmcsTpdquVs93YJOTtGf7zkKWTcRjYKW
	 +xyuc8ogsUz9KKZtaOCRKrid6IcxGsBV3GXC/u42MyeC83I50BFBYNx/fJlWUFCJ2e
	 9zNoKqbjyJ624yQxDmydpH0JIaJz1MK6JWrHr4nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE1PHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:07:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfE1PHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PUvnzbZrTZ31zd48XHGvEZHvYsigwu0xnoy3Ezetm/0=; b=gnZ1JzN8Sj4F
        uwv4A+rAOJ5Gn9rPnW4+ArTSB2btmpcVIgGZIirNzUf73F6ED69MrAu/ycA+bi+4JphzFPii50s1k
        Fm3hPCOTXPOn2tnTKWyW3r/+53g0rNXPqj+ilwZSkiH04E7eG1mgbi4NiFAbgeHEMDZ5kIEa9aO+U
        Kq9/k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVdgm-0002nf-3V; Tue, 28 May 2019 15:06:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5341D440049; Tue, 28 May 2019 16:06:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Simon Ho <simon.ho@conexant.com>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: cx2072x: fix integer overflow on unsigned int multiply" to the asoc tree
In-Reply-To: <20190524222551.26573-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190528150655.5341D440049@finisterre.sirena.org.uk>
Date:   Tue, 28 May 2019 16:06:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cx2072x: fix integer overflow on unsigned int multiply

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

From be0461048b60066eaba9046178fb96e78579af21 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 24 May 2019 23:25:51 +0100
Subject: [PATCH] ASoC: cx2072x: fix integer overflow on unsigned int multiply

In the case where frac_div larger than 96 the result of an unsigned
multiplication overflows an unsigned int.  For example, this can
happen when the sample_rate is 192000 and pll_input is 122.  Fix
this by casing the first term of the mutiply to a u64. Also remove
the extraneous parentheses around the expression.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index c11a585bbf70..ed762546eaee 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -627,7 +627,7 @@ static int cx2072x_config_pll(struct cx2072x_priv *cx2072x)
 	if (frac_div) {
 		frac_div *= 1000;
 		frac_div /= pll_input;
-		frac_num = ((4000 + frac_div) * ((1 << 20) - 4));
+		frac_num = (u64)(4000 + frac_div) * ((1 << 20) - 4);
 		do_div(frac_num, 7);
 		frac = ((u32)frac_num + 499) / 1000;
 	}
-- 
2.20.1

