Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211DC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F0A21904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552759251;
	bh=EIRRMJOSKE2TTGtwsZWi5d00hSsrcDSmfBo9LBUbjrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c/NspI1U6qqV9XYCfdbak8ee3c07s2WIa0hc50eQ5lndOTAVLnq3X8OPinEipW+15
	 E2qRt6cOwnQw2kpwNfPmB2EBEYM5SL868402k1cI2I/2q3BlUZfxoCYt17saHft0CE
	 LWm8zRuvzIEQkAluxKY9hQg+hSi7txVLCbfQgJqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCPSAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCPSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:00:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7C4218D0;
        Sat, 16 Mar 2019 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552759249;
        bh=EIRRMJOSKE2TTGtwsZWi5d00hSsrcDSmfBo9LBUbjrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVhc5TxviBhM/XmfDhRR3jhgF+xtHAQQqCT5VvwFzZM+IIDmPYMvpBAXk0HHdHhK2
         0S553AnHjQxeveZcs8B4BeLMAHOdkVSM42Vrm9xKddfPfCv4g1zsKWQoY0/+LGcEU/
         JoSUQwaOueyeY77pW6b3Pns0gHojCwHnQIcNZrB0=
Date:   Sat, 16 Mar 2019 18:00:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 06/11] staging:iio:ad7780: add chip ID values and
 mask
Message-ID: <20190316180042.369d55e6@archlinux>
In-Reply-To: <8154410f6c1b6cdde21cfb781dbc2088f5c91d21.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <8154410f6c1b6cdde21cfb781dbc2088f5c91d21.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:14:27 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> The ad7780 supports both the ad778x and ad717x families. Each chip has
> a corresponding ID. This patch provides a mask for extracting ID values
> from the status bits and also macros for the correct values for the
> ad7170, ad7171, ad7780 and ad7781.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
I'll admit I find it hard to summon an enthusiasm for this patch, but
it does no harm and I don't want to delay the following ones.

Hence applied anyway.

Jonathan

> ---
> Changes in v5:
>  - Put AD7780_ID{0,1} back
> 
>  drivers/staging/iio/adc/ad7780.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 94cb60c327d0..977b381c1260 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -30,6 +30,12 @@
>  #define AD7780_ID0		BIT(3)
>  #define AD7780_GAIN		BIT(2)
>  
> +#define AD7170_ID		0
> +#define AD7171_ID		1
> +#define AD7780_ID		1
> +#define AD7781_ID		0
> +
> +#define AD7780_ID_MASK		(AD7780_ID0 | AD7780_ID1)
>  
>  #define AD7780_PATTERN_GOOD	1
>  #define AD7780_PATTERN_MASK	GENMASK(1, 0)

