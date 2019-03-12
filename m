Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996C22087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552402565;
	bh=Y5K5UL14+vq2s9ehW6+IgFZ4eBpQBU322GQuDlfWZ0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vWRcXUce9L0d7b158RHZuwoOxIdjRGd4izi4bP71r90cioMGXyoTdYULh/V5j+UrL
	 Kjbgq8J1b8ksmuP6ieaOA4KwS7GQUcct6Hv8pgRE9bIWN+T4Yt/FpOVWXVvCjzAMpX
	 vMNm+8jqf2NFh0dtBqmh0cwB91xjIkQqPzNTCK20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:56:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35445 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:56:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id u128so2323653oie.2;
        Tue, 12 Mar 2019 07:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lR0sXiQJWnLNgFhMN4aez91YAyVM1fFbJUvMIo0yKR4=;
        b=iBOC7sPq6zMK7wejzjDqDDHwawl7e42UJzg88GHhucazQ5nn/cPRy3JV84k7BFBhmg
         mtC/L7ZRucZ6LA1+277SSnmxqRmrhKTK3M+GSTp1Es7V9dlEksdxA4TKWDiopqmvxSUA
         08Ra0fSw2mhMAMp7WBLlgEuVUvOTIBX+NcyzAGyFTEnPPEKPvp11xCOMobwOrwDVwsV2
         eacDTO34CA1EgAMdaMJKBp62vCw80OgA/jW0qxAKN/DPe6faajbDiNNDqGhIpOPEYfLR
         xAnfullWhJZAamp/7DJxhmBNYSweNe1/KLqOkZJhQTETUBnCI/6wufq3LhkBTi3ubMk3
         Hpuw==
X-Gm-Message-State: APjAAAUzfUTekbetAwysx9EQR7yrgTn+p+BGq1w/pNX99U60vm/08hAf
        VuD5NePh68kLYIkVeqLY0A==
X-Google-Smtp-Source: APXvYqwGtTgaitTHLSqMBANzSNV+keCquz2arSXLPYxWanCUq8cO0cJDq6/1hLXGJIcbJ1fSM8NpJQ==
X-Received: by 2002:aca:fd91:: with SMTP id b139mr1992912oii.170.1552402560040;
        Tue, 12 Mar 2019 07:56:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o124sm3564284oif.14.2019.03.12.07.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 07:55:59 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:55:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, tony@atomide.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu
 doc
Message-ID: <20190312145558.GA19538@bogus>
References: <20190312121822.8315-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312121822.8315-1-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 07:18:19AM -0500, Dan Murphy wrote:
> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - No changes - https://lore.kernel.org/patchwork/patch/1049026/
> 
> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
> added ranges for variable properties, I did not change the label - https://lore.kernel.org/patchwork/patch/1048805/
> 
>  .../devicetree/bindings/leds/leds-lm3532.txt  | 127 ++++++++++++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  20 ---
>  2 files changed, 127 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3532.txt b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
> new file mode 100644
> index 000000000000..b267d696b511
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
> @@ -0,0 +1,127 @@
> +* Texas Instruments - lm3532 White LED driver with ambient light sensing
> +capability.
> +
> +The LM3532 provides the 3 high-voltage, low-side current sinks. The device is
> +programmable over an I2C-compatible interface and has independent
> +current control for all three channels. The adaptive current regulation
> +method allows for different LED currents in each current sink thus allowing
> +for a wide variety of backlight and keypad applications.
> +
> +The main features of the LM3532 include dual ambient light sensor inputs
> +each with 32 internal voltage setting resistors, 8-bit logarithmic and linear
> +brightness control, dual external PWM brightness control inputs, and up to
> +1000:1 dimming ratio with programmable fade in and fade out settings.
> +
> +Required properties:
> +	- compatible : "ti,lm3532"
> +	- reg : I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Required child properties:
> +	- reg : Indicates control bank the LED string is controlled by
> +	- led-sources : see Documentation/devicetree/bindings/leds/common.txt
> +	- ti,led-mode : Defines if the LED strings are manually controlled or
> +			if the LED strings are controlled by the ALS.
> +			0x00 - LED strings are I2C controlled via full scale
> +			       brightness control register
> +			0x01 - LED strings are ALS controlled
> +
> +Optional child properties:
> +	Range for ramp settings: 8us - 65536us
> +	- ramp-up-us - The Run time ramp rates/step are from one current
> +		       set-point to another after the device has reached its
> +		       initial target set point from turn-on
> +	- ramp-down-us - The Run time ramp rates/step are from one current
> +			 set-point to another after the device has reached its
> +			 initial target set point from turn-on
> +
> +Optional child properties if ALS mode is used:

