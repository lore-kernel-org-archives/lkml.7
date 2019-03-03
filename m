Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C21C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3620866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551614519;
	bh=YjxwWWvpW6yuX0IiUvg0tiNWFBIz09WOon+wWCI89nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uEPQ/lxg9RXpDbntwPGkLbIwgxAwVT1UdUcPbLcXTZ4KWdl01dsF75DRcIB5nBgmM
	 VXjRHPK7zOczD+8I019pI2B9xoBC05jgfIti3voLzBwOoCRdlZwsf03nns3r9Cjexu
	 RENcpITzBjL6C3nlbUELQeyyw7u5+GmojvMTZMXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCCMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfCCMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:01:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B586720857;
        Sun,  3 Mar 2019 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551614516;
        bh=YjxwWWvpW6yuX0IiUvg0tiNWFBIz09WOon+wWCI89nU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bHOjgra8rlE3VoQJ+GX+3GCQJ6g55hO02Oq7jj2n8fbjU/1/n/v+XuYr2cX9uQKR8
         DE4Q+YPdSm9I5+9wIu8qZjusz60wbPJg9bZE+ifddomch5Zy25+Fv0sxTQuDo9f/GS
         RAm4ChkqfeZkXE5nVP7T4vL3MWggbWDQu83pTwAg=
Date:   Sun, 3 Mar 2019 12:01:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/4] staging: iio: ad5933: add SPDX identifier
Message-ID: <20190303120151.6b40fe53@archlinux>
In-Reply-To: <20190301025230.2cws5uths6yyuo5t@smtp.gmail.com>
References: <20190301025230.2cws5uths6yyuo5t@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 23:52:30 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add SPDX identifier of GPL-2.0 for the ad5933 driver.
> Organize imports.
> Make multi-line comments compliant with the preferred code style.

One type of change per patch please.
So this is at least 3 patches.
SPDX,
Imports,
comment style.

Actual contents looks fine.

Jonathan

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 30 ++++++++++---------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3134295f014f..d75bdfbf93de 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -1,27 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5933 AD5934 Impedance Converter, Network Analyzer
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
> -#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/sysfs.h>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>
> -#include <linux/err.h>
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/clk.h>
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
>  
>  /* AD5933/AD5934 Registers */
>  #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
> @@ -474,7 +473,8 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
>  			ad5933_store,
>  			AD5933_OUT_SETTLING_CYCLES);
>  
> -/* note:
> +/*
> + * note:
>   * ideally we would handle the scale attributes via the iio_info
>   * (read|write)_raw methods, however this part is a untypical since we
>   * don't create dedicated sysfs channel attributes for out0 and in0.
> @@ -572,7 +572,8 @@ static int ad5933_ring_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  
> -	/* AD5933_CTRL_INIT_START_FREQ:
> +	/*
> +	 * AD5933_CTRL_INIT_START_FREQ:
>  	 * High Q complex circuits require a long time to reach steady state.
>  	 * To facilitate the measurement of such impedances, this mode allows
>  	 * the user full control of the settling time requirement before
> @@ -663,7 +664,8 @@ static void ad5933_work(struct work_struct *work)
>  	}
>  
>  	if (status & AD5933_STAT_SWEEP_DONE) {
> -		/* last sample received - power down do
> +		/*
> +		 * last sample received - power down do
>  		 * nothing until the ring enable is toggled
>  		 */
>  		ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);

