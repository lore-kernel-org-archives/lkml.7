Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8734FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5929820643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325037;
	bh=32sY2VJ2fJRT9iOczDrV9SLBbZfg2AesWyy4JKgrT9Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=z/nfa3phnIxFwyaBoIGczMpu7f9Dc+U5j0HetdRKGNA40YychYGP7CEylywPDlAP8
	 9QdVsP/D8qOyf/yyRpSt/ABFHTt75gkkYTaEvmyb6nvz3FnbRiXyehHKg5ID7erMFM
	 Imyfqr6khAU292hfJSZrL0jLIeBkOMiX2H/XSfXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfCKRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50158 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfCKRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZfrutqsiZJ38u1YCAk4p/vLQ5O1cgNIaeMLtaQ47Fi0=; b=OLVJ+wxo/+Pa
        6J9jZhvoPG28yOOJuLgOVsEpn/gQc8BLGm4gu12Qdt4Q1aF0JxMFn6qo0YZeu+irrcfj7g5hZyWmf
        d+opItX+bzDP/w9T6OLSLDKo0H6mFFk+AgTl28emf62rr+YiJORIIhB4WfzBGH+jvRnpPDFdBKeDE
        zAJQQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3OeK-0005M9-Lb; Mon, 11 Mar 2019 17:23:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 133D41128896; Mon, 11 Mar 2019 17:23:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ams-delta: remove duplicate 'const'" to the asoc tree
In-Reply-To:  <20190307101101.613881-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190311172340.133D41128896@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ams-delta: remove duplicate 'const'

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

From c9fbc1c02ec881c8bb037f87efb706d22589fdab Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 11:10:49 +0100
Subject: [PATCH] ASoC: ams-delta: remove duplicate 'const'

clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
modifier already, so adding another one does not make it more const:

sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
             ^
include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
        const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 4dce494dfbd3..b9611db14c86 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -200,7 +200,7 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
+static SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
 				      ams_delta_audio_mode);
 
 static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
-- 
2.20.1

