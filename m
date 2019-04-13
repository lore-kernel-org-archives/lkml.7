Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A926C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BD208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utf0VM/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDMJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:54:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43994 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 05:54:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so10391650wrx.10;
        Sat, 13 Apr 2019 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qq5j+KoMHIcY0bkOY9orpZGUJ+POMeUd6CQHxb141O0=;
        b=Utf0VM/6Djv5r2YcO96EYyvxPgbejlNcXTU0TUsL67VbayK0lU6lcRu46tZ+/O6uVz
         ooaZ0+pONmDNH5Njiqz4ubUhmGik41Sc7Puo+5mwk56xAjwRCPyyr0BWSnpsKOazl+sE
         QgSJKkWj5/m/e1qAPYDgIR7s4k8oFjVoAaWnOM8uiTZ4F9fhZmoo/RPgoSAgOwaVnhXu
         19TtpRyWBqA1E899ZyTnOreDSWlMYD+P89nOkvPAyIxAHK9snPqCsDq4MN5U2Cs/Ifxo
         C7/z3mIWCGmpmHphd/Dq0uTZUpLeGWvGoXL47TfYsjCW6dJb6dEtdhfF8iwzI3gMPl4J
         NoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qq5j+KoMHIcY0bkOY9orpZGUJ+POMeUd6CQHxb141O0=;
        b=Qhf+crIUD849FJPZAlAbT+2L72oAt7F71wxOTn0rKnCgL8N0g/1ePU1DP8+PeYN9C2
         z7Fno0DuoNlRFps0iuZXzkjBDpwnPYjSxox0VByHsBae4Oaqd9lKFOWycpYC7AGRQli5
         VfpFQ3/2zJwnOJRenjfP9DfoSyUlGLkdNmvYSZnbseSob43hxhqaVhaJ/EJcNWx8YZbu
         4aX/025XcXe5FLmT8uzFw97CtQajHEtqJGV3/PLaSrVJNYGjY/c7ZAIJwuYBq97jstrg
         VUIDeEfHs7ZawVJg16hq/kX9ehSI/bu939fJWP3CsIYKByYHfNC3P2pebKTRIKKXiYOZ
         pETw==
X-Gm-Message-State: APjAAAVI1fiJ4vRkurdE7WpuksC/ATqBB65Llreznyk3lXn2N21VpzdI
        rjmC1V4QlRx+XMWZ2FDMxH0=
X-Google-Smtp-Source: APXvYqwLpYChik0udCUqYBZSc7WO2zvciUjAa0MHh164JZhCySvoFD6yZ4B5rcvsPtFMmSxNH/QEBA==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr11393061wrw.71.1555149276431;
        Sat, 13 Apr 2019 02:54:36 -0700 (PDT)
Received: from [192.168.1.19] (chq232.neoplus.adsl.tpnet.pl. [83.31.14.232])
        by smtp.gmail.com with ESMTPSA id p6sm39601870wrt.4.2019.04.13.02.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:54:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Dan Murphy <dmurphy@ti.com>, Marek Behun <marek.behun@nic.cz>
Cc:     robh+dt@kernel.org, pavel@ucw.cz, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
 <5675ac20-6db2-34ea-938a-01f0076b87e7@ti.com>
 <7a987453-0e4d-be27-790e-efa4a0f40b2b@gmail.com>
 <d2768a25-046f-9aff-f0ed-2772f451a829@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8d9f2ab2-62a6-7fc7-074d-9ac73a261c2e@gmail.com>