I think you want to remove 'child' here.

Is this all als properties or none or any combination are valid? 

> +	- als-vmin - Minimum ALS voltage defined in Volts
> +	- als-vmax - Maximum ALS voltage defined in Volts
> +	Per the data sheet the max ALS voltage is 2V and the min is 0V
> +
> +	- als1-imp-sel - ALS1 impedance resistor selection in Ohms
> +	- als2-imp-sel - ALS2 impedance resistor selection in Ohms
> +	Range for impedance select: 37000 Ohms - 1190 Ohms
> +	Values above 37kohms will be set to the "High Impedance" setting
> +
> +	- als-avrg-time-us - Determines the length of time the device needs to
> +			  average the two ALS inputs.  This is only used if
> +			  the input mode is LM3532_ALS_INPUT_AVRG.
> +			     Range: 17920us - 2293760us
> +	- als-input-mode - Determines how the device uses the attached ALS
> +			   devices.
> +			   0x00 - ALS1 and ALS2 input average
> +			   0x01 - ALS1 Input
> +			   0x02 - ALS2 Input
> +			   0x03 - Max of ALS1 and ALS2

These all need a 'ti' prefix or determination of whether they should be 
common properties.

> +
> +Optional LED child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +led-controller@38 {
> +	compatible = "ti,lm3532";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x38>;
> +
> +	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;

Not documented.

> +	ramp-up-ms = <1024>;
> +	ramp-down-ms = <65536>;

Says above these go in the child nodes.

> +
> +	lcd_backlight: led@0 {
> +		reg = <0>;
> +		led-sources = <2>;
> +		ti,led-mode = <0>;
> +		label = "backlight";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <1>;
> +		ti,led-mode = <0>;
> +		label = "keypad";
> +	};
> +};
> +
> +Example with ALS:

Do we really need 2 examples? Seems like this one would be enough.

> +led-controller@38 {
> +	compatible = "ti,lm3532";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x38>;
> +
> +	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
> +	ramp-up-ms = <1024>;
> +	ramp-down-ms = <65536>;
> +
> +	als-vmin = <0>;
> +	als-vmax = <2000>;
> +	als1-imp-sel = <4110>;
> +	als2-imp-sel = <2180>;
> +	als-avrg-time-us = <17920>;
> +	als-input-mode = <0x00>;
> +
> +	lcd_backlight: led@0 {
> +		reg = <0>;
> +		led-sources = <2>;
> +		ti,led-mode = <1>;
> +		label = "backlight";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <1>;
> +		ti,led-mode = <0>;
> +		label = "keypad";
> +	};
> +};
> +
> +For more product information please see the links below:
> +http://www.ti.com/product/LM3532
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> index c885cf89b8ce..980394d701a7 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -4,7 +4,6 @@ TI LMU driver supports lighting devices below.
>  
>     Name                  Child nodes
>    ------      ---------------------------------
> -  LM3532       Backlight
>    LM3631       Backlight and regulator
>    LM3632       Backlight and regulator
>    LM3633       Backlight, LED and fault monitor
> @@ -13,7 +12,6 @@ TI LMU driver supports lighting devices below.
>  
>  Required properties:
>    - compatible: Should be one of:
> -                "ti,lm3532"
>                  "ti,lm3631"
>                  "ti,lm3632"
>                  "ti,lm3633"
> @@ -23,7 +21,6 @@ Required properties:
>           0x11 for LM3632
>           0x29 for LM3631
>           0x36 for LM3633, LM3697
> -         0x38 for LM3532
>           0x63 for LM3695
>  
>  Optional property:
> @@ -47,23 +44,6 @@ Optional nodes:
>  [2] ../leds/leds-lm3633.txt
>  [3] ../regulator/lm363x-regulator.txt
>  
> -lm3532@38 {
> -	compatible = "ti,lm3532";
> -	reg = <0x38>;
> -
> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
> -
> -	backlight {
> -		compatible = "ti,lm3532-backlight";
> -
> -		lcd {
> -			led-sources = <0 1 2>;
> -			ramp-up-msec = <30>;
> -			ramp-down-msec = <0>;
> -		};
> -	};
> -};
> -
>  lm3631@29 {
>  	compatible = "ti,lm3631";
>  	reg = <0x29>;
> -- 
> 2.20.1.390.gb5101f9297
> 
