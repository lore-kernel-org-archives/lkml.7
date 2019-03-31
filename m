Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20469C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3E2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554025049;
	bh=Kr5TyAW8oUsN+4Otq0Rx8ylgkzyzvKZ0ddxyrdh72pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aA/16wu7x49A2IVlQQTYNeN/QJIQfc7n1NWlLXsMynNBB5C+Tg3W5A+bU37FFR/l8
	 +L1Nfazaapkxm6WXQ3P4xxFUeUXCr6hwBUpzrG1DSHx6W/wYYvn7+1fxHYsAR1iaR6
	 dh8qPXC4A5pasNA0sjqBOoqhf06vvIiEadWKpvhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfCaJh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfCaJh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:37:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAA6206DD;
        Sun, 31 Mar 2019 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554025046;
        bh=Kr5TyAW8oUsN+4Otq0Rx8ylgkzyzvKZ0ddxyrdh72pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vHQfYbFZ28SVW54f0INkWw0zER+g7ZryMfVxUFac/b/cvr6wafUeZd/F1SBoond94
         6enhcks7VZb2KS1sNsz4zbhHQrxoCiKUUzyj9+EpIJ6Nh8fNHoL27M/Pos9+7XuD8z
         speLzXSCExR9jANAMUYch0B9yQm+RvvSk6F48WMU=
Date:   Sun, 31 Mar 2019 10:37:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] staging: iio: adc: ad7280a: Remove CamelCase
 notation
Message-ID: <20190331103720.257ac35b@archlinux>
In-Reply-To: <e1f26b39dd421d848d5579bd5540644e71416edb.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
        <cover.1553447138.git.sicilia.cristian@gmail.com>
        <e1f26b39dd421d848d5579bd5540644e71416edb.1553447138.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 18:23:16 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Fix CamelCase naming.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
Already applied this one as well.

So whole set has been applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 4ff28f1..229dcad 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -917,8 +917,8 @@ static int ad7280_probe(struct spi_device *spi)
>  	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7280_state *st;
>  	int ret;
> -	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
> -	const unsigned short nAVG[4] = {1, 2, 4, 8};
> +	const unsigned short t_acq_ns[4] = {465, 1010, 1460, 1890};
> +	const unsigned short n_avg[4] = {1, 2, 4, 8};
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -966,10 +966,9 @@ static int ad7280_probe(struct spi_device *spi)
>  	 */
>  
>  	st->readback_delay_us =
> -		((tACQ_ns[pdata->acquisition_time & 0x3] + 695) *
> -		(AD7280A_NUM_CH * nAVG[pdata->conversion_averaging & 0x3]))
> -		- tACQ_ns[pdata->acquisition_time & 0x3] +
> -		st->slave_num * 250;
> +		((t_acq_ns[pdata->acquisition_time & 0x3] + 695) *
> +		 (AD7280A_NUM_CH * n_avg[pdata->conversion_averaging & 0x3])) -
> +		t_acq_ns[pdata->acquisition_time & 0x3] + st->slave_num * 250;
>  
>  	/* Convert to usecs */
>  	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);

