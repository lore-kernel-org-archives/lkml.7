Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2587C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68237206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2oaMwes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfC0Pnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:43:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfC0Pnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bIQZt3cHis3bRLr/kRRtEAGcbTHWTUHz99CURSRVQhY=; b=e2oaMwesAKm+yybV0I1U2PXDI4
        CLVBWkrRPdrAPfNtJtVGeSNiPv5xSjIvfFVSoXZhlZbmQzAz6tWkYWCVrf14eq9Wcyd078YDy+QhF
        WhlDcg3Q3acPoKfhxNzUuQAyrWsLZYc83KUeybBf+KmlPKg9akhj1UJPJdhkqklCK94KJR+MLPa7k
        NLRSVDAlGHVnl58PWTdAqrh1bb10MvwVdp7CNjFSEsGSsP3e0thASpmMQztfPcIs8yx3b+wvVN0yr
        jm17UMHlrbtgNGANXNxcNY2wRhXBZUNHCpzOGrjJm7hIoGop9yIgZUNm7mA9Z21krGVUvwoZ4tVva
        pkx60xxw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9Ai3-00011G-LM; Wed, 27 Mar 2019 15:43:23 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Piotr Stankiewicz <piotrs@opensource.cirrus.co>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: fix SND_SOC_LOCHNAGAR_SC kconfig warning
Message-ID: <fb9f38e4-c4c9-400e-fb16-fa2714eb8d00@infradead.org>
Date:   Wed, 27 Mar 2019 08:43:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for SND_SOC_LOCHNAGAR_SC:

WARNING: unmet direct dependencies detected for SND_SOC_LOCHNAGAR_SC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && MFD_LOCHNAGAR [=n]
  Selected by [m]:
  - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && COMPILE_TEST [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190327.orig/sound/soc/codecs/Kconfig
+++ linux-next-20190327/sound/soc/codecs/Kconfig
@@ -94,7 +94,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_JZ4725B_CODEC
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_LM49453 if I2C
-	select SND_SOC_LOCHNAGAR_SC
+	select SND_SOC_LOCHNAGAR_SC if MFD_LOCHNAGAR
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C


