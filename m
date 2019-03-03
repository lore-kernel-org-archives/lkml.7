Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C9C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F120866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551624213;
	bh=tXnpxCJmmpGpOyVFJJsaoCcuDrSNZthQeM0tHsgV9+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RZZlxnnBrt6ufQLANiACmDPEpfbturHpyB6Vyun1qelcfkL6BseSE4GAxLRlDFuVT
	 SmhMAEa+04EY0d6O/gf09B2Q7AwLCElIiXKvcb6xD7OPvyxzsldoyUm9I8zbzq5XoU
	 uix1ex2/Xh5T9CMOPgdsvoYBe+gX1phgen4I4VzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCCOnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:43:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0EB20830;
        Sun,  3 Mar 2019 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551624210;
        bh=tXnpxCJmmpGpOyVFJJsaoCcuDrSNZthQeM0tHsgV9+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N7nq9gT+Xo1KCPTLJydFuyTbx7V3kMX4R3O45IIsEnLYOiq0ivmEnsV5LIQylgEMk
         cAndeKI8ZsIIn4ZTfemcFd6qbsc86ErKRYJitTmZx/Q+cIISxk+7+0fKqagc5JiBIJ
         53L4hGVTINs3R4/cuMWH2ZqvCDEHK7AAr6YSCWyw=
Date:   Sun, 3 Mar 2019 14:43:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QsOhcmJhcmE=?= Fernandes <barbara.fernandes@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/4] iio:adc:ad7923: Align broken line to parenthesis
Message-ID: <20190303144325.573b288f@archlinux>
In-Reply-To: <20190222203159.15116-2-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
        <20190222203159.15116-2-barbara.fernandes@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 17:31:56 -0300
B=C3=A1rbara Fernandes <barbara.fernandes@usp.br> wrote:

> Get broken line aligned with parenthesis on upper line. Solves
> checkpatch.pl's message:
>=20
> CHECK: Alignment should match open parenthesis
>=20
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.fernandes@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7923.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index d62dbb62be45..ebae7522710a 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -130,7 +130,7 @@ static const struct ad7923_chip_info ad7923_chip_info=
[] =3D {
>   * ad7923_update_scan_mode() setup the spi transfer buffer for the new s=
can mask
>   **/
>  static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *active_scan_mask)
> +				   const unsigned long *active_scan_mask)
>  {
>  	struct ad7923_state *st =3D iio_priv(indio_dev);
>  	int i, cmd, len;
> @@ -181,7 +181,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, vo=
id *p)
>  		goto done;
> =20
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -		iio_get_time_ns(indio_dev));
> +					   iio_get_time_ns(indio_dev));
> =20
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -314,7 +314,7 @@ static int ad7923_probe(struct spi_device *spi)
>  		return ret;
> =20
>  	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> -			&ad7923_trigger_handler, NULL);
> +					 &ad7923_trigger_handler, NULL);
>  	if (ret)
>  		goto error_disable_reg;
> =20

