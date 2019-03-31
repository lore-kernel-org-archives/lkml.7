Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D68C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315B820989
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554024599;
	bh=zhhun6mQ82gwyWR4UdaJuqLb1UL/DUD2L9k6gira5bc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0kL1jfQ0n4EfC5POt7ce+AhHSmeC/rl0FI5S5T3azcg2bure4Ks7xTaC3sZ/aa4WD
	 2zwOF7S53Ymivsgz7xnLUVHlqlwpAqJGzOkh9R+SaC1XbnTBYuEJdM2Poi9E3Tr03/
	 RO/5SxBx5lAjBMRGGt3Rn+oD179eTCrJulQi/fNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCaJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfCaJ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:29:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C230206DD;
        Sun, 31 Mar 2019 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554024596;
        bh=zhhun6mQ82gwyWR4UdaJuqLb1UL/DUD2L9k6gira5bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2LvkKnyhWaKjCI7r7gtdqnHvHPnkMAfyR6q+7ILTRyDzkyki95+4+tY6geoU0ozog
         +rG8uzkUarFko4bNKUupArbBlxUzW/+AniljUdIUpqWWKRivycTvERxGNl2Q4MEgig
         rBjAbzlouDYvUjE41qH5vRmups/DZo1Wmh5Io4Ec=
Date:   Sun, 31 Mar 2019 10:29:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] staging: iio: adc: ad7280a: Tab alignment
Message-ID: <20190331102947.5fdffbb9@archlinux>
In-Reply-To: <cc87225c83ca9d0aa18598d3f3519965bbc14764.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
        <cover.1553447138.git.sicilia.cristian@gmail.com>
        <cc87225c83ca9d0aa18598d3f3519965bbc14764.1553447138.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 18:23:09 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Aligned some parameters.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d9df126..571535d 100644
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
> +			     in_voltage-voltage_thresh_low_value,
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
> +			     in_voltage-voltage_thresh_high_value,
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

