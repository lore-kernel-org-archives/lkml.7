Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA381C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F020866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551623997;
	bh=v7+5k41XIxHF5iA690JssJYk7dh4dUpdONgkAa4vPto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Gi28yQ9/od3NJwGorrpWjKJrOv+lNCYLWQJiP9q4JqCKfswuiaQKpkkk4i8NcOMVd
	 2YsCqUHJR1ofxm27Ej9h6FfvGDE3c3ktxSuvIi4GxplTWnExf5BAbnUz2TqyNdWIoN
	 LPQ32TfCzi8l5yVCPUEn26aG0Ou+q8Mnx6EVg0XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCCOj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCCOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:39:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54ED20836;
        Sun,  3 Mar 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551623995;
        bh=v7+5k41XIxHF5iA690JssJYk7dh4dUpdONgkAa4vPto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ngyVsFk9zFff6jA6zegnCuu7u6YCpXYiubGoTGYSun75PC+AOUZWeiSxn2jVlBTgV
         VbBvysHiZe/bY2dDZ41VEoftNOYBQCYQTkGOYquaeUe4Vt48Hqd7SdufX4/dHrSeQD
         vQwOCwlqGR6QpQYrPt1waurfOQaJs4zHtJVKzVWU=
Date:   Sun, 3 Mar 2019 14:39:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-lptimer-counter: document
 pinctrl sleep state
Message-ID: <20190303143948.2ab9dff3@archlinux>
In-Reply-To: <1551091367-21718-2-git-send-email-fabrice.gasnier@st.com>
References: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
        <1551091367-21718-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 11:42:46 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add documentation for optional pinctrl sleep state that can be used by
> STM32 LPTimer encoder/counter.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note we are too late for the coming merge window so this will be
for the next one now.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt         | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> index a04aa5c..e90bc47 100644
> --- a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> +++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
> @@ -10,8 +10,9 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
>  
>  Required properties:
>  - compatible:		Must be "st,stm32-lptimer-counter".
> -- pinctrl-names: 	Set to "default".
> -- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
> +- pinctrl-names: 	Set to "default". An additional "sleep" state can be
> +			defined to set pins in sleep state.
> +- pinctrl-n: 		List of phandles pointing to pin configuration nodes,
>  			to set IN1/IN2 pins in mode of operation for Low-Power
>  			Timer input on external pin.
>  
> @@ -21,7 +22,8 @@ Example:
>  		...
>  		counter {
>  			compatible = "st,stm32-lptimer-counter";
> -			pinctrl-names = "default";
> +			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&lptim1_in_pins>;
> +			pinctrl-1 = <&lptim1_sleep_in_pins>;
>  		};
>  	};

