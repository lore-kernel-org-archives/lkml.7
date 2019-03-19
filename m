Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2830C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C458D2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="iiI4nwp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCSMuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:50:00 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47333 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:49:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 31D6525BE0A;
        Tue, 19 Mar 2019 23:49:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552999797; bh=J9/8Rcpky5Qsuj2JXgpaRlr1M/BnVjLZxiQOlcwg1+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iiI4nwp1vVf6sxINm9qllT8sOalz36AwWgt9HxMyB3nGwiNAE2d0jHtCPvQt/D1Hv
         jc0C4q3SVgZepP5IEokgXGbZk3OBmEB3WcwkD45hFbljR8m/Yx+HnMH6F0JF/VLwKi
         EN6EFgjv/a4fAGjT4dvjqWQbL1rWiiCcNQJCbt30=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AA130940663; Tue, 19 Mar 2019 13:49:55 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:49:55 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 5/6] mfd: da9063: remove leftover platform_data
 definitions
Message-ID: <20190319124955.fw5hrwl6jz2tqr6q@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:57PM +0100, Wolfram Sang wrote:
> Not used, not needed, remove them.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  include/linux/mfd/da9063/pdata.h | 65 ----------------------------------------
>  1 file changed, 65 deletions(-)
>  delete mode 100644 include/linux/mfd/da9063/pdata.h
> 
> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
> deleted file mode 100644
> index 21a2d107f0cf..000000000000
> --- a/include/linux/mfd/da9063/pdata.h
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -/*
> - * Platform configuration options for DA9063
> - *
> - * Copyright 2012 Dialog Semiconductor Ltd.
> - *
> - * Author: Michal Hajduk, Dialog Semiconductor
> - * Author: Krystian Garbaciak, Dialog Semiconductor
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - */
> -
> -#ifndef __MFD_DA9063_PDATA_H__
> -#define __MFD_DA9063_PDATA_H__
> -
> -/*
> - * RGB LED configuration
> - */
> -/* LED IDs for flags in struct led_info. */
> -enum {
> -	DA9063_GPIO11_LED,
> -	DA9063_GPIO14_LED,
> -	DA9063_GPIO15_LED,
> -
> -	DA9063_LED_NUM
> -};
> -#define DA9063_LED_ID_MASK		0x3
> -
> -/* LED polarity for flags in struct led_info. */
> -#define DA9063_LED_HIGH_LEVEL_ACTIVE	0x0
> -#define DA9063_LED_LOW_LEVEL_ACTIVE	0x4
> -
> -
> -/*
> - * General PMIC configuration
> - */
> -/* HWMON ADC channels configuration */
> -#define DA9063_FLG_FORCE_IN0_MANUAL_MODE	0x0010
> -#define DA9063_FLG_FORCE_IN0_AUTO_MODE		0x0020
> -#define DA9063_FLG_FORCE_IN1_MANUAL_MODE	0x0040
> -#define DA9063_FLG_FORCE_IN1_AUTO_MODE		0x0080
> -#define DA9063_FLG_FORCE_IN2_MANUAL_MODE	0x0100
> -#define DA9063_FLG_FORCE_IN2_AUTO_MODE		0x0200
> -#define DA9063_FLG_FORCE_IN3_MANUAL_MODE	0x0400
> -#define DA9063_FLG_FORCE_IN3_AUTO_MODE		0x0800
> -
> -/* Disable register caching. */
> -#define DA9063_FLG_NO_CACHE			0x0008
> -
> -struct da9063;
> -
> -/* DA9063 platform data */
> -struct da9063_pdata {
> -	int				(*init)(struct da9063 *da9063);
> -	int				irq_base;
> -	bool				key_power;
> -	unsigned			flags;
> -	struct da9063_regulators_pdata	*regulators_pdata;
> -	struct led_platform_data	*leds_pdata;
> -};
> -
> -#endif	/* __MFD_DA9063_PDATA_H__ */
> -- 
> 2.11.0
> 
