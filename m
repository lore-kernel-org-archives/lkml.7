Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3714FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C07208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfGZKuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:50:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGZKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:50:04 -0400
Received: from [192.168.1.110] ([77.7.18.175]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxEcg-1iavZl2Txg-00xYyO; Fri, 26 Jul 2019 12:49:57 +0200
Subject: Re: [PATCH v2 1/1] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190726062115.16231-1-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d35c844e-4202-9710-dbe6-f10bebf75e3a@metux.net>
Date:   Fri, 26 Jul 2019 12:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190726062115.16231-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6vpp9FgY6NvUSy4gyqTyyg0lqOmpLpYNdFoTfGab1jCN20xKx9J
 WwqaXrZo5zt8t6DgfS++vg479QNUGqiQZXiIBylxH5sjTnz3vr7HKWpPbpqN9FrrojIz+Cy
 aDNp1T9PEyc5BtW9DqHmKg5gUmDwmZxzIALFMopE28ty5Ga3vupJQF7NgNm3ciukTWzKJaD
 xfhyVGT35XX7M4HIzsLvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PrjwFrsjRSw=:cwPsuEfonj2pyOJYjb79/5
 kZpQS9k2AyJXqiBE5mLsYvuH9tsB7xb4d1ezHn1BKpE4XhNe8KyGAaj6kR16sivvJG6yYCh9W
 fR2L2Hb830r53CwRJ1TDFIjcJ8+H6sQdDx3Y7iJcsNfoasQHCPGxuZXt3iCftVuyZkmgnyAWg
 GpclIuqMk4zb0n7vCC4pLyX7rhd+OSAb2odSC2b55i0MNjD+tu7dCrVoajVkabw1wbS0gAzCk
 rwiKz7ZiNdtv+lqghAS8AfVS/RZf7ZsFhFjrxIPZoCijcUWNiECDNIuyE0cAkqu9RNfGkLxhw
 NAdtZrY0uUiR5nsQTCkw+p8+b9uLfKwWBsE8K56yMjbTe+AcrJeMPJB+ShiZLudW6oWXt5ExE
 KqmxshKvvyW6mPphw/Dp5eH+CA+v3PaZK7E94ev4Gw57prjzYNqT6BI12TTCRtmB0SczlA3No
 Y1xfDUFlmW+DanUob8tz/rovrRt1f1qnzmCfoZTjinoz7c1/IFScKhk8F+1cvVwe0R7A2fxnk
 OX5UslQ+mjerKgjIv7KYWfwgeoPx5rwAUp1C59663Clb0P7lOogqWZa+mzL30B+LKkvAKb0Qy
 1AQW8UZAYz5d+zf6p+0QfJS3FbiW5Ag2VO+Sa3eCgVFx7FYeZmtOpnoIcH0Dh2yQRdeGDh7yL
 hYf+0cDldk/UnVM+86nJFvsAqXjb/c4wtyowHtxalbaqQ/s19RgKZakzWwV8CFcq52nWkufgW
 oLOVFgnUFxFxXCXklF8pArzD4gb+J8UET9bBz26X5en3iIKvCJ59Vnd7Omg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.19 08:21, Florian Eckert wrote:
> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> the ports from the userspace, add the definition to this platform
> device. The gpio can then be exported by the legancy gpio subsystem to
> toggle the mpcie reset pin.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> 
> v2:
>    Noting changed for this patch. Only resend because other patches of
>    the series where dropped or updated and resend by other people
> 
>   drivers/platform/x86/pcengines-apuv2.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index c1ca931e1fab..f6d8ed100cab 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -32,6 +32,8 @@
>   #define APU2_GPIO_REG_LED3		AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
>   #define APU2_GPIO_REG_MODESW		AMD_FCH_GPIO_REG_GPIO32_GE1
>   #define APU2_GPIO_REG_SIMSWAP		AMD_FCH_GPIO_REG_GPIO33_GE2
> +#define APU2_GPIO_REG_MPCIE2		AMD_FCH_GPIO_REG_GPIO59_DEVSLP0
> +#define APU2_GPIO_REG_MPCIE3		AMD_FCH_GPIO_REG_GPIO51
>   
>   /* order in which the gpio lines are defined in the register list */
>   #define APU2_GPIO_LINE_LED1		0
> @@ -39,6 +41,8 @@
>   #define APU2_GPIO_LINE_LED3		2
>   #define APU2_GPIO_LINE_MODESW		3
>   #define APU2_GPIO_LINE_SIMSWAP		4
> +#define APU2_GPIO_LINE_MPCIE2		5
> +#define APU2_GPIO_LINE_MPCIE3		6
>   
>   /* gpio device */
>   
> @@ -48,6 +52,8 @@ static int apu2_gpio_regs[] = {
>   	[APU2_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
>   	[APU2_GPIO_LINE_MODESW]		= APU2_GPIO_REG_MODESW,
>   	[APU2_GPIO_LINE_SIMSWAP]	= APU2_GPIO_REG_SIMSWAP,
> +	[APU2_GPIO_LINE_MPCIE2]		= APU2_GPIO_REG_MPCIE2,
> +	[APU2_GPIO_LINE_MPCIE3]		= APU2_GPIO_REG_MPCIE3,
>   };
>   
>   static const char * const apu2_gpio_names[] = {
> @@ -56,6 +62,8 @@ static const char * const apu2_gpio_names[] = {
>   	[APU2_GPIO_LINE_LED3]		= "front-led3",
>   	[APU2_GPIO_LINE_MODESW]		= "front-button",
>   	[APU2_GPIO_LINE_SIMSWAP]	= "simswap",
> +	[APU2_GPIO_LINE_MPCIE2]		= "mpcie2_reset",
> +	[APU2_GPIO_LINE_MPCIE3]		= "mpcie3_reset",
>   };
>   
>   static const struct amd_fch_gpio_pdata board_apu2 = {
> 

Acked-by: Enrico Weigelt <info@metux.net>

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
