Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F8C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481F2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554024869;
	bh=NQUdGp/T3VGM7e5Zo3SXY8ndPOL4xgKTuoXfmgaRSac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IUboRKW5sraFn1TDerXQO6OnvPntd5kbuvxt21fvcQL6yIbXdSs6f3E6vnpSOmlAi
	 hU1/YyI1zjJXWt+qiLFlW/6yBgt3aaQdnPHqrRMlSyr5sS+D/2N7UQuh63RzZcmdTu
	 Q7pPzW8P9F1CpNQ+yfg+GjKjvb7+fvW9ydPNun6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfCaJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfCaJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:34:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF06206DD;
        Sun, 31 Mar 2019 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554024867;
        bh=NQUdGp/T3VGM7e5Zo3SXY8ndPOL4xgKTuoXfmgaRSac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHwmnKwPbhG41aMV3ubAM4VqCOqK/TXuAWh8GVv8r42fzjllO1cGAhx7nWe4w34hx
         HjXQsavJgxsF8J+QHIUahiym/KWMbKTWRF+0mVeJxn6zHVYlu+yaHVd8p4Nx8RSCcx
         IzmzloL41NhDM6NdCAKDsKqGHzZD9lMmFKdoNm0c=
Date:   Sun, 31 Mar 2019 10:34:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] staging: iio: adc: ad7280a: Avoid precedence
 issues in macro
Message-ID: <20190331103421.7e453618@archlinux>
In-Reply-To: <5e81974355d8de3cdb3c7bc1d4b0cc0fab691872.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
        <cover.1553447138.git.sicilia.cristian@gmail.com>
        <5e81974355d8de3cdb3c7bc1d4b0cc0fab691872.1553447138.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 18:23:12 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Enclosing parameter with parenthesis due to avoid
> possible precedence issue.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
I've already applied this one.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 571535d..c2391f6 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -97,9 +97,10 @@
>  #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
>  					AD7280A_CELL_VOLTAGE_1 + 1)
>  
> -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
> -#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
> -					     c - AD7280A_CELLS_PER_DEV)
> +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c))
> +#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c) - AD7280A_CELLS_PER_DEV)
>  
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F

