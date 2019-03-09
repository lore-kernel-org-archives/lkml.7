Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552157138;
	bh=45mXAETSyOWAvkBfb8WV55tAr69FhyjgSxJIQR6nYe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2dQEWbg30tQUwlk2c6KjxP/iOH5utVyBZO9NdQCGnCiqgSrB8c5X/e4Yi+ANDNnx8
	 80MjwQwOCH4T/0UmUVmMOpHlZQ0Zrr18t7EuUxClViOmLE9JvfVDJT4LqMDDQBXDkj
	 uNkePio7JjbSxZakB/LGuPBkUk2mXiH0iGlrnxSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCISpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCISpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:45:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECEBF20657;
        Sat,  9 Mar 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552157135;
        bh=45mXAETSyOWAvkBfb8WV55tAr69FhyjgSxJIQR6nYe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7VPS47YIlgfiCwyf1VKo1lilgm3GBqsgJdNU2XFrBjK7uvvKEyYoA2ZVN3hJJE6n
         zBsYWz0/GAatqdnNudnziHVrPsZgZfQpWIkrKnh2UilvVZwYN1rOVzdFxz5s/DYW73
         AZjurukmwBEqgvwoaL9//UtY9NMvFV4G+6UXErZ0=
Date:   Sat, 9 Mar 2019 18:45:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 2/4] iio:potentiostat:lmp91000: reduce line width and
 remove blank line
Message-ID: <20190309184529.19cd4a05@archlinux>
In-Reply-To: <20190308194655.5983-3-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
        <20190308194655.5983-3-anderson.reis.rosa@usp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 16:46:53 -0300
Anderson Reis <andersonreisrosa@gmail.com> wrote:

> Break the line 258 in order fit the line width on 80 characters. Remove
> the blank line 279, as the line before is also a blank line. Solve these
> checkpath.el WARNING and CHECK:
> 
> - lmp91000.c:258: WARNING: line over 80 characters
> - lmp91000.c:279: CHECK: Please don't use multiple blank lines
Again, not really needed, but doesn't matter much

Applied.

Thanks,

Jonathan

> 
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> ---
>  drivers/iio/potentiostat/lmp91000.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 03d277621861..c45cfb632649 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -255,8 +255,8 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  
>  	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
>  	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> -	regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
> -					| LMP91000_REG_REFCN_50_ZERO);
> +	regmap_write(data->regmap, LMP91000_REG_REFCN,
> +		     LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
>  	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
>  
>  	return 0;
> @@ -276,7 +276,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
>  static const struct iio_trigger_ops lmp91000_trigger_ops = {
>  };
>  
> -
>  static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct lmp91000_data *data = iio_priv(indio_dev);

