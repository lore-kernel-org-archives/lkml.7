Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E4C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354312173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aF+fQfFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfFNPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15148 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfFNPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c1de0001>; Fri, 14 Jun 2019 08:48:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:48:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:48:46 -0700
Received: from [10.26.11.12] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:48:44 +0000
Subject: Re: [PATCH v2 5/6] clocksource/drivers/tegra: Add verbose definition
 for 1MHz constant
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-6-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2d890693-20b5-6f1d-89c8-f89533f04f22@nvidia.com>
Date:   Fri, 14 Jun 2019 16:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-6-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560527326; bh=mL9uq+zgkQoheW7I6zgddAifZts2XKq2svr6yIs+L1E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aF+fQfFb4btr30nxav/w2tKyLXnX98ExqLjIcfEjuToLwuJV95Cwmq/K/lxN81hmd
         9MCNUosn2GvMsnHNLvgcgVkbHUVMlRf9c0kFZrsuRsOjYepidD5wOi8MMp70T4KHG/
         mlRHjJqWQEZSBRaxCLP0GOJ8kOxwlKDVzaZWyC/8FCD7ISaXvjZlD3l5p6KFG2vrwI
         HOLXc7LVrJZCbIYt9cSg+S3wWjKFJ4KuDQWT9976QyEOOoHnq1vb8k1vg+cL0IoKL5
         m1/br5erny33qwYVljrmpphloACv01+ESDXavFY2hST9tLGJS9ACUEgdjkjWODqLVt
         VAxy7yhiVn7eg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:43, Dmitry Osipenko wrote:
> Convert all 1MHz literals to a verbose constant for better readability.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index a7fa12488066..2a428fdf702f 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -44,6 +44,8 @@
>  #define TIMER1_IRQ_IDX		0
>  #define TIMER10_IRQ_IDX		10
>  
> +#define TIMER_1MHz		1000000
> +
>  static u32 usec_config;
>  static void __iomem *timer_reg_base;
>  
> @@ -158,7 +160,7 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
>  
>  static struct delay_timer tegra_delay_timer = {
>  	.read_current_timer = tegra_delay_timer_read_counter_long,
> -	.freq = 1000000,
> +	.freq = TIMER_1MHz,
>  };
>  #endif
>  
> @@ -224,7 +226,7 @@ static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
>  	 * parent clock.
>  	 */
>  	if (tegra20)
> -		return 1000000;
> +		return TIMER_1MHz;
>  
>  	return timer_of_rate(to);
>  }
> @@ -313,11 +315,11 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  		}
>  	}
>  
> -	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
> +	sched_clock_register(tegra_read_sched_clock, 32, TIMER_1MHz);
>  
>  	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
> -				    "timer_us", 1000000,
> -				    300, 32, clocksource_mmio_readl_up);
> +				    "timer_us", TIMER_1MHz, 300, 32,
> +				    clocksource_mmio_readl_up);
>  	if (ret)
>  		pr_err("failed to register clocksource: %d\n", ret);
>  

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
