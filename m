Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EECC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD4520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:12:23 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:12:23 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MqrsF-1gfxcn0tFp-00mp32; Thu, 07 Mar 2019 11:11:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ams-delta: remove duplicate 'const'
Date:   Thu,  7 Mar 2019 11:10:49 +0100
Message-Id: <20190307101101.613881-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k/2OR9k0QoyUUNIInBX08wqkIL3j6Yz0+PfESAJTH3/Iy1DhaZa
 wplY2bTKqUACOsclQ1NkytMx2WxJULDHIjjshJp8ii7siShpsoRktl3oVOjISLlDHjXUl5H
 Cr+FtXhx5wxNAv8W/jxnTHgXFovNPjviCmJ9/KyF+pdKukbTCFPEBxUDN5T4mlKEGI0MfMz
 yqxy19ZAxtz/YZZ1Uicuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CnygP1H9aSA=:5h6CzTF8RPe9XURDae0mf3
 8SE+KYRkEOlqAhzLim/ZQwvH86n+2b2y5lc7CK/D9ZFLjXgTP4Cx/t4JogcXeTglDCRNEqPQG
 2WSV0ALCDiPlOmVgsW1B+QQQhLbyMh+Mob0dx2qOHXziaVxyMXnX4DA3CZcg25n1u8EbgXYy5
 ZUX3b+2boYKt2L7KYszmV6auDeEaDl+pvNJ8D+ptUqwuBpo1JHw9DuYc+b0X8CCNEXWqLJn/4
 /4oYOzHonsJyOYVX8kLQJSdFsYZcueIFLadrGyQBH/ci1O2bFR8WYeq2StjkXTqZUtXyeAswL
 RjqjDEdSddP40q/ZCFyO13O4Yh3mGPDYE8OwddSU2t+NgQ0v84H191g91Fdy3e2IgreG4Zt2y
 u9hvCht2P1gfuNH6J7L0RrsuV1z19xw4KLEbFhHJUU3OVWcGVIpHiqdWp8eHsUa6ry/bfYI9s
 puRV/aM1DwGRRpO5a7CrKBPCRCjq/VuhGi1Uft0+25T9jTbvZ/WMeI3xD4rurdjd9EuQZCXro
 3b1rp0k6cR/MvY+mDhmUlwZSwUw9/KQGU005ucSQXFUlcdOe2eY/UgEGIBajEIGGd9/ux82Fg
 MUlmmNsnyf9BiH4iLG9XRRvFDBiO+lxnvnnThsBAJarYr4BmuJ1MPGnA8xHzyC47WL+8BKVhq
 ux99vBbAqHuCDQJbu649SqQFKVI2oayhaEfl12nYDnFTZTztdBwdz02N+MI6Gwh0P+Dc+wybL
 mRyrhzFjzBauQBV0Hqw4rsrdu6295LkmIaLSJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
modifier already, so adding another one does not make it more const:

sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
             ^
include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
        const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.20.0

