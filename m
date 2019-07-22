Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F436C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562DB21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfGVLZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:25:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfGVLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:25:31 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8oKc-1iSW6V1Zd0-015oaD; Mon, 22 Jul 2019 13:25:25 +0200
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ca916de8-dab3-66d7-806b-b43a2df6cffb@metux.net>
Date:   Mon, 22 Jul 2019 13:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-2-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G92V9GI9odCx+apJy+6WJt8ElyhYVx670ohdqwCGQ7eByjdizIr
 IbRTm55fQ27qV4KCQYmVXEgfdIBtbJIBp6jxkpzpFfdaVQw0dITA6frvxs/F9fPSB6u481X
 jLmpT/jf0A9kXrU1APyw4jHpB8JxjLxEhyTNI9AA1qLqhYdLHqGr6gTxe7CiawBmzEZQPQW
 /Wz8UbMGYtjm9HjtMnbxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2AOQk1AiLU=:xjLWTxiHZc0n2H2zRbEK2G
 5nbCqAGK/WPU7AAoIX1tmv7V5Gid5DmJN7N13A6WrLENLPGw3Kn8872Pp9Ae6a7nWyVWv+jZz
 XduT71bo6p8vuEUrGslZwy/yRzLYdgE/0wo0COIDwhyCcOUfYnAg4hlTOJfm8piyzNesGD3Q0
 V+6t/z/Bhcd5iQnaEAUQ94fPTp+YmL3eEX1m0RMEGwgrSyGIRpdS6t6U7/9tqQIWEL9CUnPad
 V0tWlOj+JOOVFf/QSp5aLk910EhLQ6lkzJlCrOmKqBxAaDP/HU/J5fQ8LA+31XLJ6UfCA628K
 XjcOcD0f4rKOPOS34eG6yMVVoe+wpxk7K7kRNX3SGayBNR+FDb3ke4PYHQVHSNwaj0ObZZ1E4
 2MaHYrTUEKjrGR5Z0YTPNHH6er2TTO4WAcRNVLxC+yZHwLmD+4hsqDsOrWSSSp8qtbwNVU4gt
 trhES5j1pr7KrlLqejDJWl5RzimB1cBKT2FonFPG87szdfgWWKYtigJ4FaL0rfdKq78X6C4eH
 4eGzv1CcuxjhAgCgOBRBcG3TiAweBbui5I3EWP73HnWo5rhTufk7pBGRpuXR3O+ld9psWtn5f
 DQJ4IEEZbnCgyQS9sr/2P1vf9K82LrxxzcWtD6oFKcCJOdAxnchpbvWMJ0xgILBJZVBNANf96
 O3oLyYYtJNDriIW+JFmNlyzsdbL+YZSryWWriXmOkJJTiYTP+81eGjaQYQB4BUgtxNbZqJ4p1
 Hu/iXAb5lrEqznaPfTk6mP1rNn35HB20zdJx+xfe4eFTFh6r8P9A1Qyz58g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> the ports from the userspace, add the definition to this platform
> device. The gpio can then be exported by the legancy gpio subsystem to
> toggle the mpcie reset pin.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
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

But note that these gpio's later will be bound to an appropriate
driver. I've got a patch in the queue that uses LED subsystem, but
haven't sorted out whether it's better to go via reset subsystem
(and add a gpio-based reset driver first).

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
