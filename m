Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E3D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mF/EVAeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDLWCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:02:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33524 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDLWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 18:02:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CM2LRk124095;
        Fri, 12 Apr 2019 17:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555106541;
        bh=Gr+mPzkDDlEkRvyGJvDmvi5rerSbW14PwLZQcv+QSSg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mF/EVAeI1EEfiCA+XWueMivBTbdrHIDAmJU4KCvqW2+chTDURfewEkMrcsncwu/w9
         YGi9TjmA/xf5uzDz7jOdvL5JZoCUlQgONIPGsWPP/8nZvaudXbrnqwIyLuY0uAL5oB
         l0emEigDNspeggE0Vkk6RNf1QQQYAKNkbRbVCCfg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CM2Luo019597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 17:02:21 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 17:02:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 17:02:21 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CM2KW3021967;
        Fri, 12 Apr 2019 17:02:20 -0500
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Behun <marek.behun@nic.cz>
CC:     <robh+dt@kernel.org>, <pavel@ucw.cz>, <rdunlap@infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
 <5675ac20-6db2-34ea-938a-01f0076b87e7@ti.com>
 <7a987453-0e4d-be27-790e-efa4a0f40b2b@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d2768a25-046f-9aff-f0ed-2772f451a829@ti.com>
Date:   Fri, 12 Apr 2019 17:02:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a987453-0e4d-be27-790e-efa4a0f40b2b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 4/12/19 2:10 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 4/12/19 1:50 PM, Dan Murphy wrote:
>> Marek
>>
>> On 4/11/19 5:07 PM, Marek Behun wrote:
>>> Hi Dan,
>>> this probaly was discussed, but I did not follow brightness model
>>> discussions:
>>> what will happen if I set yellow by writing into yellow mode
>>> brightness, and then orange by writing orange model brightness?
>>> Will the resulting color be a mix of yellow and orange, or will the
>>> orange overwrite the yellow setting?
>>>
>>
>> This was not discussed and is a good question.  If you write the yellow mode for a group of
>> LEDs then yellow would be produced for the brightness requested.
>>
>> If orange is then requested then orange should be displayed at the brightness level requested.
>> So yes the orange will over write the yellow.
> 
> Yes, and individual color brightness levels should correspond
> to the color components of the brightness-model level currently set.
> 
>> The next question is if the absolute colors are written does it produce the same behavior?
>>
>> So if you have yellow and write to the red should the red LED brightness be modified or should the
>> color switch to red?
>> And if the red LED is on and the blue LED is written should the color switch to blue or should the blue and red LEDs be mixed together?
> 
> Now, if any of the color brightness files is altered it should update
> the hardware with this new setting, but brightness-model and main
> brightness level should not be changed. The thing that is missing in our
> proposal is lack of the way to check if brightness-model is up to date
> (i.e. if it reflects what is written to the hardware).
> 
> How about utilizing the sync file from the new colors directory?
> It could return 1 on read when brightness levels of all colors
> match exactly the ones assigned to the brightness model level currently
> set.
> 

There maybe a more pragmatic way to set the color brightness as opposed to defining each level. By defining the monochrome LEDs base maximum brightness for the brightness model and calculating a percentage for each LED from max   I shared this with Jacek earlier and he did not go for it but lets see if others agree or disagree.

With this method we don't have to define a slew of levels. This in theory may work but not sure it will work in practice.

For instance

	lp5024_model_yellow: brightness-models {
		led-brightness-model;
		model@0 {
			model_name = "yellow";
			layout = <LED_COLOR_ID_RED
				  LED_COLOR_ID_GREEN
				  LED_COLOR_ID_BLUE>;
			max_level = <255 247 196>;  //max level of the monochrome LEDs to obtain the color model.
		};
	};

Assumption made that a linear slope for each color model is expected.

Then in the code when a new brightness level is requested for the color the brightness of the monochrome LEDs would be based off the percentage from the max_brightness of the max in the max_level array

The hue is presented as just another color in the colors dir with brightness and max_brightness files.  So it "appears" as a single LED.

max_brightness = 255 This is the max of the LEDs in the array and this would also be presented to the user in the max_brightness of the hue. 

Red = (255/255)  = 100%
Green = (247/255) = 97%
Blue = (196/255) = 77%

brightness_val 128

Red = (128 * 100) / 100 = 128
Green = (128 * 97) / 100 = 124
Blue = (128 * 77) / 100 = 98

brightness_val 80

Red = (80 * 100) / 100 = 80
Green = (80 * 97) / 100 = 77
Blue = (80 * 77) / 100 = 61

brightness_val 10

Red = (10 * 100) / 100 = 10
Green = (10 * 97) / 100 = 9
Blue = (10 * 77) / 100 = 7

This method maintains a rough percentage delta between the LEDs.  Where in the MAX brightness case (255) blue is 77% dimmer in intensity then Red and with a brightness that is 1/4 max the delta percentage is 75% so the delta is within 5% tolerance.

This would keep the directory structures clean and the user space would just need to know colors, brightness and max_brightness for each color.

Also with this simplistic model we can simplify the DT nodes to
	lp5024_model_yellow: brightness-models {
		led-brightness-model;
		model@0 {
			model_name = "yellow";
			layout = <LED_COLOR_ID_RED
				  LED_COLOR_ID_GREEN
				  LED_COLOR_ID_BLUE>;
			max_level = <255 247 196>;
		};
	};

	lp5024_model_orange: brightness-models {
		led-brightness-model;
		model@1 {
			model_name = "orange";
			layout = <LED_COLOR_ID_RED
				  LED_COLOR_ID_GREEN
				  LED_COLOR_ID_BLUE>;
			max_level = <236 140 16>;
		};
	}; 

For orange
max_brightness = 236 This is the max of the LEDs in the array and this would also be presented to the user in the max_brightness of the hue. 

Red = (236/236)  = 100%
Green = (140/236) = 59%
Blue = (16/236) = 6%

<same math from above involved here>

After all of this most likely someone will say this will not work.
Like I indicated it works in principle maybe not in practice but it keeps the user interface simple and keeps the dt small.

The other alternative is to have the user space define the color models and just expose the monochrome LEDs.

Dan

<snip>
