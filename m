Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9B2C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DED222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553429312;
	bh=G7XRmkP9f80LDr6t1RtrU8L5F18kE2+P95rtPhVZJz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e3ctNFnRBa9MWn7OaZEjSX0SlOYJncFf7D6sOXXS0bJszNMYTUDMJKmUCofIT2AMM
	 3z1Ci/q+sXWc57gbpPk29szcExq1Mq1mtRag83b1oxBUz9LfF9pqfKs53ggYV+ukqP
	 znvxIYru3hDesE9Am4e9ozPr9gyiN4g1A5BnyFNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfCXMIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:08:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF7D222D1;
        Sun, 24 Mar 2019 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553429310;
        bh=G7XRmkP9f80LDr6t1RtrU8L5F18kE2+P95rtPhVZJz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xLbzKYUmMhkosgQmMe2rFVtwx2se5JBs/sqivR2jPCbBhvckwIh0oEOLrQACwDhTr
         6uVoHEB/9CnRCe9WuhXMSDaexz3b5HSfqPaAQTOyI2qPn/moz9UPqy8vNJJw1nL4xB
         Es4LU4X5++6jZhBf7dlxznaP8q+OsRpyG2voyBoE=
Date:   Sun, 24 Mar 2019 12:08:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add maintainer for maxbotix
 ultrasonic driver
Message-ID: <20190324120822.3afdd2e4@archlinux>
In-Reply-To: <20190317203827.ocgsj24itlqzqjvc@arbad>
References: <20190317203827.ocgsj24itlqzqjvc@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 21:38:29 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> add a maintainer for the newly created ultrasonic driver family of maxbotix
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dce5c099f43c..fa054f8cc7fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9234,6 +9234,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/max9860.txt
>  F:	sound/soc/codecs/max9860.*
>  
> +MAXBOTIX ULTRASONIC RANGER IIO DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> +F:	drivers/iio/proximity/mb1232.c
> +
>  MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
>  M:	Javier Martinez Canillas <javier@dowhile0.org>
>  L:	linux-kernel@vger.kernel.org

