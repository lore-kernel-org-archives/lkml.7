Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37177C072AD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C220449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558288043;
	bh=RyNE3JZI+YlVkh2xmqXpb/nqf7T44OMg4tbBzoAptd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d4rC4E38mTY/hqfVkCrgb4BOLws1pm4DIRiGz3FDDPVkdLBgjpcVZ2C/NRaJ2dLaq
	 G9dBk1pLtDv4KmsMJnhwXqWeWsGbQT3myuK4nEDnkowRKbgCTiL+m0S0Pvvi4f3wvD
	 ny8Lxjtt9/4W1gKiKN0qSELfFqdYxi6nojuT5W3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfESRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfESRrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:47:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25BB2166E;
        Sun, 19 May 2019 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558262395;
        bh=RyNE3JZI+YlVkh2xmqXpb/nqf7T44OMg4tbBzoAptd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DcFOs9rBccmqfj2/A5J39xMlqtyK3GPley+aNW2gw3VN2hcxpHPHwlFPx815OXaxw
         5urhXnD993Z4elcFm17Or6W5hVau+UBKwXKfwcpllVHj1cmgjIAZGjhWVZou2Imf59
         tGJkz0mUX3Zk/JFelARILN3RJNBgaMlMXpzJ7IGM=
Date:   Sun, 19 May 2019 11:39:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?Sm/Do28=?= Victor Marques de Oliveira 
        <joao.marques.oliveira@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        "Thiago L . A . Miller" <tmiller@mochsl.org.br>,
        "Osvaldo M . Yasuda" <omyasuda@yahoo.com.br>
Subject: Re: [PATCH] staging: iio: ad9834: add of_device_id table
Message-ID: <20190519113949.2eb0cd3a@archlinux>
In-Reply-To: <20190518224720.30404-1-joao.marques.oliveira@usp.br>
References: <20190518224720.30404-1-joao.marques.oliveira@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019 19:47:20 -0300
Jo=C3=A3o Victor Marques de Oliveira         <joao.marques.oliveira@usp.br>=
 wrote:

> Add a of_device_id struct array of_match_table variable and subsequent
> call to MODULE_DEVICE_TABLE macro to device tree support.
>=20
> Co-developed-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> Signed-off-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> Co-developed-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> Signed-off-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> Signed-off-by: Jo=C3=A3o Victor Marques de Oliveira <joao.marques.oliveir=
a@usp.br>
Nice patch.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

j
> ---
>  drivers/staging/iio/frequency/ad9834.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio=
/frequency/ad9834.c
> index 6de3cd7363d7..038d6732c3fd 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -521,9 +521,20 @@ static const struct spi_device_id ad9834_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, ad9834_id);
> =20
> +static const struct of_device_id ad9834_of_match[] =3D {
> +	{.compatible =3D "adi,ad9833"},
> +	{.compatible =3D "adi,ad9834"},
> +	{.compatible =3D "adi,ad9837"},
> +	{.compatible =3D "adi,ad9838"},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad9834_of_match);
> +
>  static struct spi_driver ad9834_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ad9834",
> +		.of_match_table =3D ad9834_of_match
>  	},
>  	.probe		=3D ad9834_probe,
>  	.remove		=3D ad9834_remove,

