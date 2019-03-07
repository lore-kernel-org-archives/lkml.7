Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D02020684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fb4A1O5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGN1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:27:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40870 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:27:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27DQ5dX118136;
        Thu, 7 Mar 2019 07:26:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551965165;
        bh=4vTtIvkKTLfEMxxe/FxePSDAu33+0O4AmWmly3VNfAo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fb4A1O5Ms3HMHZez+IxyNWkCQtR4bXZicTuFFZtQiwK/0x/2E/KE2jhuRmbQN320s
         bifdA+6IKd6wXJvX9hrboYryReAbP4M4fC4JivR4fXDJ788x4WZpBfedVWSTF5yS61
         Wty9orpsYOOS7oc+BKJNiTaB+xKUuPlstWVvV5hM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27DQ5oi045632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 07:26:05 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 07:26:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 07:26:04 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27DQ1We004420;
        Thu, 7 Mar 2019 07:26:02 -0600
Subject: Re: [PATCH] ASoC: ams-delta: remove duplicate 'const'
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190307101101.613881-1-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <52357a40-17d3-9dbe-d53c-58baa13116dd@ti.com>
Date:   Thu, 7 Mar 2019 15:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307101101.613881-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2019 12.10, Arnd Bergmann wrote:
> clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
> modifier already, so adding another one does not make it more const:
> 
> sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
> static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>              ^
> include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
>         const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
> index 4dce494dfbd3..b9611db14c86 100644
> --- a/sound/soc/ti/ams-delta.c
> +++ b/sound/soc/ti/ams-delta.c
> @@ -200,7 +200,7 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> -static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
> +static SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>  				      ams_delta_audio_mode);
>  
>  static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
