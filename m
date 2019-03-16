Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F4C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F655218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552754368;
	bh=isAAi0CzxpQ4aHBIOxgXC+hRaMHzGL9zQ3ylpbuMhlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UR5Ewe9XSO2/sXeG+Tnbl+XrhtNWt3SKGq/KXxnJu2tbotDtQNRqzUK/c5qmCAWJj
	 PpvHBzoLr8TDETN+2X8N90c8+bZZoBExfHRUmqM5L+kgEcZSinjmZS/3FyLO0J7ns4
	 ttl38PM+H5iH7AqXXhybnaVHF/LX4K3+6qASWvrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCPQj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:39:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A8D2186A;
        Sat, 16 Mar 2019 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552754366;
        bh=isAAi0CzxpQ4aHBIOxgXC+hRaMHzGL9zQ3ylpbuMhlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xC4X40O9rKTrPYxZVwZK0w907w345BpxXGefUhamTJSicNzz0ivCdj24R7LMNIigp
         bLRRNEtOex257xh/YKxL2FI0YeU0ECGZNGdQ0ntd7LhPZYbrIxFS3wSwlUxXcnZCSF
         qpyz9chxy5L2Bm9AG48kNydM89cCsW61WvN9mkjY=
Date:   Sat, 16 Mar 2019 16:39:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Fix identation
Message-ID: <20190316163921.5f4fb875@archlinux>
In-Reply-To: <20190315111425.14275-1-mircea.caprioru@analog.com>
References: <20190315111425.14275-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 13:14:24 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch fixes the odd indentation inside function ad7192_calibrate_all.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
Thanks.

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..ebab75bdeed7 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -216,8 +216,8 @@ static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
>  
>  static int ad7192_calibrate_all(struct ad7192_state *st)
>  {
> -		return ad_sd_calibrate_all(&st->sd, ad7192_calib_arr,
> -				ARRAY_SIZE(ad7192_calib_arr));
> +	return ad_sd_calibrate_all(&st->sd, ad7192_calib_arr,
> +				   ARRAY_SIZE(ad7192_calib_arr));
>  }
>  
>  static inline bool ad7192_valid_external_frequency(u32 freq)

