Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE4AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FF206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aLIR1UYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfHMJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:35:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfHMJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:35:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D9Z06h059610;
        Tue, 13 Aug 2019 04:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565688900;
        bh=z5SehQ6Yf5BT5rg3RPDWJ4hLrJF6X7OEw5KQmH3sPbE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=aLIR1UYBliStSX5k3OHl42m26KLHXoP0AkC9ZWWPZMx1oGzA02fKNuMZSzX9nzeui
         1BaoruULQXBuSGCg+GK/edlb1RqEmyPBz0gG90TBgrXvle4g0z2eHMLh3LtdVdQD3/
         0QPXsIyhG4QVW1ELFUnfXsMFqb1iGlZj+2Q84K6s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D9Z0VS014160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 04:35:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 04:34:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 04:34:59 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D9YvUf054466;
        Tue, 13 Aug 2019 04:34:58 -0500
Subject: Re: [PATCH] ASoC: ti: Fix typos in ti/Kconfig
To:     Masanari Iida <standby24x7@gmail.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>
References: <20190813034235.30673-1-standby24x7@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9674e996-ef05-5da3-9d20-1ad5c44a6176@ti.com>
Date:   Tue, 13 Aug 2019 12:35:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813034235.30673-1-standby24x7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 6.42, Masanari Iida wrote:
> This patch fixes some spelling typo in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/ti/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 2197f3e1eaed..87a9b9dd4e98 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -12,7 +12,7 @@ config SND_SOC_TI_SDMA_PCM
>  
>  comment "Texas Instruments DAI support for:"
>  config SND_SOC_DAVINCI_ASP
> -	tristate "daVinci Audio Serial Port (ASP) or McBSP suport"
> +	tristate "daVinci Audio Serial Port (ASP) or McBSP support"
>  	depends on ARCH_DAVINCI || COMPILE_TEST
>  	select SND_SOC_TI_EDMA_PCM
>  	help
> @@ -33,7 +33,7 @@ config SND_SOC_DAVINCI_MCASP
>  	  - Keystone devices
>  
>  config SND_SOC_DAVINCI_VCIF
> -	tristate "daVinci Voice Interface (VCIF) suport"
> +	tristate "daVinci Voice Interface (VCIF) support"
>  	depends on ARCH_DAVINCI || COMPILE_TEST
>  	select SND_SOC_TI_EDMA_PCM
>  	help
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
