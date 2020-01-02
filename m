Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EEF215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgABNy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:54:26 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgABNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:54:26 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mz9pT-1jiGIP0xBz-00wBuB; Thu, 02 Jan 2020 14:53:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: boards: Fix compile-testing RT1011/RT5682
Date:   Thu,  2 Jan 2020 14:52:55 +0100
Message-Id: <20200102135322.1841053-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zxRcnJYM3Qwzugm8PjSAcZhaHwSkpBGtFfHipa588cNnptL2qON
 NSD9i7Qg/kZPN617VR9sOzheMm2RYqcM3nybT8U9auEe4SXnAWg2PIDbYTRvXuNVgL8MM/h
 hOHQdhTLQB3rxThMssg/aqy5TMs4OFxtvMeIzodOFBTnozUp48zN5rn5PiMNUrrgV1K1SKG
 prSoLK4CbtvFyqyFpX03A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEdlaOzjlc4=:Rlb5ilrlSlSqshcCQuCuTW
 BzyisJQmkkEAA9eevZIA8cW7rwyN1A/6V3ZJjvyWSKSomEVuzw27CS+piy7o+v8J1BVD4uH4C
 i9okx2bEx6iOmdvPiktk9ek1RwJF+3TC5uJnsMzXBD1r4L+Y4x/zdi5cYapmXBfKZcrz7Nswo
 67qs1iFcCijMdTRFK3S1X0tp1iGOdt3kQMA995Mnwzz7xgos+DFpxvVtV/YMm/ZOGUEcJeDct
 X6FC0QqxUDmqOgaaI+bJJbaFdG7001rMc/IXxYVgwMuUMRUWoheozga9LBpa8RIoFks6Cji3q
 /VyPve6BUbSneIjhjFZO2hIlpbAhQIeL6pJbBJGBDJyuA7h/iaZag8EoQXvC6HHSWemxwl/2V
 dc4Vo2VlgCxrIuFEnwcGn3a9FfDKuw+Z+HqE4tcEZPkstnIIVd3pmWS27ESezqHGGSEyOWOHY
 IEMuKQmaFSDsCxNuQqTZUDFbsezR2+P02U8sC3RM4H2SMl7t/jZ2Wgvkc302gpYLMJK+eae2N
 0CmuYuD6XOszSyfA/VdkRCStuqSiZTou8yg7G4iQMqPxyrBtBnFRaKkLA8Q9qTKVunPHXSG1j
 EWvIvhuiYgYSGjaeplMv5glG0Ku+1HW523OhJGxTm6bHlY5cs2Yia20P3Vj/h7S0MlvIPOAkE
 NQZ7Mx1pZcpgsY/dz+UavTiY+C8IcnLvpiB4OU2BNuFFmI01YFzHXQ57+DuJp9lluUCn57L9K
 2Vb47OXSeMWL+wrPNZkLjjMs8JOl8eufizUqum7QqVGFt2llvXGZFzUpFcajXXu3olLXfm34S
 ZMRN6P8NC4G1syIun+MiDSFO0AzqetX8GR0GhSC1ZJ21WT1JFh2Wox7hgTfh01/GmO9LbGVvg
 rhW/LNNkbQApzDsZfFkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-x86, the new driver results in a build failure:

sound/soc/intel/boards/cml_rt1011_rt5682.c:14:10: fatal error: asm/cpu_device_id.h: No such file or directory

The asm/cpu_device_id.h header is not actually needed here,
so don't include it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this last week, but the patch still seems to be needed
as I could not find a fix in mainline or -next.

Please ignore if there is already a fix in some other tree.


 sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index a22f97234201..5f1bf6d3800c 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -11,7 +11,6 @@
 #include <linux/clk.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
-#include <asm/cpu_device_id.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-- 
2.20.0

