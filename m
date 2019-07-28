Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23474C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71432085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564303535;
	bh=/5r3rYZjAroH9klgA3A3a0rKTbHeBYnKF2HDF1+EAzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tnHfi6kO+YWrfSLjoOy9IFk2W6laVO4mxUO5ingLwa0tRQYRQ08+2H36my9DuXPXO
	 hUF5I2DhEKe4BEVGLE9r/PFu59OvGol4VTDHpfvRUHWixCMfP6Z87ckWXNAJxe3/1r
	 6HJryWwFTBc28orwF/vmhLIMRyqbKqS1s/mCsiY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfG1Ipa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 04:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1Ipa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 04:45:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D44A2085A;
        Sun, 28 Jul 2019 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564303529;
        bh=/5r3rYZjAroH9klgA3A3a0rKTbHeBYnKF2HDF1+EAzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=em3yfMQjkjLr7fBs+kgwtzRpXzjQmy4heVAtAqHs4GXaffz3PpYrdderzejYuejwS
         cP4TsQd06lza6cbSqVueJcAT+coNAZRiolIEvYJcIGcccVIi3mrojQ1G60Jr9Y8YwR
         2Hp0vvfRjrJxV1ywuSKxIcNFUXZK1CL6HvgOMYIc=
Date:   Sun, 28 Jul 2019 09:45:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio/adc: Add a compatible string
 for JZ4770 SoC ADC
Message-ID: <20190728094523.2a161231@archlinux>
In-Reply-To: <20190727195940.14010-1-contact@artur-rojek.eu>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 21:59:38 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add a compatible string for the ADC controller present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Artur,

I'll have to hold this series for a few weeks as the fix for the
clock rate divider isn't in my upstream for the togreg branch yet
(as I haven't sent a pull request since the merge window).

Give me a poke if I seem to have forgotten these in a few weeks
time.

Thanks,

Jonathan

> ---
> 
> Changes:
> 
> v2: no change
> 
>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> index f01159f20d87..cd9048cf9dcf 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Should be one of:
>    * ingenic,jz4725b-adc
>    * ingenic,jz4740-adc
> +  * ingenic,jz4770-adc
>  - reg: ADC controller registers location and length.
>  - clocks: phandle to the SoC's ADC clock.
>  - clock-names: Must be set to "adc".

