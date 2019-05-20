Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8505C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FAE20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfETIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:37:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43945 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfETIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:37:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so22567658edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OoImjvp6vhdhmP+jZDUwoMoIjk9haGYNqVuRUXiioc=;
        b=ifmumCE76OruPmbduLZOGICM1L1qQGZA7TXzLr4ebs3cgcPb/FrtV3ouc/OjkJaM/4
         tCsR4J/vOf+4RQQYCUkcqkmKKqKk4WSrY22QlE3B7pSa0u3O4MIdw7MNI19QOxrT76hs
         4knPWUrvPx9fHOa3GL9mLSmqI6fptW5pf2pCUYsx6DYfQsljXJaUD/l34A9MjHQjWWFa
         NboHF05QMcWo/nPB6wIWYWB45akVpw4ZxXu1yh0TDMSrKj+SgIfuiwJ28maJ2GPtAtuN
         y272LL5S6eP6w96Y/htuYfstnHlmKQjQWHygF2ZS8aAH4S7e20hju16g4R8qamwl4hQw
         dEjw==
X-Gm-Message-State: APjAAAVx5GxOR4PV/PZysRrfIlzS5AK4hR8hdIVjIu8+XKQL0lGrfDo1
        S6Qwq9z5UsKBSmzuOmDXpPjVDA==
X-Google-Smtp-Source: APXvYqxNMw+Jv9mFvX95M23pZ/Oe1C9oluCJezDYi8hRi2/rjZIZJfmtUBoCYXTb0TXZadtsbJGrrA==
X-Received: by 2002:a50:9738:: with SMTP id c53mr72716921edb.156.1558341422638;
        Mon, 20 May 2019 01:37:02 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 4sm5401052edz.24.2019.05.20.01.37.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:37:02 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if statement and
 removed buffer
To:     nariman <narimantos@gmail.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190519175706.3998-1-narimantos@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <783c330c-b706-9d19-467d-a19d2f414a05@redhat.com>
Date:   Mon, 20 May 2019 10:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519175706.3998-1-narimantos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 19-05-19 19:57, nariman wrote:
> From: Nariman Etemadi <narimantos@gmail.com>
> 
> in function snd_byt_rt5640_mc_probe and removed buffer yt_rt5640_codec_aif_name & byt_rt5640_cpu_dai_name
> 
> Signed-off-by: Nariman Etemadi <narimantos@gmail.com>

Series (all 4 patches) look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++----------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 940eb27158da..0d91642ca287 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -1075,8 +1075,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
>   
>   /* SoC card */
>   static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
> -static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
> -static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>   static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
>   
>   static int byt_rt5640_suspend(struct snd_soc_card *card)
> @@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>   	log_quirks(&pdev->dev);
>   
>   	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
> -	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
> -
> -		/* fixup codec aif name */
> -		snprintf(byt_rt5640_codec_aif_name,
> -			sizeof(byt_rt5640_codec_aif_name),
> -			"%s", "rt5640-aif2");
> -
> -		byt_rt5640_dais[dai_index].codec_dai_name =
> -			byt_rt5640_codec_aif_name;
> -	}
> +	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
> +		byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
>   
>   	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
> -	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
> -
> -		/* fixup cpu dai name name */
> -		snprintf(byt_rt5640_cpu_dai_name,
> -			sizeof(byt_rt5640_cpu_dai_name),
> -			"%s", "ssp0-port");
> -
> -		byt_rt5640_dais[dai_index].cpu_dai_name =
> -			byt_rt5640_cpu_dai_name;
> -	}
> +	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
> +		byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
>   
>   	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
>   		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> 
