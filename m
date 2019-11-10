Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67EBC17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD84C2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573392437;
	bh=4gBDujHHAOpGpaUZUSbRIfz6nvgA9ClvVnBskRh9zE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S7L8WKMVaans9BcaQOYfLu3aCSDABa2J2zBt35B6Iw3K/N6rlTWmIW7cMQv4vdhzF
	 r0oi27gteOJPS2Op3ghYTYVM+OuScvRBTnvFIkUOq317iu7+aJWtgDAFlTyjUwV3oP
	 rbP2TUOU0DsUwPduHvXsv6mundudRHDeKgGjskxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfKJN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 08:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfKJN1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 08:27:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7540220842;
        Sun, 10 Nov 2019 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573392435;
        bh=4gBDujHHAOpGpaUZUSbRIfz6nvgA9ClvVnBskRh9zE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAJgmTY6XUDmcBXRdE2CM4pzNAUzAo2858X3WLg8vaXtlEaSzh3wv5uBfqj4hsNw2
         UvOxe3zPV5v4fKi3tTf2K/ZdHy2G5nmqQHDdr22yXK+PUyHOBos9lZkZIEp5r36tas
         QpshVRZlBvOY8MFMUOAVuEJAop7fyMZvuZKcLANU=
Date:   Sun, 10 Nov 2019 13:27:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pedro Ortega <portega.kernel@gmx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7280: Add spaces around math
 operator
Message-ID: <20191110132710.0e9300dc@archlinux>
In-Reply-To: <20191109151729.3792-1-portega.kernel@gmx.com>
References: <20191109151729.3792-1-portega.kernel@gmx.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Nov 2019 16:17:28 +0100
Pedro Ortega <portega.kernel@gmx.com> wrote:

> Add spaces around the minus math operator to increase readability.
> 
> Signed-off-by: Pedro Ortega <portega.kernel@gmx.com>
Hi Pedro,

Afraid not.  Look at what that macro is actually doing.  That's not a maths
operator at all.  I'm fairly sure we had a plan to actually hide these
examples away as we get a few people suggesting this 'fix' ever year.
Not sure what happened to them though, I'll have to check back.

Sorry about this, but it is a good lesson in making sure you check
that the suggestion from checkpatch is actually correct.  It's a
pattern matcher, it can't always know enough to be able to tell what
is going on.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 19a5f244dcae..34ca0d09db85 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
> 
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -			     in_voltage-voltage_thresh_low_value,
> +			     in_voltage - voltage_thresh_low_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
>  			     AD7280A_CELL_UNDERVOLTAGE);
> 
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -			     in_voltage-voltage_thresh_high_value,
> +			     in_voltage - voltage_thresh_high_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
> --
> 2.17.1
> 

