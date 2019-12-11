Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F7E214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XYF0uUIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfLKLAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:00:00 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7668 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLKLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:00:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df0cc260000>; Wed, 11 Dec 2019 02:59:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Dec 2019 02:59:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Dec 2019 02:59:59 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Dec
 2019 10:59:57 +0000
Received: from [10.26.11.206] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Dec
 2019 10:59:53 +0000
Subject: Re: [PATCH] ASoC: rt5677: add SPI_MASTER dependency
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20191210195333.648018-1-arnd@arndb.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
Date:   Wed, 11 Dec 2019 10:59:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210195333.648018-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576061992; bh=MQK8ZVgrVvXj2CCi28ItwK2/xlFo7vqiSDqFxR2ycEA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XYF0uUIPrfVZWGpMaViwy03efYcRVbDgtnOcU0FZmQogsvCRIi7nl5qF7oHsMi1cB
         UR126BMNKqOpTLRdnWGkSTzRk1y76Gg2XyJutGSZDP55Kvi80aBdQ2MWCt2l+Wm0QJ
         EKxVYbjxVxz/Bowr/qYlCXOlVyTcB0405ASX3VXwZJkuLpNzthrWpF8LH4dGkoMbD6
         2ZCio9eSOkANH2ysYs0lWfvl3zyd8Ck/BoCTPNDZSVOBwAcZTUp01vLexN1vtHDq50
         jhnyS/6aeYyuK7icmpNbnibMOIX9aTAM19weFl61QAtNC+aaUb7XGGeOforRV9Wm11
         FJug7rWvb8ObQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2019 19:52, Arnd Bergmann wrote:
> When CONFIG_SPI is disabled, the newly added code for the DSP
> firmware loading fails to link:
> 
> ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!

Would it be better if the above functions or the functions that call
these are conditional on CONFIG_SND_SOC_RT5677_SPI?

> Add a dependency to prevent this configuration.
> 
> Note: the does not work with the DT probing, as there is no binding

Are you missing 'SPI' or something here?

> for the SPI half of the driver, but nothing seems to be using that
> with the mainline kernel anyway.

From a Tegra perspective, given that we don't use SPI in conjunction
with the rt5677 codec, only I2C so far, I am not sure we should make the
tegra_rt5677 driver dependent upon it. We should be able to operate
without the SPI bits enabled.

Cheers
Jon

-- 
nvpublic
