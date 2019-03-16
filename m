Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF48C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755CB218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552762369;
	bh=3xrliemf2nXFlqJ33yYbjb0dCpz8sM/chhfwNxHFXac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=akMlZac7n6A+vpJXGRolKm5UOPDzB9YvyE888Ezis3/nKFU+kX7JvqM9noRI1+cPv
	 T4rfeCB+YlNlqlBKQfo7uDbKVB82Zacg3GlWtok78c4RURKQ+ibyZqoeFez/pWfKLO
	 uVoQuovVjayJhjijhdm36EFmq5HMuhEsDPJBHyks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCPSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCPSwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:52:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E005D218D0;
        Sat, 16 Mar 2019 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552762363;
        bh=3xrliemf2nXFlqJ33yYbjb0dCpz8sM/chhfwNxHFXac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xyi589y1JYa0MtMPrJ0Zw08N5huilwCqqkl2J2R0exZhHvsgKerGaqDQoPhcq2fN1
         RpVPeMMNAZwu8dL22bXemKl1pcI9H6v9NwyteTbvPddmf4jKLsaoZWtylEGTvA6UiV
         PZ4sOh8Le4O6ksVJCsbDb81p3kiwGyBUSQ2MKOss=
Date:   Sat, 16 Mar 2019 18:52:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 6/7] staging: iio: ad5933: change attributes to match
 ABI
Message-ID: <20190316185238.07acaafd@archlinux>
In-Reply-To: <20190316150755.ssqh5b2f55ln4fq5@smtp.gmail.com>
References: <20190316150755.ssqh5b2f55ln4fq5@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 12:07:55 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Change device attributes' names to match ABI documentation. Names were
> chosen such that they tend to be similar to existing ABI so it should
> be easier to standardize them when necessary.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
I spoke too soon on this one... 

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d75bdfbf93de..262415bc659d 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -315,12 +315,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency_start, 0644,
>  			ad5933_show_frequency,
>  			ad5933_store_frequency,
>  			AD5933_REG_FREQ_START);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency_increment, 0644,
>  			ad5933_show_frequency,
>  			ad5933_store_frequency,
>  			AD5933_REG_FREQ_INC);
> @@ -463,12 +463,12 @@ static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
>  			NULL,
>  			AD5933_IN_PGA_GAIN_AVAIL);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency_points, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_FREQ_POINTS);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
> +static IIO_DEVICE_ATTR(out_altvoltage0_settling_cycles, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_OUT_SETTLING_CYCLES);
> @@ -480,12 +480,12 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
>   * don't create dedicated sysfs channel attributes for out0 and in0.
>   */
>  static struct attribute *ad5933_attributes[] = {
> -	&iio_dev_attr_out_voltage0_scale.dev_attr.attr,
> -	&iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
you rename this here, but not in the place where it's defined.

Doesn't build.
> -	&iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
> -	&iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
> -	&iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
> -	&iio_dev_attr_out_voltage0_settling_cycles.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_raw.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_scale_available.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_frequency_start.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_frequency_increment.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_frequency_points.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage0_settling_cycles.dev_attr.attr,
>  	&iio_dev_attr_in_voltage0_scale.dev_attr.attr,
>  	&iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
>  	NULL

