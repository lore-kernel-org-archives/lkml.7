Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D6DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5322075E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553968573;
	bh=4yr/hBFGcmKSZ0eYDV1mQjICKnix+bkiI+rTtu9Pxi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=01uVq11/MJt3fV+5mNEqMNrSK1f53vorLXxST4fjS0qTYybFf265NL5HiuwFoXvrO
	 sTrK2uvLWytg+Y2FvMyDxjiCpcsB29AyUD68So/AlzEev/dCHraRSwy5ZwkrAVQwS2
	 wOiCDu9dSDAHnJvfSv1cdpRbindyNoTOKjFKcEc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfC3R4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfC3R4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:56:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CBA2075E;
        Sat, 30 Mar 2019 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553968571;
        bh=4yr/hBFGcmKSZ0eYDV1mQjICKnix+bkiI+rTtu9Pxi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=krprgiSkuDCNiF84K93QkMAMLnXiW7BoVY7o2thQryqWZq5+atSP/DI7GEwMgV84J
         4x6rtN4pOk9gRQXb9P0vhkNo9WfVn6UjX9TlFu/cF2Ek2+zqJmEC1le8v8TppIICF1
         SQ1m7XE/sN6zd2xBelQrvOHGgFbr7sA2Mt9sLKAU=
Date:   Sat, 30 Mar 2019 17:56:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh@kernel.org>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: Fix the link to ad7606 dt-bindings
Message-ID: <20190330175605.328742d9@archlinux>
In-Reply-To: <1553597992-31693-1-git-send-email-stefan.popa@analog.com>
References: <1553597992-31693-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:59:52 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The devicetree bindings documentation for ad7606 should also include
> the vendor prefix: ad7606.txt -> adi,ad7606.txt
> 
> Fixes: 6e33a125df66 ("dt-bindings: iio: adc: Add docs for AD7606 ADC")
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Added Fixes tag
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff2c2f2..4f81cdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -860,7 +860,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> -F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
>  
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>

