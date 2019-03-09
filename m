Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F1BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D8C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552157183;
	bh=ETOa1PhwQcdXb0xJsVfMLZm5qrMIVAOz6Zsi49R433w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YyWY7+uWZWLZN0022V2VSsygHXyc9tJL1k0KrrfaQiyhAEp50kOmHh2FnotKp9gRk
	 bU5ME9fEyI+gWmRej4HYzPjxDqZZeDPbxd8LjxixAGVLUKOhK5qzW55RuIDQt7uo7D
	 Nc+uRojsNvkvUtIC14ECowy0UVEjo+ASVe46/rFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCISqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCISqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:46:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C5820657;
        Sat,  9 Mar 2019 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552157180;
        bh=ETOa1PhwQcdXb0xJsVfMLZm5qrMIVAOz6Zsi49R433w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tBNb6vvNt98ABA/fAanLr5d1/A/9sLUj8Zxbd7Fy6Q83fCrgIXyMpJAmho9bXLfWy
         pPrahXEdHuRm+7o/PQKYj5iZN11mrwOQjb/jFy9LGRovE4OwPTj1DtvcHkBgLYyQ6j
         pBhiWSHZic9i0hOgi36fwcWeURrZsevLwAPLHdRc=
Date:   Sat, 9 Mar 2019 18:46:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 3/4] iio:potentiostat:lmp91000: invert if statement
Message-ID: <20190309184615.54feca1d@archlinux>
In-Reply-To: <20190308194655.5983-4-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
        <20190308194655.5983-4-anderson.reis.rosa@usp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 16:46:54 -0300
Anderson Reis <andersonreisrosa@gmail.com> wrote:

> Invert if statement arms in line 214, in order to make the code cleaner,
> solve these checkpatch.pl CHECKs:
> 
> - lmp9100.c:214: CHECK: braces {} should be used on all arms of this statement
> - lmp9100.c:216: CHECK: Unbalanced braces around else statement
> 
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index c45cfb632649..1de17924e154 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -211,12 +211,11 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  
>  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>  	if (ret) {
> -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
> -			val = 0;
> -		else {
> +		if (!of_property_read_bool(np, "ti,external-tia-resistor"))
>  			dev_err(dev, "no ti,tia-gain-ohm defined");
>  			return ret;
>  		}
> +		val = 0;
>  	}
>  
>  	ret = -EINVAL;

