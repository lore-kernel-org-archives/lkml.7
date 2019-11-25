Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D58C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D9820748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="AP9CdUHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfKYORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:17:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:15530 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfKYORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574691470;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=r/C4z8eqmf4EqK6PYy8WsArzStWXQ+mb5cSxKvoTl4Q=;
        b=AP9CdUHyBSFSe2UT87PwY1eREKGTGKaYgZ+bVxcnXUYGb/y3AVx+JK5CGbNYu1hv7l
        Q4SJ1fqChqo2xzZuWmCDvY8upa+XNb+fSYmcLmt1u5jGHGsNFxwRVqSy+6xd4AtZGKpV
        eyZ1E5fr8Py+pGnnq8LWq8g/h4++RrqjEVJ/9x4STZcU29BowrZBASFtzlIbunHZZMbG
        SDLcFVyLR5O4uSV/SeQXUVRtwl88wOeTW5JFUgKn12AQoWW4pfRO+CWZuR21IKz0sRLy
        wGmyvMBM6z+0ro003JarnwHU6bLjdB8w5argiQJMvB7vSMBP61/a0fL22bJOGro2jt/U
        STQA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266HpF+ORJDYrryYBhveg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPEHn0tU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 15:17:49 +0100 (CET)
Date:   Mon, 25 Nov 2019 15:17:40 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ARM: dts: ux500: Add pin configs for UART1 CTS/RTS
 pins
Message-ID: <20191125141740.GA55734@gerhold.net>
References: <20191125122256.53482-1-stephan@gerhold.net>
 <20191125122256.53482-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125122256.53482-4-stephan@gerhold.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 01:22:55PM +0100, Stephan Gerhold wrote:
> UART1 an be optionally used with additional CTS/RTS pins.

s/an/can, duh.
I will fix this if a v2 is needed for some reason; otherwise,
can you fix this when applying the patch?

Thanks!

> The pinctrl driver has an extra "u1ctsrts_a_1" pin group for them.
> 
> Add a new pin configuration to configure them correctly if needed.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
> index b6d0a60e9aed..e85a08ad2ea7 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
> @@ -65,6 +65,32 @@
>  				ste,config = <&slpm_out_wkup_pdis>;
>  			};
>  		};
> +
> +		u1ctsrts_a_1_default: u1ctsrts_a_1_default {
> +			default_mux {
> +				function = "u1";
> +				groups = "u1ctsrts_a_1";
> +			};
> +			default_cfg1 {
> +				pins = "GPIO6_AF6"; /* CTS */
> +				ste,config = <&in_pu>;
> +			};
> +			default_cfg2 {
> +				pins = "GPIO7_AG5"; /* RTS */
> +				ste,config = <&out_hi>;
> +			};
> +		};
> +
> +		u1ctsrts_a_1_sleep: u1ctsrts_a_1_sleep {
> +			sleep_cfg1 {
> +				pins = "GPIO6_AF6"; /* CTS */
> +				ste,config = <&slpm_in_wkup_pdis>;
> +			};
> +			sleep_cfg2 {
> +				pins = "GPIO7_AG5"; /* RTS */
> +				ste,config = <&slpm_out_hi_wkup_pdis>;
> +			};
> +		};
>  	};
>  
>  	uart2 {
> -- 
> 2.24.0
> 
