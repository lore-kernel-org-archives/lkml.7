Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9B9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F612054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDZUwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:52:17 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33347 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDZUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:52:17 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1CC11240008;
        Fri, 26 Apr 2019 20:52:13 +0000 (UTC)
Date:   Fri, 26 Apr 2019 22:52:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
Message-ID: <20190426205213.GW14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com>
 <20190402125056.21509-8-alexandre.belloni@bootlin.com>
 <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com>
 <20190425203139.GO14604@piout.net>
 <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
 <155622689471.15276.16322042541342557062@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155622689471.15276.16322042541342557062@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 14:14:54-0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-04-25 13:58:10)
> > Quoting Alexandre Belloni (2019-04-25 13:31:39)
> > > On 25/04/2019 12:38:55-0700, Stephen Boyd wrote:
> > > > 
> > > > const?
> > > > 
> > > 
> > > Right, can you fix that up or should I send a new version?
> > > 
> > 
> > I can fix it.
> 
> It's more complicated. I'll pile this patch on top. Maybe other
> static data in drivers/clk/at91 can be const, but this at least covers
> the struct clk_range ones.
> 

Seems good to me.

> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index b1af5a395423..0aabe49aed09 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -41,7 +41,7 @@ static u8 sam9260_plla_out[] = { 0, 2 };
>  
>  static u16 sam9260_plla_icpll[] = { 1, 1 };
>  
> -static struct clk_range sam9260_plla_outputs[] = {
> +static const struct clk_range sam9260_plla_outputs[] = {
>  	{ .min = 80000000, .max = 160000000 },
>  	{ .min = 150000000, .max = 240000000 },
>  };
> @@ -58,7 +58,7 @@ static u8 sam9260_pllb_out[] = { 1 };
>  
>  static u16 sam9260_pllb_icpll[] = { 1 };
>  
> -static struct clk_range sam9260_pllb_outputs[] = {
> +static const struct clk_range sam9260_pllb_outputs[] = {
>  	{ .min = 70000000, .max = 130000000 },
>  };
>  
> @@ -128,7 +128,7 @@ static u8 sam9g20_plla_out[] = { 0, 1, 2, 3, 0, 1, 2, 3 };
>  
>  static u16 sam9g20_plla_icpll[] = { 0, 0, 0, 0, 1, 1, 1, 1 };
>  
> -static struct clk_range sam9g20_plla_outputs[] = {
> +static const struct clk_range sam9g20_plla_outputs[] = {
>  	{ .min = 745000000, .max = 800000000 },
>  	{ .min = 695000000, .max = 750000000 },
>  	{ .min = 645000000, .max = 700000000 },
> @@ -151,7 +151,7 @@ static u8 sam9g20_pllb_out[] = { 0 };
>  
>  static u16 sam9g20_pllb_icpll[] = { 0 };
>  
> -static struct clk_range sam9g20_pllb_outputs[] = {
> +static const struct clk_range sam9g20_pllb_outputs[] = {
>  	{ .min = 30000000, .max = 100000000 },
>  };
>  
> @@ -182,7 +182,7 @@ static const struct clk_master_characteristics sam9261_mck_characteristics = {
>  	.divisors = { 1, 2, 4, 0 },
>  };
>  
> -static struct clk_range sam9261_plla_outputs[] = {
> +static const struct clk_range sam9261_plla_outputs[] = {
>  	{ .min = 80000000, .max = 200000000 },
>  	{ .min = 190000000, .max = 240000000 },
>  };
> @@ -199,7 +199,7 @@ static u8 sam9261_pllb_out[] = { 1 };
>  
>  static u16 sam9261_pllb_icpll[] = { 1 };
>  
> -static struct clk_range sam9261_pllb_outputs[] = {
> +static const struct clk_range sam9261_pllb_outputs[] = {
>  	{ .min = 70000000, .max = 130000000 },
>  };
>  
> @@ -262,7 +262,7 @@ static const struct clk_master_characteristics sam9263_mck_characteristics = {
>  	.divisors = { 1, 2, 4, 0 },
>  };
>  
> -static struct clk_range sam9263_pll_outputs[] = {
> +static const struct clk_range sam9263_pll_outputs[] = {
>  	{ .min = 80000000, .max = 200000000 },
>  	{ .min = 190000000, .max = 240000000 },
>  };
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index 5aeef68b4bdd..0ac34cdaa106 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -14,7 +14,7 @@ static const struct clk_master_characteristics sam9rl_mck_characteristics = {
>  
>  static u8 sam9rl_plla_out[] = { 0, 2 };
>  
> -static struct clk_range sam9rl_plla_outputs[] = {
> +static const struct clk_range sam9rl_plla_outputs[] = {
>  	{ .min = 80000000, .max = 200000000 },
>  	{ .min = 190000000, .max = 240000000 },
>  };
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index f5cfcbd85f10..0855f3a80cc7 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -17,7 +17,7 @@ static u8 plla_out[] = { 0, 1, 2, 3, 0, 1, 2, 3 };
>  
>  static u16 plla_icpll[] = { 0, 0, 0, 0, 1, 1, 1, 1 };
>  
> -static struct clk_range plla_outputs[] = {
> +static const struct clk_range plla_outputs[] = {
>  	{ .min = 745000000, .max = 800000000 },
>  	{ .min = 695000000, .max = 750000000 },
>  	{ .min = 645000000, .max = 700000000 },
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index fb9e9c4cdc8d..775b77a433f5 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -66,7 +66,7 @@ extern const struct clk_pll_layout sama5d3_pll_layout;
>  struct clk_pll_characteristics {
>  	struct clk_range input;
>  	int num_output;
> -	struct clk_range *output;
> +	const struct clk_range *output;
>  	u16 *icpll;
>  	u8 *out;
>  	u8 upll : 1;
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index 864ac060aed6..6340b1fc1828 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -21,7 +21,7 @@ static const struct clk_master_layout sam9x60_master_layout = {
>  	.offset = 0x28,
>  };
>  
> -static struct clk_range plla_outputs[] = {
> +static const struct clk_range plla_outputs[] = {
>  	{ .min = 300000000, .max = 600000000 },
>  };
>  
> @@ -31,7 +31,7 @@ static const struct clk_pll_characteristics plla_characteristics = {
>  	.output = plla_outputs,
>  };
>  
> -static struct clk_range upll_outputs[] = {
> +static const struct clk_range upll_outputs[] = {
>  	{ .min = 300000000, .max = 500000000 },
>  };
>  
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index 096156850e08..f3d3f6c8e261 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -16,7 +16,7 @@ static u8 plla_out[] = { 0 };
>  
>  static u16 plla_icpll[] = { 0 };
>  
> -static struct clk_range plla_outputs[] = {
> +static const struct clk_range plla_outputs[] = {
>  	{ .min = 600000000, .max = 1200000000 },
>  };
>  
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 840edca77821..25b156d4e645 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -16,7 +16,7 @@ static u8 plla_out[] = { 0 };
>  
>  static u16 plla_icpll[] = { 0 };
>  
> -static struct clk_range plla_outputs[] = {
> +static const struct clk_range plla_outputs[] = {
>  	{ .min = 600000000, .max = 1200000000 },
>  };
>  

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
