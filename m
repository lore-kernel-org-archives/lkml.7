Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A197C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED45214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rI4YtSlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCLPL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:11:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54122 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:11:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CFBGZa090877;
        Tue, 12 Mar 2019 10:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552403476;
        bh=vSNuCI1O1RvlU0YOEwlFn8Mhfl51QRDZ4yjGj0GCKdk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rI4YtSlpPlnLe1FAZiPIoCdB/MChPfmj0DSkZhbsqdj9kx5DlTk/gYy2CLo+PZZGQ
         LKpks+wf1zByQoKX303cU2uHcFhzPV3ypOzaWp/RXxwHtSzPr6yvSRSiA8t2xOGohE
         rrabNhjxFtA+qXsQvPZ08TXQ6v9nIIYVKzav7axI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CFBGsw091511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 10:11:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 10:11:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 10:11:15 -0500
Received: from [172.22.79.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CFBECU016520;
        Tue, 12 Mar 2019 10:11:14 -0500
Subject: Re: [PATCH v3 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu
 doc
To:     Rob Herring <robh@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <tony@atomide.com>,
        <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190312121822.8315-1-dmurphy@ti.com>
 <20190312145558.GA19538@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2948613f-f615-21f5-169a-9680446e2217@ti.com>
Date:   Tue, 12 Mar 2019 10:10:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312145558.GA19538@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 3/12/19 9:55 AM, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 07:18:19AM -0500, Dan Murphy wrote:
>> Add the lm3532 device tree documentation.
>> Remove lm3532 device tree reference from the ti_lmu devicetree
>> documentation.
>>
>> With the addition of the dedicated lm3532 documentation the device
>> can be removed from the ti_lmu.txt.
>>
>> The reason for this is that the lm3532 dt documentation now defines
>> the ability to control LED output strings against different control
>> banks or groups multiple strings to be controlled by a single control
>> bank.
>>
>> Another addition was for ALS lighting control and configuration.  The
>> LM3532 has a feature that can take in the ALS reading from 2 separate
>> ALS devices and adjust the brightness on the strings that are configured
>> to support this feature.
>>
>> Finally the device specific properties were moved to the parent node as these
>> properties are not control bank configurable.  These include the runtime ramp
>> and the ALS configuration.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v3 - No changes - https://lore.kernel.org/patchwork/patch/1049026/
>>
>> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
>> added ranges for variable properties, I did not change the label - https://lore.kernel.org/patchwork/patch/1048805/
>>
>>  .../devicetree/bindings/leds/leds-lm3532.txt  | 127 ++++++++++++++++++
>>  .../devicetree/bindings/mfd/ti-lmu.txt        |  20 ---
>>  2 files changed, 127 insertions(+), 20 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3532.txt b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
>> new file mode 100644
>> index 000000000000..b267d696b511
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
>> @@ -0,0 +1,127 @@
>> +* Texas Instruments - lm3532 White LED driver with ambient light sensing
>> +capability.
>> +
>> +The LM3532 provides the 3 high-voltage, low-side current sinks. The device is
>> +programmable over an I2C-compatible interface and has independent
>> +current control for all three channels. The adaptive current regulation
>> +method allows for different LED currents in each current sink thus allowing
>> +for a wide variety of backlight and keypad applications.
>> +
>> +The main features of the LM3532 include dual ambient light sensor inputs
>> +each with 32 internal voltage setting resistors, 8-bit logarithmic and linear
>> +brightness control, dual external PWM brightness control inputs, and up to
>> +1000:1 dimming ratio with programmable fade in and fade out settings.
>> +
>> +Required properties:
>> +	- compatible : "ti,lm3532"
>> +	- reg : I2C slave address
>> +	- #address-cells : 1
>> +	- #size-cells : 0
>> +
>> +Required child properties:
>> +	- reg : Indicates control bank the LED string is controlled by
>> +	- led-sources : see Documentation/devicetree/bindings/leds/common.txt
>> +	- ti,led-mode : Defines if the LED strings are manually controlled or
>> +			if the LED strings are controlled by the ALS.
>> +			0x00 - LED strings are I2C controlled via full scale
>> +			       brightness control register
>> +			0x01 - LED strings are ALS controlled
>> +
>> +Optional child properties:
>> +	Range for ramp settings: 8us - 65536us
>> +	- ramp-up-us - The Run time ramp rates/step are from one current
>> +		       set-point to another after the device has reached its
>> +		       initial target set point from turn-on
>> +	- ramp-down-us - The Run time ramp rates/step are from one current
>> +			 set-point to another after the device has reached its
>> +			 initial target set point from turn-on
>> +
>> +Optional child properties if ALS mode is used:
> 
> I think you want to remove 'child' here.
> 

Yes they need to be in the parent since they are device and not string specific configurations.

> Is this all als properties or none or any combination are valid? 
> 

They are all optional in combination.  If the value is not set then the default is taken

>> +	- als-vmin - Minimum ALS voltage defined in Volts
>> +	- als-vmax - Maximum ALS voltage defined in Volts
>> +	Per the data sheet the max ALS voltage is 2V and the min is 0V
>> +
>> +	- als1-imp-sel - ALS1 impedance resistor selection in Ohms
>> +	- als2-imp-sel - ALS2 impedance resistor selection in Ohms
>> +	Range for impedance select: 37000 Ohms - 1190 Ohms
>> +	Values above 37kohms will be set to the "High Impedance" setting
>> +
>> +	- als-avrg-time-us - Determines the length of time the device needs to
>> +			  average the two ALS inputs.  This is only used if
>> +			  the input mode is LM3532_ALS_INPUT_AVRG.
>> +			     Range: 17920us - 2293760us
>> +	- als-input-mode - Determines how the device uses the attached ALS
>> +			   devices.
>> +			   0x00 - ALS1 and ALS2 input average
>> +			   0x01 - ALS1 Input
>> +			   0x02 - ALS2 Input
>> +			   0x03 - Max of ALS1 and ALS2
> 
> These all need a 'ti' prefix or determination of whether they should be 
> common properties.
> 

Ack

>> +
>> +Optional LED child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Example:
>> +led-controller@38 {
>> +	compatible = "ti,lm3532";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	reg = <0x38>;
>> +
>> +	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
> 
> Not documented.
> 

Ack

>> +	ramp-up-ms = <1024>;
>> +	ramp-down-ms = <65536>;
> 
> Says above these go in the child nodes.
> 

They are device configuration not LED string specific.  I will move them to the parent.

>> +
>> +	lcd_backlight: led@0 {
>> +		reg = <0>;
>> +		led-sources = <2>;
>> +		ti,led-mode = <0>;
>> +		label = "backlight";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <1>;
>> +		ti,led-mode = <0>;
>> +		label = "keypad";
>> +	};
>> +};
>> +
>> +Example with ALS:
> 
> Do we really need 2 examples? Seems like this one would be enough.
> 

I can remove the non-ALS example


Dan

>> +led-controller@38 {
>> +	compatible = "ti,lm3532";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	reg = <0x38>;
>> +
>> +	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
>> +	ramp-up-ms = <1024>;
>> +	ramp-down-ms = <65536>;
>> +
>> +	als-vmin = <0>;
>> +	als-vmax = <2000>;
>> +	als1-imp-sel = <4110>;
>> +	als2-imp-sel = <2180>;
>> +	als-avrg-time-us = <17920>;
>> +	als-input-mode = <0x00>;
>> +
>> +	lcd_backlight: led@0 {
>> +		reg = <0>;
>> +		led-sources = <2>;
>> +		ti,led-mode = <1>;
>> +		label = "backlight";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <1>;
>> +		ti,led-mode = <0>;
>> +		label = "keypad";
>> +	};
>> +};
>> +
>> +For more product information please see the links below:
>> +http://www.ti.com/product/LM3532
>> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> index c885cf89b8ce..980394d701a7 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> @@ -4,7 +4,6 @@ TI LMU driver supports lighting devices below.
>>  
>>     Name                  Child nodes
>>    ------      ---------------------------------
>> -  LM3532       Backlight
>>    LM3631       Backlight and regulator
>>    LM3632       Backlight and regulator
>>    LM3633       Backlight, LED and fault monitor
>> @@ -13,7 +12,6 @@ TI LMU driver supports lighting devices below.
>>  
>>  Required properties:
>>    - compatible: Should be one of:
>> -                "ti,lm3532"
>>                  "ti,lm3631"
>>                  "ti,lm3632"
>>                  "ti,lm3633"
>> @@ -23,7 +21,6 @@ Required properties:
>>           0x11 for LM3632
>>           0x29 for LM3631
>>           0x36 for LM3633, LM3697
>> -         0x38 for LM3532
>>           0x63 for LM3695
>>  
>>  Optional property:
>> @@ -47,23 +44,6 @@ Optional nodes:
>>  [2] ../leds/leds-lm3633.txt
>>  [3] ../regulator/lm363x-regulator.txt
>>  
>> -lm3532@38 {
>> -	compatible = "ti,lm3532";
>> -	reg = <0x38>;
>> -
>> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>> -
>> -	backlight {
>> -		compatible = "ti,lm3532-backlight";
>> -
>> -		lcd {
>> -			led-sources = <0 1 2>;
>> -			ramp-up-msec = <30>;
>> -			ramp-down-msec = <0>;
>> -		};
>> -	};
>> -};
>> -
>>  lm3631@29 {
>>  	compatible = "ti,lm3631";
>>  	reg = <0x29>;
>> -- 
>> 2.20.1.390.gb5101f9297
>>


-- 
------------------
Dan Murphy
