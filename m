Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012ADC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2D2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfFQLEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:04:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfFQLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:04:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mj8eB-1iFAr734RJ-00fBNP; Mon, 17 Jun 2019 13:04:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: pdm: select CONFIG_RATIONAL
Date:   Mon, 17 Jun 2019 13:03:51 +0200
Message-Id: <20190617110415.2084205-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RQUeaFNGGn1EAUOJ+4Zq3U9Xg93dFdoGITN3ZKm3Mt4YbKTsksr
 /Nb5nKnunoTBlLqFGpZWA9oXu9HPZ4ooTs1PKfIUNNUH5c8OdpM9y5ix03RPi90uP8mhFUV
 9sef2XlRxJsu4Em1+4Jl7xTmRcNS727kWov9tH/9ugCaLfPF+pyKE/2opwfYI1/uTAULabq
 C5OfVG/T7vycW0msxCGig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TgeddKwT1bQ=:+0nAmfdfN0DrHy0szFSDxd
 E97/qsS1VXgSEQ9Kd9UM8LUmS2rDvT8u8ENSePmCM8L5TPoigst9b5PpOt5gQXY4w/6/k2vdi
 GPlMTAQjWQxxHAqcUyyrFwNr0A7jljiNSZ4XPoTUTSHp4P8mYysAR4i4kVQrTuWSqtpcshFAx
 frleG1h6TqhiR3kn/x6UQhrQlpJwKeiXqQSjicC5pldL/n3LULCpGxPuwoGnz9UHMLHA8u8vY
 /K1ftN31dtrN73VQ+S7TsxRcjiD5c1JRn93SdwhuFs0cAF0BS2xmBdzcX+M5Y3QH5t4hau+ug
 RnKA/CzG9cS1KOVvA/sfahClyagQHFGXk9ZKHark+8g/7E0EJ5lQSsbRlUL1np++MmiwP6Z90
 eTezWa9VSrMf1PzATR8+/V7X/OmPlwDjJxbSh4hwYKXbhIKWgAsF2Dx0Himn6AUOdBVaAPTkC
 agTTz1y0ppeyET6Vd5JHfjc9a8SnYJph9o0Y+mLvjyxp6VMvemow0EMxGeIR4C1wdpwI4WC4w
 7ADR9bijyRaq4WT/0OLwqdeFQ7M2uVHMqd3e4J9B9q1E5dH3gHnPV09SAmC++ybSYOjA9MIIL
 tdG8aPKFXJDyEnH9SiUWWzlu1rixOSpRQo8e2fseE6D8GmQVz6CnJJCmJRHnDwE16yfU4dJX7
 JKGaLRDElTyJ/ehi37iXnQAULGay4vAx+KpY2/tvxZH+wixT05wCB93gM6RfdxNk2/+c3sgdC
 ikEUF7R9U1+VpjOcGVmdFJ579sUlQGHYws5bFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, we get a link error:

sound/soc/rockchip/rockchip_pdm.o: In function `rockchip_pdm_hw_params':
rockchip_pdm.c:(.text+0x754): undefined reference to `rational_best_approximation'

Fixes: 624e8e00acaf ("ASoC: rockchip: pdm: fixup pdm fractional div")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 28a80c1cb41d..b43657e6e655 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -20,6 +20,7 @@ config SND_SOC_ROCKCHIP_PDM
 	tristate "Rockchip PDM Controller Driver"
 	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select RATIONAL
 	help
 	  Say Y or M if you want to add support for PDM driver for
 	  Rockchip PDM Controller. The Controller supports up to maximum of
-- 
2.20.0

