Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE80C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E689218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552761481;
	bh=EjHprr2erqog/YU+osYmPQNuD/b9AKLLKl2Mm72mso8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=toKQJKq0ydR4xp9eWFUsUBGZn9mb/0MJC9W+a9Grui3t8s5g3ym9mWEp4MKhB3R1z
	 SnnYIYgGBYRsdtL67UKf+2iNh7TAKu2RJ0LoAbV0OvBQVdrXF6aXZSfwr+2idjkaxT
	 wi8PrtPzXkij8leXw7krUKymIjf2FYfqFEF4BxTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCPSiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:37:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03358218A1;
        Sat, 16 Mar 2019 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552761478;
        bh=EjHprr2erqog/YU+osYmPQNuD/b9AKLLKl2Mm72mso8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BuSuKQlHV1oXIo9OQ3ECbl5asoKhtrLXJ6KYHYMAjrV6a72XILgNy/tLXQWzZGMn/
         239NED1YKlb/97M4Am/O4iSe3DS39MH24TJ6RZeWEmXwj+G/9wED8cfYlMsvzkCKiW
         FiPE2nac7FJ8iQSIK1nXsv2pGv4i/68kTjYQyJIU=
Date:   Sat, 16 Mar 2019 18:37:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 3/7] staging: iio: ad5933: add SPDX identifier
Message-ID: <20190316183753.5546a6b7@archlinux>
In-Reply-To: <20190316150703.n3nlcjl4a32fakb6@smtp.gmail.com>
References: <20190316150703.n3nlcjl4a32fakb6@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 12:07:03 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add SPDX identifier of GPL-2.0 for the ad5933 driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index c2a7a59e469c..d75bdfbf93de 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5933 AD5934 Impedance Converter, Network Analyzer
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/clk.h>

