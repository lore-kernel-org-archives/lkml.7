Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B3C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CDF2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573924313;
	bh=LN3C1kuC2V3MUsIX/lSbSx0Ac7RRwn+wgAylpuf6cYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EpPSsVDjpKvWKiyXHd2sEb1Q2olWTCho65JkMgh05fPdRKNCwJHBQ+J5IR3ohnmbj
	 Tt0390SnVfxsPvN7rMhkezf82MX7dLmRdLLAbpilklbwpDwnN6wS9o+OUTrpVK8Crh
	 1K7UFYhrKQuI34jz9VWQThqeA6PJP8T5PBcFsszE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfKPRLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 12:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKPRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 12:11:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58860214E0;
        Sat, 16 Nov 2019 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573924311;
        bh=LN3C1kuC2V3MUsIX/lSbSx0Ac7RRwn+wgAylpuf6cYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IlzfehQqgakG3TXV9S0nYj8jLyHRxBU7PuGAFfuO3PCuc6C32vqEFoaFzBXXb3Ogr
         0noU10cZz4v7ue9NIMhBmLvPc2ELxW0W/cdaxMBdWslC2q6G3NdLpmkW4BnBow8HwM
         oUPK0f2wp0zdQlN0rRTM7qW0j73Jt8vQFMAP6s5o=
Date:   Sat, 16 Nov 2019 17:11:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add entry for AD7091R5 driver
Message-ID: <20191116171146.029e2a57@archlinux>
In-Reply-To: <20191115135723.12219-4-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
        <20191115135723.12219-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 15:57:23 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Add Beniamin Bia as a maintainer for AD7091R5 ADC.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied,

Thanks,

Jonathan

> ---
> Changes in v5:
> -nothing changed
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e01d0f0b0e5..7f1e4b88688f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -893,6 +893,14 @@ S:	Supported
>  F:	drivers/iio/dac/ad5758.c
>  F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  
> +ANALOG DEVICES INC AD7091R5 DRIVER
> +M:	Beniamin Bia <beniamin.bia@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/adc/ad7091r5.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> +
>  ANALOG DEVICES INC AD7124 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-iio@vger.kernel.org

