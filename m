Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9018220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554407994;
	bh=9sLmNwf/FIuZrYP0jAn5QwWLI5wq+/uVMhCyYisZqb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=br8oc75XfNWLatO5UXm3krU9qEMWro1ufTJLgHvvJ1dYqqo4njicEjwAIy2qX1p6s
	 1NFCzc8NEC7MWtMEFiLVR2f2hiVEdU7MddE0a84NrvKj6AOMPR/UAg67/+nNNGgRE7
	 3Bp5acc2U1VuNkrdA9S7RtK6oYiOairCsM/dMICg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfDDT7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbfDDT7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:59:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA77F20855;
        Thu,  4 Apr 2019 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554407991;
        bh=9sLmNwf/FIuZrYP0jAn5QwWLI5wq+/uVMhCyYisZqb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuJuUtAY06OcoPoqvKnJ0NrZyONtmBL0MqB9OwCZ03Iuwkm97keM5RoufVjqIGecL
         7yiq/50QDk2NY3D28YH6yQPF6vhPmZktZgnyBrghW5JbnMQtiJ+asQzwh48XV3Wycj
         zaxc4qCYTWdxbEl7OapPlBR6uhAbkCkAIRIipPqM=
Date:   Thu, 4 Apr 2019 20:59:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Camylla =?UTF-8?B?R29uw6dhbHZlcw==?= Cantanheide 
        <c.cantanheide@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] iio: adc: ad7766: Change alignment to match paranthesis
Message-ID: <20190404205946.5d5b0a88@archlinux>
In-Reply-To: <20190224214010.10894-1-c.cantanheide@gmail.com>
References: <20190224214010.10894-1-c.cantanheide@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019 18:40:10 -0300
Camylla Gon=C3=A7alves Cantanheide <c.cantanheide@gmail.com> wrote:

> This commit align broken line to match upper line parenthesis,
> in lines 80, 130, 237, 242, 255, 264 and 293. Solves the checkpatch.pl's =
message:
>=20
> CHECK: Alignment should match open parenthesis
>=20
> In lines 130, 255, 264 and 293 it was necessary to break a line.
I missed this at the time, but Greg caught it in the pull request.

No Sign-off so we can't take it (see Developer Certificate or Origin for
why).  Please resend with a sign off and I'll get it queued up for next
time.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7766.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 3ae14fc8c649..101502435768 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -77,7 +77,7 @@ static irqreturn_t ad7766_trigger_handler(int irq, void=
 *p)
>  		goto done;
> =20
>  	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
> -		pf->timestamp);
> +					   pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> =20
> @@ -127,7 +127,8 @@ static int ad7766_postdisable(struct iio_dev *indio_d=
ev)
>  }
> =20
>  static int ad7766_read_raw(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> +			   const struct iio_chan_spec *chan, int *val,
> +			   int *val2, long info)
>  {
>  	struct ad7766 *ad7766 =3D iio_priv(indio_dev);
>  	struct regulator *vref =3D ad7766->reg[AD7766_SUPPLY_VREF].consumer;
> @@ -234,12 +235,12 @@ static int ad7766_probe(struct spi_device *spi)
>  	ad7766->reg[AD7766_SUPPLY_VREF].supply =3D "vref";
> =20
>  	ret =3D devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg),
> -		ad7766->reg);
> +				      ad7766->reg);
>  	if (ret)
>  		return ret;
> =20
>  	ad7766->pd_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdown",
> -		GPIOD_OUT_HIGH);
> +						  GPIOD_OUT_HIGH);
>  	if (IS_ERR(ad7766->pd_gpio))
>  		return PTR_ERR(ad7766->pd_gpio);
> =20
> @@ -252,7 +253,8 @@ static int ad7766_probe(struct spi_device *spi)
> =20
>  	if (spi->irq > 0) {
>  		ad7766->trig =3D devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> -			indio_dev->name, indio_dev->id);
> +						      indio_dev->name,
> +						      indio_dev->id);
>  		if (!ad7766->trig)
>  			return -ENOMEM;
> =20
> @@ -261,8 +263,9 @@ static int ad7766_probe(struct spi_device *spi)
>  		iio_trigger_set_drvdata(ad7766->trig, ad7766);
> =20
>  		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> -			IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
> -			ad7766->trig);
> +				       IRQF_TRIGGER_FALLING,
> +				       dev_name(&spi->dev),
> +				       ad7766->trig);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -290,8 +293,9 @@ static int ad7766_probe(struct spi_device *spi)
>  	spi_message_add_tail(&ad7766->xfer, &ad7766->msg);
> =20
>  	ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -		&iio_pollfunc_store_time, &ad7766_trigger_handler,
> -		&ad7766_buffer_setup_ops);
> +					      &iio_pollfunc_store_time,
> +					      &ad7766_trigger_handler,
> +					      &ad7766_buffer_setup_ops);
>  	if (ret)
>  		return ret;
> =20