Date:   Sat, 13 Apr 2019 11:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d2768a25-046f-9aff-f0ed-2772f451a829@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 4/13/19 12:02 AM, Dan Murphy wrote:
> All
> 
> On 4/12/19 2:10 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 4/12/19 1:50 PM, Dan Murphy wrote:
>>> Marek
>>>
>>> On 4/11/19 5:07 PM, Marek Behun wrote:
>>>> Hi Dan,
>>>> this probaly was discussed, but I did not follow brightness model
>>>> discussions:
>>>> what will happen if I set yellow by writing into yellow mode
>>>> brightness, and then orange by writing orange model brightness?
>>>> Will the resulting color be a mix of yellow and orange, or will the
>>>> orange overwrite the yellow setting?
>>>>
>>>
>>> This was not discussed and is a good question.  If you write the yellow mode for a group of
>>> LEDs then yellow would be produced for the brightness requested.
>>>
>>> If orange is then requested then orange should be displayed at the brightness level requested.
>>> So yes the orange will over write the yellow.
>>
>> Yes, and individual color brightness levels should correspond
>> to the color components of the brightness-model level currently set.
>>
>>> The next question is if the absolute colors are written does it produce the same behavior?
>>>
>>> So if you have yellow and write to the red should the red LED brightness be modified or should the
>>> color switch to red?
>>> And if the red LED is on and the blue LED is written should the color switch to blue or should the blue and red LEDs be mixed together?
>>
>> Now, if any of the color brightness files is altered it should update
>> the hardware with this new setting, but brightness-model and main
>> brightness level should not be changed. The thing that is missing in our
>> proposal is lack of the way to check if brightness-model is up to date
>> (i.e. if it reflects what is written to the hardware).
>>
>> How about utilizing the sync file from the new colors directory?
>> It could return 1 on read when brightness levels of all colors
>> match exactly the ones assigned to the brightness model level currently
>> set.
>>
> 
> There maybe a more pragmatic way to set the color brightness as opposed to defining each level. By defining the monochrome LEDs base maximum brightness for the brightness model and calculating a percentage for each LED from max   I shared this with Jacek earlier and he did not go for it but lets see if others agree or disagree.
> 
> With this method we don't have to define a slew of levels. This in theory may work but not sure it will work in practice.
> 
> For instance
> 
> 	lp5024_model_yellow: brightness-models {
> 		led-brightness-model;
> 		model@0 {
> 			model_name = "yellow";
> 			layout = <LED_COLOR_ID_RED
> 				  LED_COLOR_ID_GREEN
> 				  LED_COLOR_ID_BLUE>;
> 			max_level = <255 247 196>;  //max level of the monochrome LEDs to obtain the color model.
> 		};
> 	};
> 
> Assumption made that a linear slope for each color model is expected.
> 
> Then in the code when a new brightness level is requested for the color the brightness of the monochrome LEDs would be based off the percentage from the max_brightness of the max in the max_level array
> 
> The hue is presented as just another color in the colors dir with brightness and max_brightness files.  So it "appears" as a single LED.
> 
> max_brightness = 255 This is the max of the LEDs in the array and this would also be presented to the user in the max_brightness of the hue.
> 
> Red = (255/255)  = 100%
> Green = (247/255) = 97%
> Blue = (196/255) = 77%
> 
> brightness_val 128
> 
> Red = (128 * 100) / 100 = 128
> Green = (128 * 97) / 100 = 124
> Blue = (128 * 77) / 100 = 98
> 
> brightness_val 80
> 
> Red = (80 * 100) / 100 = 80
> Green = (80 * 97) / 100 = 77
> Blue = (80 * 77) / 100 = 61
> 
> brightness_val 10
> 
> Red = (10 * 100) / 100 = 10
> Green = (10 * 97) / 100 = 9
> Blue = (10 * 77) / 100 = 7
> 
> This method maintains a rough percentage delta between the LEDs.  Where in the MAX brightness case (255) blue is 77% dimmer in intensity then Red and with a brightness that is 1/4 max the delta percentage is 75% so the delta is within 5% tolerance.
> 
> This would keep the directory structures clean and the user space would just need to know colors, brightness and max_brightness for each color.
> 
> Also with this simplistic model we can simplify the DT nodes to
> 	lp5024_model_yellow: brightness-models {
> 		led-brightness-model;
> 		model@0 {
> 			model_name = "yellow";
> 			layout = <LED_COLOR_ID_RED
> 				  LED_COLOR_ID_GREEN
> 				  LED_COLOR_ID_BLUE>;
> 			max_level = <255 247 196>;
> 		};
> 	};
> 
> 	lp5024_model_orange: brightness-models {
> 		led-brightness-model;
> 		model@1 {
> 			model_name = "orange";
> 			layout = <LED_COLOR_ID_RED
> 				  LED_COLOR_ID_GREEN
> 				  LED_COLOR_ID_BLUE>;
> 			max_level = <236 140 16>;
> 		};
> 	};
> 
> For orange
> max_brightness = 236 This is the max of the LEDs in the array and this would also be presented to the user in the max_brightness of the hue.
> 
> Red = (236/236)  = 100%
> Green = (140/236) = 59%
> Blue = (16/236) = 6%
> 
> <same math from above involved here>
> 
> After all of this most likely someone will say this will not work.
> Like I indicated it works in principle maybe not in practice but it keeps the user interface simple and keeps the dt small.

Great, we will have simple. not working interface.

If you will prove that it works for the whole range of devices and
LEDs and is able to produce uniform colors then I'm all in.

Especially, I'd expect it will be able to keep the same hue
and increase only lightness as brightness level rises.

> The other alternative is to have the user space define the color models and just expose the monochrome LEDs.

Please propose the whole interface since I don't see how it would work,
and especially how its functionality would differ from the discussed
approach.

Would it allow to support LEDn_BRIGHTNESS of lp50xx devices?

I'm afraid we're making a full circle now.

We've discussed many aspects of the problem throughout last months -
does your design introduce some novelty in regard to what has been
discussed so far?

If not, and if there is no consensus regarding brightness-models, then
let's implement iouts as monochrome LEDs, without the support for
LEDn_BRIGHTNESS.

-- 
Best regards,
Jacek Anaszewski
