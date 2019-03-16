Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29292218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552755427;
	bh=IUcLFuDlICUROJ6wZx7QspOWCzJQ7JgKZlHRPAQFK8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SkhCKaIln8SCpIQkUxiO6sGCsyJrJFbcc6krO+ypVJEemT391P7adZbsI6hVcLAEC
	 IPpXZhyMwJVMAFCZJHGLmNwwNKPvzchHeBf4jveXAWIaX6LdA85Un7xZOoOqHtOVQW
	 agf9iNh3z9npZeuYq9LabTJngIMWIVBJNc99Q9FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCPQ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfCPQ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:57:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078842186A;
        Sat, 16 Mar 2019 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552755423;
        bh=IUcLFuDlICUROJ6wZx7QspOWCzJQ7JgKZlHRPAQFK8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EYZ+eemlpMDmcWngmOgeOKWqrqdyWpslFW6xXL7q8QFyuYwjgslHMqJa/mTm7AAJF
         RXzohacISDN8Av8olta/zedH4jOT5a03Cs9unAkzAe9fKoGwWlsCjCdvt7pHXqjh0p
         Dhr2RCFj7M4qGM9+zCN5Ahca++y/MaWYLmzc3zrs=
Date:   Sat, 16 Mar 2019 16:56:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7192: Convert platform data to
 DT properties
Message-ID: <20190316165658.0cdc2f49@archlinux>
In-Reply-To: <20190315112903.15855-2-mircea.caprioru@analog.com>
References: <20190315112903.15855-1-mircea.caprioru@analog.com>
        <20190315112903.15855-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 13:29:03 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch will remove platform data members and replace them with device
> tree properties. These properties will be subject to further modifications
> and probably replaced with other functionalities at some point in time.

=46rom the description I was initially thinking this would be a crazy
temporary binding but as they all seem to be reasonably sensible
(even if we haven't formally reviewed the binding yet so they may change)
I'm happy to take this as a step in the right direction.

>=20
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 33 ++++++++++++++++++++------------
>  drivers/staging/iio/adc/ad7192.h |  7 -------
>  2 files changed, 21 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/a=
d7192.c
> index 5c54ce380fa5..c56eaefbbe41 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -250,10 +250,11 @@ static int ad7192_of_clock_select(struct ad7192_sta=
te *st)
>  	return clock_sel;
>  }
> =20
> -static int ad7192_setup(struct ad7192_state *st,
> -			const struct ad7192_platform_data *pdata)
> +static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  {
>  	struct iio_dev *indio_dev =3D spi_get_drvdata(st->sd.spi);
> +	bool rej60_en, sinc3_en, refin2_en, chop_en;
> +	bool buf_en, bipolar, burnout_curr_en;
>  	unsigned long long scale_uv;
>  	int i, ret, id;
> =20
> @@ -280,18 +281,22 @@ static int ad7192_setup(struct ad7192_state *st,
> =20
>  	st->conf =3D AD7192_CONF_GAIN(0);
> =20
> -	if (pdata->rej60_en)
> +	rej60_en =3D of_property_read_bool(np, "adi,rejection-60-Hz-enable");
> +	if (rej60_en)
>  		st->mode |=3D AD7192_MODE_REJ60;
> =20
> -	if (pdata->sinc3_en)
> +	sinc3_en =3D of_property_read_bool(np, "adi,sinc3-filter-enable");
> +	if (sinc3_en)
>  		st->mode |=3D AD7192_MODE_SINC3;
> =20
> -	if (pdata->refin2_en && st->devid !=3D ID_AD7195)
> +	refin2_en =3D of_property_read_bool(np, "adi,refin2-pins-enable");
> +	if (refin2_en && st->devid !=3D ID_AD7195)
>  		st->conf |=3D AD7192_CONF_REFSEL;
> =20
> -	if (pdata->chop_en) {
> +	chop_en =3D of_property_read_bool(np, "adi,chop-enable");
> +	if (chop_en) {
>  		st->conf |=3D AD7192_CONF_CHOP;
> -		if (pdata->sinc3_en)
> +		if (sinc3_en)
>  			st->f_order =3D 3; /* SINC 3rd order */
>  		else
>  			st->f_order =3D 4; /* SINC 4th order */
> @@ -299,15 +304,19 @@ static int ad7192_setup(struct ad7192_state *st,
>  		st->f_order =3D 1;
>  	}
> =20
> -	if (pdata->buf_en)
> +	buf_en =3D of_property_read_bool(np, "adi,buffer-enable");
> +	if (buf_en)
>  		st->conf |=3D AD7192_CONF_BUF;
> =20
> -	if (pdata->unipolar_en)
> +	bipolar =3D of_property_read_bool(np, "bipolar");
> +	if (!bipolar)
>  		st->conf |=3D AD7192_CONF_UNIPOLAR;
> =20
> -	if (pdata->burnout_curr_en && pdata->buf_en && !pdata->chop_en) {
> +	burnout_curr_en =3D of_property_read_bool(np,
> +						"adi,burnout-currents-enable");
> +	if (burnout_curr_en && buf_en && !chop_en) {
>  		st->conf |=3D AD7192_CONF_BURN;
> -	} else if (pdata->burnout_curr_en) {
> +	} else if (burnout_curr_en) {
>  		dev_warn(&st->sd.spi->dev,
>  			 "Can't enable burnout currents: see CHOP or buffer\n");
>  	}
> @@ -735,7 +744,7 @@ static int ad7192_probe(struct spi_device *spi)
>  		}
>  	}
> =20
> -	ret =3D ad7192_setup(st, pdata);
> +	ret =3D ad7192_setup(st, spi->dev.of_node);
>  	if (ret)
>  		goto error_disable_clk;
> =20
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/a=
d7192.h
> index 3be3ee269ed5..aa3322c14e38 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -33,13 +33,6 @@
> =20
>  struct ad7192_platform_data {
>  	u16		vref_mv;
> -	bool		refin2_en;
> -	bool		rej60_en;
> -	bool		sinc3_en;
> -	bool		chop_en;
> -	bool		buf_en;
> -	bool		unipolar_en;
> -	bool		burnout_curr_en;
>  };
> =20
>  #endif /* IIO_ADC_AD7192_H_ */

