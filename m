Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3CC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D112F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfHORYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:24:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40160 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfHORYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:24:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so1886266wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIlOiwJiz/UuDX4lSGZRpCBnPQazQiW1UWLQabpozO4=;
        b=UMQESSs0unC/LLzgJcDtFnt5S+qDHs44wFi6ymSzJQiq1eNVvxnIHLPUUtMQj1tR0G
         M2GBJQl8Fa62LoyYcxa3studpBFPXD6p862bgLT85nSuH6ArNUG5OZvaM0xvvb1nZkFL
         4JeX9oopQyHFkTBIkKW20ynpvQ8pZT6qg3ENoxNZ5jcRBA+yj2yQKMllsG0GostqQj8T
         chgM0skW8jEhT+Tj2Kc4IkkeUx/QbJIUF/xzmJq3/Vz15Y0IUm2xOfwD49FnoC8F03BW
         XFA75UTVS2UM3ptgUmZUm65/RBPixiVXo6O6Aop0e7YK1uoREvAchw+7f2YkkkJpq4wi
         BXHg==
X-Gm-Message-State: APjAAAXxBX8fyMCSN55abIOCks+B2dVFzfKFAH+mk0JPBlodMBwOMdyq
        zL9siw60UlcGWv40j5h9d9vA4u/zylg=
X-Google-Smtp-Source: APXvYqx/QEtbx/qmx2lnZhrj2WqQPCv4uRQAWjHFqyOpjBPyYU6+Z3X7Zo1Z9ez27IHFyLdpd/1vUw==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr3527804wmd.122.1565889872234;
        Thu, 15 Aug 2019 10:24:32 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p69sm3259473wme.36.2019.08.15.10.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:24:31 -0700 (PDT)
Subject: Re: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks
 that need pmc_plt_clk_0 quirk
To:     Daniel Stuart <daniel.stuart14@gmail.com>
Cc:     cezary.rojewski@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Stuart <daniel.stuart@pucpr.edu.br>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190815171300.30126-1-daniel.stuart14@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <175edc67-e0e0-f690-704e-b74b110eda16@redhat.com>
Date:   Thu, 15 Aug 2019 19:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815171300.30126-1-daniel.stuart14@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-08-19 19:12, Daniel Stuart wrote:
> Every single baytrail chromebook sets PMC to 0, as can be seeing
> below by searching through coreboot source code:
> 	$ grep -rl "PMC_PLT_CLK\[0\]" .
> 	./rambi/variants/glimmer/devicetree.cb
> 	./rambi/variants/clapper/devicetree.cb
> 	./rambi/variants/swanky/devicetree.cb
> 	./rambi/variants/enguarde/devicetree.cb
> 	./rambi/variants/winky/devicetree.cb
> 	./rambi/variants/kip/devicetree.cb
> 	./rambi/variants/squawks/devicetree.cb
> 	./rambi/variants/orco/devicetree.cb
> 	./rambi/variants/ninja/devicetree.cb
> 	./rambi/variants/heli/devicetree.cb
> 	./rambi/variants/sumo/devicetree.cb
> 	./rambi/variants/banjo/devicetree.cb
> 	./rambi/variants/candy/devicetree.cb
> 	./rambi/variants/gnawty/devicetree.cb
> 	./rambi/variants/rambi/devicetree.cb
> 	./rambi/variants/quawks/devicetree.cb
> 
> Plus, Cyan (only non-baytrail chromebook with max98090) also needs
> this patch for audio to work.
> 
> Thus, this commit adds all the missing devices to bsw_max98090 quirk
> table, implemented by commit a182ecd3809c ("ASoC: intel:
> cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0").
> 
> Signed-off-by: Daniel Stuart <daniel.stuart14@gmail.com>

Thank you for catching this, this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 98 ++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 33eb72545be6..83b978e7b4c4 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -399,6 +399,20 @@ static struct snd_soc_card snd_soc_card_cht = {
>   };
>   
>   static const struct dmi_system_id cht_max98090_quirk_table[] = {
> +	{
> +		/* Banjo model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Banjo"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Candy model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Candy"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Clapper model Chromebook */
>   		.matches = {
> @@ -406,6 +420,27 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Cyan model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Enguarde model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Enguarde"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Glimmer model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
>   		.matches = {
> @@ -413,6 +448,62 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Heli model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Heli"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Kip model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kip"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Ninja model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Ninja"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Orco model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Orco"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Quawks model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Quawks"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Rambi model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Rambi"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Squawks model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Squawks"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
> +	{
> +		/* Sumo model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Sumo"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{
>   		/* Swanky model Chromebook (Toshiba Chromebook 2) */
>   		.matches = {
> @@ -420,6 +511,13 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
>   		},
>   		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
>   	},
> +	{
> +		/* Winky model Chromebook */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Winky"),
> +		},
> +		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
> +	},
>   	{}
>   };
>   
> 
