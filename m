Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72788C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCF20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jpt4aNby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDHJ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:28:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34546 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:28:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x389SIRu065702;
        Mon, 8 Apr 2019 04:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554715698;
        bh=YH3dP5eb3ogvPYmMUBc7A2YXd7xoIUKXNgqJoyfAkEU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jpt4aNbydmA1UK0ucx1cQOyp9n4IO8SNCXxVQT7Sti8BxxwSoVIWoDr9oI887DUSv
         jriBMOarvU2pZ97ntb+Ei9myx2UxUGysNsN122eOg9gz4SgqMZQ7bC1OwjeXVZqURp
         ygSLCSCZpcuWcwOpk0kVayF044LLawhJFyqdQVAs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x389SImL108262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 04:28:18 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 04:28:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 04:28:16 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x389SEbF084372;
        Mon, 8 Apr 2019 04:28:15 -0500
Subject: Re: [PATCH 2/2] ARM: dts: dra7: Separate AM57 dtsi files
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <s-anna@ti.com>, <nm@ti.com>,
        <lokeshvutla@ti.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190405132806.20772-3-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <bb519926-9d2e-2c04-4fc0-8500a45bac8f@ti.com>
Date:   Mon, 8 Apr 2019 12:28:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405132806.20772-3-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2019 16:28, Roger Quadros wrote:
> AM5 and DRA7 SoC families have different set of modules
> in them so the SoC sepecific dtsi files need to be separated.
> 
> e.g. Some of the major differences between AM576 and DRA76
> 
> 		DRA76x	AM576x
> 
> USB3		x
> USB4		x
> ATL		x
> VCP		x
> MLB		x
> ISS		x
> PRU-ICSS1		x
> PRU-ICSS2		x
> 
> This patch only deals with disabling USB3, USB4 and ATL for
> AM57 variants.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/am5718.dtsi             | 32 ++++++++++++++++++++++
>  arch/arm/boot/dts/am571x-idk.dts          |  2 +-
>  arch/arm/boot/dts/am5728.dtsi             | 33 +++++++++++++++++++++++
>  arch/arm/boot/dts/am572x-idk.dts          |  5 ++--
>  arch/arm/boot/dts/am5748.dtsi             | 33 +++++++++++++++++++++++
>  arch/arm/boot/dts/am574x-idk.dts          |  4 +--
>  arch/arm/boot/dts/am57xx-cl-som-am57x.dts |  2 +-
>  arch/arm/boot/dts/dra7-l4.dtsi            |  6 ++---

I think I need to update am57xx-beagle-x15-common.dtsi to include am5728.
I'll send an updated patch.

cheers,
-roger

