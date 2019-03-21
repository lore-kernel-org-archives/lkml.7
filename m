Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C2218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="SexjxEYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfCUP4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:56:31 -0400
Received: from vern.gendns.com ([98.142.107.122]:45270 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EXjGFrZqIbl/ueZ09OAHu8stNQswpltDmvpgiYd8PYU=; b=SexjxEYMwX0LgHB/GdhcYjCdcf
        16fp+NV6azTZiWcI4kBmc4YnDoaaQzrGgfRVKWG7INXLL32YhJ8WFZuFxPTV9+0gRzgptJnjpzdEF
        oJz6O4hERx/kLabFAKxx+GASw1bSl8G62TZUj+ab3jd+lkdN8EFujVyn0LDuJVN41ajfdsfb6NbB9
        BuEaemaH6JVtA3+hxZpTgc1aPS4T7kzqGZbqBJoMDrMSu04ux4egiyF78d0Woi8WUfiTpvLQrMhEv
        Z2i8oOtU+h6eqIT4ltZ/fH/vSrcxVG4PZsgRoLMYqcvb54KKV4oirgzrynB8UTmGzHUD3pa43mSm+
        IZL5hXLA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:38792 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h7023-0001OK-QK; Thu, 21 Mar 2019 11:55:03 -0400
Subject: Re: [PATCH 2/4] ARM: dts: da850: add cpu node and operating points to
 DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190321141010.19612-1-brgl@bgdev.pl>
 <20190321141010.19612-3-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <a5874799-b7a5-e33b-436a-e215c9afd38a@lechnology.com>
Date:   Thu, 21 Mar 2019 10:56:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321141010.19612-3-brgl@bgdev.pl>
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
> From: David Lechner <david@lechnology.com>
> 
> This adds a cpu node and operating points to the common da850.dtsi file.
> 
> Additionally, a regulator is added to the LEGO EV3 board along with
> some board-specific CPU configuration.

Should mention the LCDK board here as well since it is included in this
patch.

> 
> Regulators need to be hooked up on other boards to get them working.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/boot/dts/da850-lcdk.dts     | 31 +++++++++++++++
>   arch/arm/boot/dts/da850-lego-ev3.dts | 30 +++++++++++++++
>   arch/arm/boot/dts/da850.dtsi         | 56 ++++++++++++++++++++++++++++
>   3 files changed, 117 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 26f453dc8370..f29ed9010812 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -155,12 +155,43 @@
>   			};
>   		};
>   	};
> +
> +	cvdd: regulator0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cvdd";
> +		regulator-min-microvolt = <1300000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &ref_clk {
>   	clock-frequency = <24000000>;
>   };
>   
> +&cpu {
> +	cpu-supply = <&cvdd>;
> +};
> +
> +/* LCDK has a fixed CVDD of 1.3V, so only op points >= 300MHz are valid */
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
> +&opp_456 {
> +	status = "okay";
> +};
> +
>   &pmx_core {
>   	status = "okay";
>   
> diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
> index 66fcadf0ba91..553717f84483 100644
> --- a/arch/arm/boot/dts/da850-lego-ev3.dts
> +++ b/arch/arm/boot/dts/da850-lego-ev3.dts
> @@ -125,6 +125,15 @@
>   		amp-supply = <&amp>;
>   	};
>   
> +	cvdd: regulator0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cvdd";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>   	/*
>   	 * This is a 5V current limiting regulator that is shared by USB,
>   	 * the sensor (input) ports, the motor (output) ports and the A/DC.
> @@ -204,6 +213,27 @@
>   	clock-frequency = <24000000>;
>   };
>   
> +&cpu {
> +	cpu-supply = <&cvdd>;
> +};
> +
> +/* since we have a fixed regulator, we can't run at these points */
> +&opp_100 {
> +	status = "disabled";
> +};
> +
> +&opp_200 {
> +	status = "disabled";
> +};
> +
> +/*
> + * The SoC is actually the 456MHz version, but because of the fixed regulator
> + * This is the fastest we can go.
> + */
> +&opp_375 {
> +	status = "okay";
> +};
> +
>   &pmx_core {
>   	status = "okay";
>   
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 559659b399d0..ee61d1253b58 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -20,6 +20,62 @@
>   		reg = <0xc0000000 0x0>;
>   	};
>   
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu: cpu@0 {
> +			compatible = "arm,arm926ej-s";
> +			device_type = "cpu";
> +			reg = <0>;
> +			clocks = <&psc0 14>;
> +			operating-points-v2 = <&opp_table>;
> +		};
> +	};
> +
> +	opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp_100: opp100-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <1000000 950000 1050000>;
> +		};
> +
> +		opp_200: opp110-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1100000 1050000 1160000>;
> +		};
> +
> +		opp_300: opp120-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <1200000 1140000 1320000>;
> +		};
> +
> +		/*
> +		 * Original silicon was 300MHz max, so higher frequencies
> +		 * need to be enabled on a per-board basis if the chip is
> +		 * capable.
> +		 */
> +
> +		opp_375: opp120-375000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <375000000>;
> +			opp-microvolt = <1200000 1140000 1320000>;
> +		};
> +
> +		opp_415: opp130-415000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <415000000>;
> +			opp-microvolt = <1300000 1250000 1350000>;
> +		};

I just made this point (415MHz) up for experimenting with undervolting
before going all the way to 456MHz at 1.2V. I'm not sure if it is
actually useful to anyone else.

> +
> +		opp_456: opp130-456000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <456000000>;
> +			opp-microvolt = <1300000 1250000 1350000>;
> +		};
> +	};
> +
>   	arm {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> 

