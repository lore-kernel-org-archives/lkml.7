Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1A2C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB76A21738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554633797;
	bh=nObBJIX8XOIuxWwrFZ2KWxpYiR4ElR6c7/b2reo1RGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kisYTJjrs4KNmSzceXARIP8sgVbKco39Cb0bB/TslvIY7OJcHoD6HxNEn0Pzg3dPA
	 mT+ma9fGJ+92vT5XuXC0L1pXsyP0jGSisiXcLo4wKADmVTNHMAHwNrX7vE6uud4YXP
	 5dXE54z46MqmCxHbqXLCDb25qeLw+UjhvX2vGsRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDGKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDGKnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:43:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7655820B1F;
        Sun,  7 Apr 2019 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554633795;
        bh=nObBJIX8XOIuxWwrFZ2KWxpYiR4ElR6c7/b2reo1RGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uXlB49seiERoQdb9OFeRzBRR4LCripdzCF67Nxdb5CjaSIE1+Ii4uYm4zYsn6VhR8
         y0x+cNIY/6rZj136bT+fL1HT6QnTXQKnO+c0cutdmKhvwXLXP/Pq91KtAhHcvllmkh
         SGo6WtJL5T4/DkePZ/nDEEPlSj/Pu1C+bXN1SJVw=
Date:   Sun, 7 Apr 2019 11:43:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: frequency: ad9834: Remove unnecessary
 parentheses
Message-ID: <20190407114305.324a794e@archlinux>
In-Reply-To: <20190402201854.du6x75rkcm2ijmsc@smtp.gmail.com>
References: <20190402201854.du6x75rkcm2ijmsc@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 17:18:54 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> Remove unneeded parentheses around the arguments of ||. This reduces
> clutter and code behave in the same way. Change suggested by
> checkpatch.pl.
> 
> CHECK: Unnecessary parentheses around 'st->devid == ID_AD9833'
> CHECK: Unnecessary parentheses around 'st->devid == ID_AD9837'
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
This isn't one I feel strongly about, but it'll get rid of the warning
so is useful in the sense of cleaning up what we have to look at there!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9834.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 0b0287503fb4..9cc6e751b479 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -286,7 +286,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
>  	struct ad9834_state *st = iio_priv(indio_dev);
>  	char *str;
>  
> -	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))
> +	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
>  		str = "sine triangle square";
>  	else if (st->control & AD9834_OPBITEN)
>  		str = "sine";