>  8 files changed, 107 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am5718.dtsi
>  create mode 100644 arch/arm/boot/dts/am5728.dtsi
>  create mode 100644 arch/arm/boot/dts/am5748.dtsi
> 
> diff --git a/arch/arm/boot/dts/am5718.dtsi b/arch/arm/boot/dts/am5718.dtsi
> new file mode 100644
> index 000000000000..d51007c3e8c4
> --- /dev/null
> +++ b/arch/arm/boot/dts/am5718.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "dra72x.dtsi"
> +
> +/ {
> +	compatible = "ti,am5718", "ti,dra7";
> +};
> +
> +/*
> + * These modules are not present on AM5718
> + *
> + * ATL
> + * VCP1, VCP2
> + * MLB
> + * ISS
> + * USB3, USB4
> + */
> +
> +&usb3_tm {
> +	status = "disabled";
> +};
> +
> +&usb4_tm {
> +	status = "disabled";
> +};
> +
> +&atl_tm {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
> index 6432309b39e3..66116ad3f9f4 100644
> --- a/arch/arm/boot/dts/am571x-idk.dts
> +++ b/arch/arm/boot/dts/am571x-idk.dts
> @@ -7,7 +7,7 @@
>   */
>  /dts-v1/;
>  
> -#include "dra72x.dtsi"
> +#include "am5718.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include "dra7-mmc-iodelay.dtsi"
> diff --git a/arch/arm/boot/dts/am5728.dtsi b/arch/arm/boot/dts/am5728.dtsi
> new file mode 100644
> index 000000000000..82e5427ef6a9
> --- /dev/null
> +++ b/arch/arm/boot/dts/am5728.dtsi
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "dra74x.dtsi"
> +
> +/ {
> +	compatible = "ti,am5728", "ti,dra7";
> +};
> +
> +/*
> + * These modules are not present on AM5728
> + *
> + * EVE1, EVE2
> + * ATL
> + * VCP1, VCP2
> + * MLB
> + * ISS
> + * USB3, USB4
> + */
> +
> +&usb3_tm {
> +	status = "disabled";
> +};
> +
> +&usb4_tm {
> +	status = "disabled";
> +};
> +
> +&atl_tm {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
> index b2fb6e097be7..4f835222c266 100644
> --- a/arch/arm/boot/dts/am572x-idk.dts
> +++ b/arch/arm/boot/dts/am572x-idk.dts
> @@ -8,15 +8,14 @@
>  
>  /dts-v1/;
>  
> -#include "dra74x.dtsi"
> +#include "am5728.dtsi"
>  #include "dra7-mmc-iodelay.dtsi"
>  #include "dra74x-mmc-iodelay.dtsi"
>  #include "am572x-idk-common.dtsi"
>  
>  / {
>  	model = "TI AM5728 IDK";
> -	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
> -		     "ti,dra7";
> +	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra7";
>  };
>  
>  &mmc1 {
> diff --git a/arch/arm/boot/dts/am5748.dtsi b/arch/arm/boot/dts/am5748.dtsi
> new file mode 100644
> index 000000000000..5e129759d04a
> --- /dev/null
> +++ b/arch/arm/boot/dts/am5748.dtsi
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "dra76x.dtsi"
> +
> +/ {
> +	compatible = "ti,am5748", "ti,dra762", "ti,dra7";
> +};
> +
> +/*
> + * These modules are not present on AM5748
> + *
> + * EVE1, EVE2
> + * ATL
> + * VCP1, VCP2
> + * MLB
> + * ISS
> + * USB3, USB4
> + */
> +
> +&usb3_tm {
> +	status = "disabled";
> +};
> +
> +&usb4_tm {
> +	status = "disabled";
> +};
> +
> +&atl_tm {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
> index 378dfa780ac1..dc5141c35610 100644
> --- a/arch/arm/boot/dts/am574x-idk.dts
> +++ b/arch/arm/boot/dts/am574x-idk.dts
> @@ -6,14 +6,14 @@
>  
>  /dts-v1/;
>  
> -#include "dra76x.dtsi"
> +#include "am5748.dtsi"
>  #include "dra7-mmc-iodelay.dtsi"
>  #include "dra76x-mmc-iodelay.dtsi"
>  #include "am572x-idk-common.dtsi"
>  
>  / {
>  	model = "TI AM5748 IDK";
> -	compatible = "ti,am5728-idk", "ti,dra762", "ti,dra7";
> +	compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
>  };
>  
>  &qspi {
> diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> index 4748ce8747ad..0460de0da2bf 100644
> --- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> +++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> @@ -13,7 +13,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> -#include "dra74x.dtsi"
> +#include "am5728.dtsi"
>  
>  / {
>  	model = "CompuLab CL-SOM-AM57x";
> diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
> index 414f1cd68733..fe9f0bc29fec 100644
> --- a/arch/arm/boot/dts/dra7-l4.dtsi
> +++ b/arch/arm/boot/dts/dra7-l4.dtsi
> @@ -2499,7 +2499,7 @@
>  			ranges = <0x0 0x3a000 0x1000>;
>  		};
>  
> -		target-module@3c000 {			/* 0x4843c000, ap 23 08.0 */
> +		atl_tm: target-module@3c000 {		/* 0x4843c000, ap 23 08.0 */
>  			compatible = "ti,sysc-omap4", "ti,sysc";
>  			reg = <0x3c000 0x4>;
>  			reg-names = "rev";
> @@ -4099,7 +4099,7 @@
>  			};
>  		};
>  
> -		target-module@100000 {			/* 0x48900000, ap 85 04.0 */
> +		usb3_tm: target-module@100000 {		/* 0x48900000, ap 85 04.0 */
>  			compatible = "ti,sysc-omap4", "ti,sysc";
>  			ti,hwmods = "usb_otg_ss3";
>  			reg = <0x100000 0x4>,
> @@ -4148,7 +4148,7 @@
>  			};
>  		};
>  
> -		target-module@140000 {			/* 0x48940000, ap 75 3c.0 */
> +		usb4_tm: target-module@140000 {		/* 0x48940000, ap 75 3c.0 */
>  			compatible = "ti,sysc-omap4", "ti,sysc";
>  			ti,hwmods = "usb_otg_ss4";
>  			reg = <0x140000 0x4>,
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
