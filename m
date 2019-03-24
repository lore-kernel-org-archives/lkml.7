Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D411C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1F2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445285;
	bh=vH88Uyw49blClhZYlBA6ukL83HiHXKs/DS4DMUpvwSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LzAJW8nXl7ikxDtpCyoub/C0kpHeio2/pw5sNV6ESBBpLNP0SQwNyIjx8AlK5TNrX
	 RhNZcH+IXwoGQRMH6SxCg6mPCA+FLZMUNNGtyWMkHL/7rEgJk+K4dgTAuy/Mkar1Ip
	 ClR2wIKXXRR9nzuiQyi2R7w5w0DKmwlUF9oKCZ2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfCXQeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:34:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514DF20685;
        Sun, 24 Mar 2019 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445282;
        bh=vH88Uyw49blClhZYlBA6ukL83HiHXKs/DS4DMUpvwSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKqSPgb6AAZZYmS/bYW8nWr1BSVVyM+CBU4TovYqoBON/YelNS136euNc4HIfJMrA
         FCkfgKaIY1aJWIE4hCrqdxw3WYb9BKNJ3bOFiP/hmAqqo7v7npXI2f6viw6ychUJb/
         6YW6nqDPFH9P0KkI7ixcVDWvRAvl7RUMGEUSMeJ4=
Date:   Sun, 24 Mar 2019 16:34:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, michael.hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v5 1/2] staging: iio: ad5933: change attributes to match
 ABI
Message-ID: <20190324163436.2d33ac32@archlinux>
In-Reply-To: <9a40e23e3eff477dc93c01b33a0e36751a44c0ea.1553192834.git.marcelo.schmitt1@gmail.com>
References: <cover.1553192834.git.marcelo.schmitt1@gmail.com>
        <9a40e23e3eff477dc93c01b33a0e36751a44c0ea.1553192834.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 15:42:13 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Change device attributes' names to match ABI documentation. Names were
> chosen such that they tend to be similar to existing ABI so it should
> be easier to standardize them when necessary.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
Change log here.

Anyhow, I looked back so fairly obviously what changed.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

>  .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d75bdfbf93de..2b0f8f899e3f 100644
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
> @@ -443,12 +443,12 @@ static ssize_t ad5933_store(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
> +static IIO_DEVICE_ATTR(out_altvoltage0_raw, 0644,
>  			ad5933_show,
>  			ad5933_store,
>  			AD5933_OUT_RANGE);
>  
> -static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
> +static IIO_DEVICE_ATTR(out_altvoltage0_scale_available, 0444,
>  			ad5933_show,
>  			NULL,
>  			AD5933_OUT_RANGE_AVAIL);
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

