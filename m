Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE12C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47F2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZiSySr8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCHPpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:45:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46318 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:45:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28FjQPw058955;
        Fri, 8 Mar 2019 09:45:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552059926;
        bh=AXGiandPfOX9MAjnJ0OCtvKw7K2ZfHgj3oUlfjTqnqw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZiSySr8t6sNmTrVK41uopkMrnm2/9DQGI8t7s8w/B0w+i+wYtSdtx1n4hUss3iVnR
         xkxGnAmwwye3OVNT1jCCphIBZXsDt8WCrtEoK1Oknv2tGVvnOf9/Pyvnc4BK6/Xv0E
         xuA2YLaBAcursZzcwfspDMr+SZG2AEUwFk8CVupM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28FjQ08065988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 09:45:26 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 09:45:26 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 09:45:26 -0600
Received: from [172.22.114.154] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28FjPFt006738;
        Fri, 8 Mar 2019 09:45:25 -0600
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <tony@atomide.com>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-2-dmurphy@ti.com> <20190308151422.GA10378@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6d9a5821-a634-8ea2-4fe3-0603af757668@ti.com>
Date:   Fri, 8 Mar 2019 09:45:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190308151422.GA10378@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review.

On 3/8/19 9:14 AM, Pavel Machek wrote:
> Hi!
> 
>> Update the properties for the lm3532 device node for droid4.
>> With this change the backlight LED string and the keypad
>> LED strings will be controlled separately.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 27 +++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
>> index e21ec929f096..94e3d53dbcf3 100644
>> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
>> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
>> @@ -6,6 +6,7 @@
>>  /dts-v1/;
>>  
>>  #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/leds-lm3532.h>
>>  #include "omap443x.dtsi"
>>  #include "motorola-cpcap-mapphone.dtsi"
>>  
>> @@ -383,20 +384,30 @@
>>  };
>>  
>>  &i2c1 {
>> -	lm3532@38 {
>> +	led-controller@38 {
>>  		compatible = "ti,lm3532";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>>  		reg = <0x38>;
>>  
>>  		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
>>  
>> -		lcd_backlight: backlight {
>> -			compatible = "ti,lm3532-backlight";
>> +		ramp-up-ms = <LM3532_RAMP_1024us>;
>> +		ramp-down-ms = <LM3532_RAMP_65536us>;
> 
> I guess dt people will have some comments here. I'd expect
> 
> ramp-up-us = <1024> would be more natural.
> 

Actually ramp-up-us/ramp-down-us is more correct this is an error in this dt definition
and will be fixed in v2


>> +		lcd_backlight: led@0 {
>> +			reg = <0>;
>> +			led-sources = <2>;
>> +			ti,led-mode = <LM3532_BL_MODE_MANUAL>;
>> +			label = "backlight";
> 
> Ok, so we'll have lm3532::backlight. That is not too useful, as it
> does not tell userland what kaclight it is.
> 
> main_display::backlight ?
> 
> OTOH this one is not too important as backlight subsystem should
> handle this.
> 

For Droid4 I am not particular to any specific label.

And if the series in https://lkml.org/lkml/2018/11/7/144
is ever implemented then the label may change as well.

The driver forces the lm3532 string to be part of the label.

This was a discussion a while back with Jacek when I submitted other drivers.

>> +		led@1 {
>> +			reg = <1>;
>> +			led-sources = <1>;
>> +			ti,led-mode = <LM3532_BL_MODE_MANUAL>;
>> +			label = "keypad";
> 
> I guess best variant would be inputX::backlight here, but that might
> be tricky to implement.
> 

Yeah because we don't know what input the keyboard would be on.
Unless there are APIs to retrieve that info.  I have not looked at the input
framework in a while.

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
