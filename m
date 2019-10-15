Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC19C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9B20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfJOOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:11:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45695 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfJOOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:11:10 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iKNXX-0008Mj-FA; Tue, 15 Oct 2019 16:11:07 +0200
Message-ID: <178c5c3a962c05380b3d94b8acd5f454c9e2786a.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpc: fix initialiser format
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 15 Oct 2019 16:11:07 +0200
In-Reply-To: <20191015140909.778-1-ben.dooks@codethink.co.uk>
References: <20191015140909.778-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-10-15 at 15:09 +0100, Ben Dooks wrote:
> Make the initialiers in imx_gpc_domains C99 format to fix the
> following sparse warnings:
> 
> drivers/soc/imx/gpc.c:252:30: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:258:29: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:269:34: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:278:30: warning: obsolete array initializer, use C99 syntax
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/soc/imx/gpc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index d9231bd3c691..98b9d9a902ae 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -249,13 +249,13 @@ static struct genpd_power_state imx6_pm_domain_pu_state = {
>  };
>  
>  static struct imx_pm_domain imx_gpc_domains[] = {
> -	[GPC_PGC_DOMAIN_ARM] {
> +	[GPC_PGC_DOMAIN_ARM] = {
>  		.base = {
>  			.name = "ARM",
>  			.flags = GENPD_FLAG_ALWAYS_ON,
>  		},
>  	},
> -	[GPC_PGC_DOMAIN_PU] {
> +	[GPC_PGC_DOMAIN_PU] = {
>  		.base = {
>  			.name = "PU",
>  			.power_off = imx6_pm_domain_power_off,
> @@ -266,7 +266,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  		.reg_offs = 0x260,
>  		.cntr_pdn_bit = 0,
>  	},
> -	[GPC_PGC_DOMAIN_DISPLAY] {
> +	[GPC_PGC_DOMAIN_DISPLAY] = {
>  		.base = {
>  			.name = "DISPLAY",
>  			.power_off = imx6_pm_domain_power_off,
> @@ -275,7 +275,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  		.reg_offs = 0x240,
>  		.cntr_pdn_bit = 4,
>  	},
> -	[GPC_PGC_DOMAIN_PCI] {
> +	[GPC_PGC_DOMAIN_PCI] = {
>  		.base = {
>  			.name = "PCI",
>  			.power_off = imx6_pm_domain_power_off,

