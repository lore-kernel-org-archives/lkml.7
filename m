Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B982C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5807B20882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r2+BCPvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfDBLlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:41:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45606 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDBLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:41:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32BerQw107123;
        Tue, 2 Apr 2019 06:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554205253;
        bh=5rDDSqIIyEedssPF+iW8iPePynpd0xdjdPz41rzPBYs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r2+BCPvm6Au9eM2A0HsiROQNfCXTLdOQ5BTZwwuwNZp0vjTqJApgBZvxUjzgenNne
         742IT4+u+etKg+K8UqWRMraryIyVhMCPMYG+RpUBEJWNTHuv7b2q7plJE6xQj0I4fo
         Ue7yx6nROhPKjQcsaNlIchIe1wF/Xto6kUfWBfG4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32BerOU055313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 06:40:53 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 06:40:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 06:40:53 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32BervQ018126;
        Tue, 2 Apr 2019 06:40:53 -0500
Subject: Re: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings
 documention
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-3-dmurphy@ti.com> <20190401212921.GB14681@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
Date:   Tue, 2 Apr 2019 06:40:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401212921.GB14681@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 4/1/19 4:29 PM, Pavel Machek wrote:
> Hi!
> 
> 
>>  .../bindings/leds/leds-class-multicolor.txt   | 140 ++++++++++++++++++
>>  1 file changed, 140 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>> new file mode 100644
>> index 000000000000..4b1a26104c79
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>> @@ -0,0 +1,140 @@
>> +* Multicolor LED properties
>> +
>> +Multicolor LEDs can consist of a RGB, RGBW or a RGBA LED clusters.  These devices
>> +can be grouped together and also provide a modeling mechanism so that the
>> +cluster LEDs can vary in hue and intensity to produce a wide range of colors.
>> +
>> +The nodes and properties defined in this document are unique to the multicolor 
>> +LED class.  Common LED nodes and properties are inherited from the common.txt
>> +within this documentation directory.
>> +
>> +Required LED Child properties:
>> +	- color : This is the color ID of the LED.  Definitions can be found
>> +		  in include/linux/leds/common.txt
>> +
>> +Optional LED Child properties:
>> +	- available-brightness-models : This is the phandle to the brightness-model
>> +					node(s) that this LED cluster can support.
>> +
>> +Required Brightness model properties
>> +	- led-brightness-model : This flag alerts the device driver and class
>> +				 code that this node is a brightness model node
>> +				 and to process the properties differently.
>> +
>> +Required Brightness model child properties
>> +	- model_name : This is the name of the model presented to the user.  This
>> +		       should be a color that the LED cluster can produce for
>> +		       the device it is attached to.
>> +	- layout : This is the LED layout for the levels.  This layout will
>> +		   determine the color order of the levels.  The layout and
>> +		   level-x properties array should be the same size.
>> +	- level-x : These are the values for the LEDs to produce the color that
>> +		    is defined.  These values are placed in the array according
>> +		    to the layout property.
> 
>> +led-controller@30 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	compatible = "ti,lp5024";
>> +	reg = <0x29>;
>> +
>> +	lp5024_model_yellow: brightness-models {
>> +		led-brightness-model;
>> +		model@0 {
>> +			model_name = "yellow";
>> +			layout = <LED_COLOR_ID_RED
>> +				  LED_COLOR_ID_GREEN
>> +				  LED_COLOR_ID_BLUE>;
>> +			level-1 = <255 227 40>;
>> +			level-2 = <255 240 136>;
>> +			level-3 = <255 247 196>;
>> +		};
>> +	};
> 
> I don't think this works. RGB LED can show millions of colors. Do you
> propose to have millions of entries in dts?
> 									Pavel
> 

I have had off line conversations with Jacek about this brightness model node.

Your concern was actually one of my concerns as well.  Not only millions of entries but also having a huge
DT binary.

We wanted to RFC this to get feedback.  And this is why I have not added any support for this in the framework code.

Dan

-- 
------------------
Dan Murphy
