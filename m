Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F5C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD81222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553430960;
	bh=VAeWYkBFrXz4Y/alOCKuGPJydOEhKaNqGrN5rkedDFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0IJ7lUEqFcUvtDqaga3Npv+1HPyfk8vIc88aSRTFEvvrYHlH38YFNpmNdaLehsjkh
	 3zoY0PQMta5tJFDIGI8ELSHtMvFYVwCB7kDy8um7XRpfyIs+qTroEzaiemicaiDWeW
	 /QniMFgBZPmxF+I3eDZrLUq3s3K1bRhDHOIJoU1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfCXMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfCXMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:35:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E193222D0;
        Sun, 24 Mar 2019 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553430958;
        bh=VAeWYkBFrXz4Y/alOCKuGPJydOEhKaNqGrN5rkedDFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8rG/qahOfzzTExrnAfU1QCSLHtRk3tBnrOF3UaRzfzR7IspwiBFToD6lfwJjcOl+
         W1V19LAhhXOTf/GKUhuiy2KGxwhsPRLg2ogXDTmFw0++5yxY97pfQ+50MuqXNO1nuV
         8Jtu7E7aBFckZg5gHYPtxn8wpVdvnDWNS6Q9BHJo=
Date:   Sun, 24 Mar 2019 12:35:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: iio: adc: Tab alignment
Message-ID: <20190324123552.4b4ad025@archlinux>
In-Reply-To: <70101e0eaa253140218d833223e0862d8851c01d.1553366098.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
        <cover.1553366098.git.sicilia.cristian@gmail.com>
        <70101e0eaa253140218d833223e0862d8851c01d.1553366098.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 20:21:36 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Aligned some parameters.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d9df126..55b5879 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -830,30 +830,30 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> -		0644,
> -		ad7280_read_channel_config,
> -		ad7280_write_channel_config,
> -		AD7280A_CELL_UNDERVOLTAGE);
> +			     in_voltage - voltage_thresh_low_value,
Firstly, that isn't in your description and secondly you just
broke the userspace ABI.  Take a very good look at what is happening here.

> +			     0644,
> +			     ad7280_read_channel_config,
> +			     ad7280_write_channel_config,
> +			     AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -		in_voltage-voltage_thresh_high_value,
> -		0644,
> -		ad7280_read_channel_config,
> -		ad7280_write_channel_config,
> -		AD7280A_CELL_OVERVOLTAGE);
> +			     in_voltage - voltage_thresh_high_value,
> +			     0644,
> +			     ad7280_read_channel_config,
> +			     ad7280_write_channel_config,
> +			     AD7280A_CELL_OVERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> -		0644,
> -		ad7280_read_channel_config,
> -		ad7280_write_channel_config,
> -		AD7280A_AUX_ADC_UNDERVOLTAGE);
> +		       0644,
> +		       ad7280_read_channel_config,
> +		       ad7280_write_channel_config,
> +		       AD7280A_AUX_ADC_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> -		0644,
> -		ad7280_read_channel_config,
> -		ad7280_write_channel_config,
> -		AD7280A_AUX_ADC_OVERVOLTAGE);
> +		       0644,
> +		       ad7280_read_channel_config,
> +		       ad7280_write_channel_config,
> +		       AD7280A_AUX_ADC_OVERVOLTAGE);
>  
>  static struct attribute *ad7280_event_attributes[] = {
>  	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,

