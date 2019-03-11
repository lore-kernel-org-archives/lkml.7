Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4476C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A441B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uIoxFGdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCKM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:27:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33926 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:27:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BCR0pu071447;
        Mon, 11 Mar 2019 07:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552307220;
        bh=uKLbxNICkgcGbK3s0JIAQ82jdBRPqSfbCfmQftYkbYc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uIoxFGdUbudMT51Zm7TR0pnecG8kfjCOib5tmpB8J/i1WbFxpAt44UfXnD3ROTx6P
         6dfqP1XYok+1/Sf+ZENRh9PkSIJB7fhLYj1nnkF1+vYvOAnriVCr1x+GuUfCUJ0k3V
         rSw6noOFeCsbrrWXMNIwecvbTRxJTK6y2Ua2QP4w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BCR0Nv033398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 07:27:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 07:26:59 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 07:26:59 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BCQxIQ026017;
        Mon, 11 Mar 2019 07:26:59 -0500
Subject: Re: [PATCH 05/25] dt-bindings: leds: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-6-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <98c1a41e-77bb-5ffd-b5b3-772a28c0f0a6@ti.com>
Date:   Mon, 11 Mar 2019 07:26:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-6-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
> Introduce dedicated properties for conveying information about
> LED function and color. Mark old "label" property as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 55 +++++++++++++++++++----
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa1399814a2a..3402b0e1cec9 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -10,14 +10,23 @@ can influence the way of the LED device initialization, the LED components
>  have to be tightly coupled with the LED device binding. They are represented
>  by child nodes of the parent LED device binding.
>  
> +
>  Optional properties for child nodes:
>  - led-sources : List of device current outputs the LED is connected to. The
>  		outputs are identified by the numbers that must be defined
>  		in the LED device binding documentation.
> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
> +	    from the header include/dt-bindings/leds/common.h.
> +	    If there is no matching LED_FUNCTION available, add a new one.
> +- color : Color of the LED. Use one of the LED_COLOR_NAME_* prefixed definitions
> +	    from the header include/dt-bindings/leds/common.h.
> +	    If there is no matching LED_COLOR_NAME available, add a new one.
> +

I am assuming multi color can re-use this property as well?

>  - label : The label for this LED. If omitted, the label is taken from the node
>  	  name (excluding the unit address). It has to uniquely identify
>  	  a device, i.e. no other LED class device can be assigned the same
> -	  label.
> +	  label. This property is deprecated - use 'function' and 'color'
> +	  properties instead.
>  
>  - default-state : The initial state of the LED. Valid values are "on", "off",
>    and "keep". If the LED is already on or off and the default-state property is
> @@ -87,29 +96,59 @@ Required properties for trigger source:
>  
>  * Examples
>  
> -gpio-leds {
> +#include <dt-bindings/leds/common.h>
> +
> +led-controller@0 {
>  	compatible = "gpio-leds";
>  
> -	system-status {
> -		label = "Status";
> +	led0 {
> +		function = LED_FUNCTION_STATUS;

Missing color for example unless there is a reason to omit it for GPIO LEDs

Also missing reg here

>  		linux,default-trigger = "heartbeat";
>  		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
>  	};
>  
> -	usb {
> +	led1 {
> +		function = LED_FUNCTION_USB;

Same as above
Also missing reg here
>  		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>  		trigger-sources = <&ohci_port1>, <&ehci_port1>;
>  	};
>  };
>  
> -max77693-led {
> +led-controller@0 {
>  	compatible = "maxim,max77693-led";
>  
> -	camera-flash {
> -		label = "Flash";
> +	led {
> +		function = LED_FUNCTION_FLASH;
> +		color = LED_COLOR_NAME_WHITE;
>  		led-sources = <0>, <1>;
>  		led-max-microamp = <50000>;
>  		flash-max-microamp = <320000>;
>  		flash-max-timeout-us = <500000>;
>  	};
>  };
> +
> +led-controller@30 {
> +        compatible = "panasonic,an30259a";
> +        reg = <0x30>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led@1 {
> +                reg = <1>;
> +                linux,default-trigger = "heartbeat";
> +                function = LED_FUNCTION_INDICATOR;
> +                color = LED_COLOR_NAME_RED;
> +        };
> +
> +        led@2 {
> +                reg = <2>;
> +                function = LED_FUNCTION_INDICATOR;
> +                color = LED_COLOR_NAME_GREEN;
> +        };
> +
> +        led@3 {
> +                reg = <3>;
> +                function = LED_FUNCTION_INDICATOR;
> +                color = LED_COLOR_NAME_BLUE;
> +        };
> +};
> 


-- 
------------------
Dan Murphy
