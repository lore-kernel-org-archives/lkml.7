Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C11C04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB64D208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557058334;
	bh=AWraMNufp1TVkWD77c5Ijj2pOjA6QXk6/IDq3mV9NYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yCyZMxy5yyc3fUGPeTCP8pNiSgfL3xq9u/pLPd1PUJR88KHVwFlNNV/tyEp7hnAm4
	 EkBi04Pr1BdOxWRp5K2FGTjq9HLiQMhVQBZKQf5HFk7764uBPDrsq860xtLgsQX5Pc
	 up7LZ0B6DbCh9f70gkQjumiQrT3Ivy2nPinPZRmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfEEMMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfEEMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:12:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1B32082F;
        Sun,  5 May 2019 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557058333;
        bh=AWraMNufp1TVkWD77c5Ijj2pOjA6QXk6/IDq3mV9NYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NzjqJxBHAiog1KzyYKm38TtRUK/KLOYorxga68pdGQps54lSL453+0ubIW9R7HgDI
         OUqpXL3NZAfgZ8OWZJCfkvASdsPBsInVv4RHPbNG1KPG+PyyJtUQyxbI8l8R9dL5DL
         Nt4/I48dhvF14Gf4JVTB20NfwvgHzxi0My5qqhYQ=
Date:   Sun, 5 May 2019 13:12:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vatsala Narang <vatsalanarang@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr
Subject: Re: [PATCH] staging: iio: adc: Add paragraph to describe Kconfig
 symbol
Message-ID: <20190505131207.69fb59ef@archlinux>
In-Reply-To: <20190501071541.4734-1-vatsalanarang@gmail.com>
References: <20190501071541.4734-1-vatsalanarang@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 May 2019 12:45:41 +0530
Vatsala Narang <vatsalanarang@gmail.com> wrote:

> This patch updates Kconfig with paragraph that describe config symbol
> fully.Issue addressed by checkpatch.
> 
> Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
I'm not a great fan of that particular checkpatch warning as sometimes it
leads to silly details being added to things that really can be described
in very little text.

In this particular case the additional element of the module name seems
worth having though so applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 23d9a655a520..31cd9a12f40f 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -12,6 +12,9 @@ config AD7816
>  	  Say yes here to build support for Analog Devices AD7816/7/8
>  	  temperature sensors and ADC.
>  
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7816.
> +
>  config AD7192
>  	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
>  	depends on SPI

