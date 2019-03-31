Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46966C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156912146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554024923;
	bh=eU1ofwcLxJBGCSl/6YWGNdu5Gyz33XPPhyZcv5u2ZLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DYfH8T91t2vMxtk3QNy38KzsiGITqJxGdRrqHTJB0Yb2RvJoGetsVtaIYGnjhLe/5
	 c3obPcrLecP3iWcEY6xNEZuql0hL2RToCRpr9Bqd9BdrgvQFZv9lfRjZ1rgMC6pZHd
	 6zlgNrdXobvLCm1TYlEa8gCaKFyglIMcP1k5RESk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfCaJfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfCaJfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:35:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9D7206DD;
        Sun, 31 Mar 2019 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554024920;
        bh=eU1ofwcLxJBGCSl/6YWGNdu5Gyz33XPPhyZcv5u2ZLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SgvkGCayKfGhAJagnZd4aonFlZg8cjNAYlNgLabmsRqXgcwe8icC2gZdIg6G6/Z5p
         /ZxfAMS4Zi66N0sObtiqNttJJbm1X/KLf5sK+Z6BvNsNne+UqusQ/CAv8DCRWUKzhJ
         p6O/Qtt60T1WrCq3mUJSj8f1BV8pBBvPaMP4OjIw=
Date:   Sun, 31 Mar 2019 10:35:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] staging: iio: adc: ad7280a: Adding temp var to
 improve readability
Message-ID: <20190331103515.019d3501@archlinux>
In-Reply-To: <1d398f3efc0191776b3329f30742b07b6baaa530.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
        <cover.1553447138.git.sicilia.cristian@gmail.com>
        <1d398f3efc0191776b3329f30742b07b6baaa530.1553447138.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 18:23:14 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Creating a temporary variable to improve readability
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
I have already applied this one.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 55 ++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index c2391f6..4ff28f1 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -784,43 +784,38 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	for (i = 0; i < st->scan_cnt; i++) {
>  		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
>  			if (((channels[i] >> 11) & 0xFFF) >=
> -				st->cell_threshhigh)
> -				iio_push_event(indio_dev,
> -					       IIO_EVENT_CODE(IIO_VOLTAGE,
> -							1,
> -							0,
> -							IIO_EV_DIR_RISING,
> -							IIO_EV_TYPE_THRESH,
> -							0, 0, 0),
> +			    st->cell_threshhigh) {
> +				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +							 IIO_EV_DIR_RISING,
> +							 IIO_EV_TYPE_THRESH,
> +							 0, 0, 0);
> +				iio_push_event(indio_dev, tmp,
>  					       iio_get_time_ns(indio_dev));
> -			else if (((channels[i] >> 11) & 0xFFF) <=
> -				st->cell_threshlow)
> -				iio_push_event(indio_dev,
> -					       IIO_EVENT_CODE(IIO_VOLTAGE,
> -							1,
> -							0,
> -							IIO_EV_DIR_FALLING,
> -							IIO_EV_TYPE_THRESH,
> -							0, 0, 0),
> +			} else if (((channels[i] >> 11) & 0xFFF) <=
> +				   st->cell_threshlow) {
> +				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +							 IIO_EV_DIR_FALLING,
> +							 IIO_EV_TYPE_THRESH,
> +							 0, 0, 0);
> +				iio_push_event(indio_dev, tmp,
>  					       iio_get_time_ns(indio_dev));
> +			}
>  		} else {
> -			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
> -				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> -							0,
> +			if (((channels[i] >> 11) & 0xFFF) >=
> +			    st->aux_threshhigh) {
> +				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_RISING),
> +							IIO_EV_DIR_RISING);
> +				iio_push_event(indio_dev, tmp,
>  					       iio_get_time_ns(indio_dev));
> -			else if (((channels[i] >> 11) & 0xFFF) <=
> -				st->aux_threshlow)
> -				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> -							0,
> +			} else if (((channels[i] >> 11) & 0xFFF) <=
> +				st->aux_threshlow) {
> +				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_FALLING),
> +							IIO_EV_DIR_FALLING);
> +				iio_push_event(indio_dev, tmp,
>  					       iio_get_time_ns(indio_dev));
> +			}
>  		}
>  	}
>  

