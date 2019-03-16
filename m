Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8EC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB5A218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552761789;
	bh=Hg4jvuWzwqAXW7dBBDPY3e1+ZK/P75chlF91bxx8Q04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FO5h7mnGYw8QZLa7G6ell3oXyBP27tsjfMI60wTg3NIENe42ueip2y/b3BUEA1Fo8
	 4PXyCu5LBnzuMhCeyr49DwhPQm/Ligqn1uS8p4odwZM5A2RmIYZXenycmbqmVulfOD
	 S+7UBqGSVU4+CD6eLq8ZtBHG+TmPCzkzp169Xx/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCPSnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCPSnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:43:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049C0218D0;
        Sat, 16 Mar 2019 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552761786;
        bh=Hg4jvuWzwqAXW7dBBDPY3e1+ZK/P75chlF91bxx8Q04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jkzdWzOsi4FBqJL+/nkUVLvW+mptc0UPwtQLtVidabQhZ3WWo6AIs0oeO5Ij8tVom
         4CUt1eAi5uk/CONuClErVxnhdCeleoBmJg43/sskzjeem5RhqrbYScdMITMirYO0iE
         kNw4722pyEsVS5iQHO9X3tNbOUE+SNFb4/Xi7LGw=
Date:   Sat, 16 Mar 2019 18:43:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 6/7] staging: iio: ad5933: change attributes to match
 ABI
Message-ID: <20190316184301.24ef78b9@archlinux>
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
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

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

