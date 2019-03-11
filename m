Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038912063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325052;
	bh=d4UdD16OQq8BCqz38LiAC7H1j/rVITfCm0tW1YIvEhI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Awz9xxifl6Nw2E30ne5OjoOvDajlhwTzcI27kD2PVKiacKplxGtEFgx6iXHkYMFpK
	 NCMT4y5fcKt6eIug7TaQXSmkk5lk4KQOJBM+upo599ReDeFZmGceCfA6OUNPC9x+6e
	 iltIzVDaGVJtPr4ZWID+TaM5PUeM+9a5gwC0R638=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfCKRYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50596 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfCKRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7WFL3W2M3ADq+FKR8oU8nBzoFiliH+Io6Beopa2Nrfg=; b=UVMgXSueIeGm
        sputoW48Y/0d0GNr0se4/xabf1aKiEeG8Xa5W/idLYVi5UPzVmT56JpzEZZ8a1+/eJD3QKy0yuMt5
        jtN7y2ODUnfZg0U8L6963iX+WfsQxriqzN1WNViADkpIzMXjcl+2qg67Jx3CF5BTichJjDj51yIz8
        5II1I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3OeX-0005N9-NY; Mon, 11 Mar 2019 17:23:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 349AB1128896; Mon, 11 Mar 2019 17:23:53 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vishal Thanki <vishalthanki@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM" to the asoc tree
In-Reply-To:  <20190307101145.636705-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190311172353.349AB1128896@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM

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

From 8ca5104715cfd14254ea5aecc390ae583b707607 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 11:11:30 +0100
Subject: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM

Building with clang shows a variable that is only used by the
suspend/resume functions but defined outside of their #ifdef block:

sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted

We commonly fix these by marking the PM functions as __maybe_unused,
but here that would grow the davinci_mcasp structure, so instead
add another #ifdef here.

Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a3a67a8f0f54..9fbc759fdefe 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -45,6 +45,7 @@
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
+#ifdef CONFIG_PM
 static u32 context_regs[] = {
 	DAVINCI_MCASP_TXFMCTL_REG,
 	DAVINCI_MCASP_RXFMCTL_REG,
@@ -68,6 +69,7 @@ struct davinci_mcasp_context {
 	u32	*xrsr_regs; /* for serializer configuration */
 	bool	pm_state;
 };
+#endif
 
 struct davinci_mcasp_ruledata {
 	struct davinci_mcasp *mcasp;
-- 
2.20.1

