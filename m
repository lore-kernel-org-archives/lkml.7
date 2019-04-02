Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726962075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQsqFjGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfDBTwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:52:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33744 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDBTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:52:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so12727674ljc.0;
        Tue, 02 Apr 2019 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pH7CqM4oqzCN5Nfo/q+PTTWA7L0TFPPJXU4HaaJK0hs=;
        b=lQsqFjGt4LPh5AlJSzwIy87yWCeWXluceVJ72r4dlu+boieSfuL8NQa5yVfIQYr2dZ
         2Kol/RJJLGfoxqqxg2HdQKyLF9AhAK+RRw096Q3ibrTlUYB5Cq1OtkV06gmQEIwbbmV0
         vh6J/zU3N+42mdEzuG2iKKiND026Y3sRIQU5hkdliDZDUQ9yW41RqZKyYzIN+rijsDJ2
         rqWAmoSSHlHfrKMXJC0zbNR7gld9hNR6QEV6NoOBnAYPMIol0oShI5yUdbtyFsDIGthG
         h3ikGk4VhybAzsdzYyaUTiVS2d+T6TPai0NAMJF9PlK4jzcdmP+F8fO3wL6aIiydheEi
         kBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pH7CqM4oqzCN5Nfo/q+PTTWA7L0TFPPJXU4HaaJK0hs=;
        b=leb0ZLgAd8nqlJFQNTSuaPXIe+OZFRG5Cto7TVrThMfh3JSCXcXOr8ZvP8OBZu1dgm
         JY3R36SCAXhGeDwD2dYC6EJ1V236EZGppANmPsyuokQ6aTZeDTmnupAPPt/7qeVN7jmW
         Y06d20eoSU6D4NI3XQiflK/qTfx7GkxwlnrKwAREFhB1zAFZO92re1SN1pho0ydxWDod
         RfI3suGVgt6LXCBLKu8pgezhbtkYcGB7AemSZbgsZC+wFx4hIuQ57dSuTPaIMMM3wB/r
         NUFEl6oszUnkLm59KfJTBjBmBxof2v/5ldeQM0nOObDkbNFHtEiTDlHsrwL2aa+tQKiv
         8wrw==
X-Gm-Message-State: APjAAAVhrRltzzzSa1uZRlbjgLNET9aYco5vMtHOMXS5wxX1tUFloAV/
        PEBhpT5gFBClncFcS8+XKR0=
X-Google-Smtp-Source: APXvYqwlywEU0L1GLNxItFEGdjmJcWGIGnviGfLb68Zs8hFZSO6ijTYA3GkZxBsZd7a5vEcusxKIzw==
X-Received: by 2002:a2e:5bcc:: with SMTP id m73mr39469887lje.100.1554234722329;
        Tue, 02 Apr 2019 12:52:02 -0700 (PDT)
Received: from [192.168.1.19] (ckb186.neoplus.adsl.tpnet.pl. [83.31.77.186])
        by smtp.gmail.com with ESMTPSA id c15sm2638302lfi.14.2019.04.02.12.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:52:01 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings
 documention
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, marek.behun@nic.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-3-dmurphy@ti.com> <20190401212921.GB14681@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <75627633-57ed-4bd2-5802-132b39ba0f7d@gmail.com>
Date:   Tue, 2 Apr 2019 21:51:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401212921.GB14681@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:29 PM, Pavel Machek wrote:
> Hi!
> 
> 
>>   .../bindings/leds/leds-class-multicolor.txt   | 140 ++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
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

Pavel, you know very well what is going on here and what is the
background of this design. I suppose you've just entered your trolling
mode - you lately admitted that it sometimes happens :-) [0]

This aims at solving the problem with multi color LED support in
a backward compatible way, which is especially important in relation
to existing triggers.

This is our attempt of addressing that problem in a color space
agnostic way. It was inspired by out-of-tree approach presented
by Vesa few months ago.

[0] https://www.spinics.net/lists/linux-leds/msg11388.html

-- 
Best regards,
Jacek Anaszewski
