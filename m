Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC10207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404933AbfITHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:51:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404904AbfITHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:51:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4K2r-1iBUnx2Whd-000HEj; Fri, 20 Sep 2019 09:50:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies
Date:   Fri, 20 Sep 2019 09:50:18 +0200
Message-Id: <20190920075046.3210393-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EAKPTZ+itukL2iznqTUk5rPIMXBlBv9PWcQDjxKpT9O//vnk5gh
 rAOyC8URZPiUfTgkKlxvXoVXPAwpUOUyBc0xu0jumnINBPwIcw5VCV1whnDmt15T78vaj+V
 KZBJvmieL310Wovz0k/cDx/thz7NXU/w31Vz4vpXtYosVVoU55dDg6Sm1k/LOvm4G84/dYT
 tJTF76m7Jh3v+6ff4FffA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pklhRZ2wyO4=:XKxLr9F1esW2k/1CYBwAZ1
 p6hU9OeU8jh6CmeIfSMgqs3GHdq17Y9JtBjCI54ia/904VPOE/xlrlfqufyoXbA2kdrJgmzxH
 sUOpcfn86X0zl1zGbd4rWbzgZ8sAaDA+bCVQsVKPn4jTwvkf54irU3EYvaHr7O5DPlYcn1jPE
 sqTlgeoGzmwIAsMiNYAHDhnd2HsogtybRZwkL307fcfIktlVFnDX/lWSsUQ1ivP6swjA2mzB+
 8LXTwspTBe5slOJELG1qo0uHoluy6sQFZcEp/AEKLwfwevC+dCfijD87ElENqhBFDbZG9E7np
 Sm5u845gRCukKCEiv9MoavuuTZLjLyqNuLWUBkH2WdaJd6bb4zdHZ1i9A5zWoeBtMlPzzkPTJ
 U3SDT0f9r0a0Wlb+DS8d7Z+QD3wSyUBOYzyJdtut/kOPdPMwRCOqremPdwCIs3T8BdO/4N1Ik
 9U525jwIbditIYdpvm+LfxVqNPfIqKpu8Yh2DYVvvap9NLDkORv0Sm21lrD5Y90cOV7UK71F+
 3DMvCH9YwvE50r6K1BvcuQLG0zJ8GFzxVSVCE2foMyOQU/dUk9u+5D2mIxhPJ3/6FsUZI93J4
 pttyejLqRP6Up5O/Vjv50dSljBxAwXkOyFHsvruHsHp9Vwx+SoAjhuBebch0iHZc0ZltlABEf
 nGoHWubqzFGasR1GTGiBMuiyo4nlaL/bq8l942kUgP3nFH+bLKC5lFtmH7EyNhvEaN+V35URq
 GSSNJbJK+6VgT3M32QcNabqLLHbtjkjf6R7n7bWJud2XwngeE9BWsfxv5lYgtX8sAEhwGkvPr
 94/qfrrwSsPKRE3wXXnGYXgyoRHPCBtZrSQ5CuXzEFR4osEHZGUGJaYtE0yrZAql+ifRz3zsQ
 eWcZ83+5KHTe4qoG+ouQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_DM365_VOICE_CODEC is a 'bool' option in a choice statement,
meaning it cannot be set to =m, but it selects two other drivers
that we may want to be loadable modules after all:

WARNING: unmet direct dependencies detected for SND_SOC_CQ0093VC
  Depends on [m]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
  Selected by [y]:
  - SND_SOC_DM365_VOICE_CODEC [=y] && <choice>
  Selected by [m]:
  - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y]

Add an intermediate symbol that sets SND_SOC_CQ0093VC and
MFD_DAVINCI_VOICECODEC to =m if SND_SOC=m.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 87a9b9dd4e98..29f61053ab62 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -200,11 +200,18 @@ config SND_SOC_DM365_AIC3X_CODEC
 
 config SND_SOC_DM365_VOICE_CODEC
 	bool "Voice Codec - CQ93VC"
-	select MFD_DAVINCI_VOICECODEC
-	select SND_SOC_CQ0093VC
 	help
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
+config SND_SOC_DM365_VOICE_CODEC_MODULE
+	def_tristate y
+	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
+	select MFD_DAVINCI_VOICECODEC
+	select SND_SOC_CQ0093VC
+	help
+	  The is an internal symbol needed to ensure that the codec
+	  and MFD driver can be built as loadable modules if necessary.
+
 endmenu
 
-- 
2.20.0

