Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C02CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0767E20828
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="DzI0Q/f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfCUPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:53:50 -0400
Received: from vern.gendns.com ([98.142.107.122]:44596 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUPxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PgWrMWU0RRiBsGu0cX9gUDcVNQcbF1DUiXQ85bYPYC0=; b=DzI0Q/f9PzoKDV7kbNHYadeBbS
        holMHrinyvqtsaPM1mOwqbpoTC5AZawbvZ1JYU+UDH6oCEo0oCwe2Tp1z9ViVG61CtR8F2Hy3idXS
        XE9bjz0E6bBWymJKF7R4IFIZZVwHGwcEfdeseBH/5S9sk6hkWjeXYxPU0Rp8fxZaU104zpkR0Pgb5
        8KRJdvCMljdzOaEFKbDaJbjPWaTnnarr5DT/iPtuuzsWTIak9JPd/3aZg+QVAtqyOe/entXajN9Cv
        Lg5GaMNRjzTASD8E3Cwvtkvp7f/5AOtLY6sEAvaFXT/sMixEPqbcPIN+vZsE82fSZjAn1mmLXYyIj
        /J3nZPCg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33636 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h6zzS-0000lH-UP; Thu, 21 Mar 2019 11:52:23 -0400
Subject: Re: [PATCH 3/4] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <adam.ford@logicpd.com>
References: <20190321141010.19612-1-brgl@bgdev.pl>
 <20190321141010.19612-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <06c6fe16-eb33-960c-909a-635e70c3b976@lechnology.com>
Date:   Thu, 21 Mar 2019 10:53:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321141010.19612-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Enable cpufreq-dt support for da850-evm. The cvdd regulator is fixed
> at 1.2V on this board so disable the lower operating points and enable
> the 375MHz opp.


The board-da850-evm.c file seems to indicate that this regulator is
variable and comes from the tps65070. This regulator seems to be missing
from the device tree though, even though it has device tree bindings.

Cc: Adam Ford


> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/boot/dts/da850-evm.dts | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index f04bc3e15332..f63867692da4 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -151,6 +151,15 @@
>   			system-clock-frequency = <24576000>;
>   		};
>   	};
> +
> +	cvdd: regulator0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cvdd";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &ecap2 {
> @@ -191,6 +200,27 @@
>   	};
>   };
>   
> +&cpu {
> +	cpu-supply = <&cvdd>;
> +};
> +
> +/*
> + * DA850-EVM has a fixed CVDD of 1.2V - we cannot go below 300MHz or
> + * above 375MHz.
> + */
> +
> +&opp_100 {
> +	status = "disabled";
> +};
> +
> +&opp_200 {
> +	status = "disabled";
> +};
> +
> +&opp_375 {
> +	status = "okay";
> +};
> +
>   &sata {
>   	status = "okay";
>   };
> 

