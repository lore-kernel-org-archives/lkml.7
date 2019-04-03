Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF806C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956220882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hr4jqT78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCUYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:24:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58606 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:24:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33KNtoA009295;
        Wed, 3 Apr 2019 15:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554323035;
        bh=hxi5ejUJqgjBABTIo7IBmdOs/K+9zh2/tY63FdqdisI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hr4jqT78HppS6J/GIwzefZWCih4OjPelImRqX3Gu1eY7XtEoXrSYam42xYbaevBxt
         gvpvfQJhDUaLusxjMpJObSqF5wmfNIFjoXrNZXj0LLEtclbul+G8nhWCec8t+XWjfG
         6/OS+UqzsP/+MPTt8y86Uc9pcF6I07nQJzWElVZM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33KNt55022611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 15:23:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 15:23:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 15:23:55 -0500
Received: from [172.22.125.25] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33KNs09064052;
        Wed, 3 Apr 2019 15:23:55 -0500
Subject: Re: [PATCH 3/5] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-4-dmurphy@ti.com>
 <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <83e31761-714d-db83-8c35-cf45243cb50b@ti.com>
Date:   Wed, 3 Apr 2019 15:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 4/3/19 3:10 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> Thank you for the patch.
> 
> You need Lee Jones on CC for this series.
> 

Yes I saw I missed Lee.

> One more comment below.
> 
> On 3/25/19 3:24 PM, Dan Murphy wrote:
>> The LM3697 is a single function LED driver. The single function LED
>> driver needs to reside in the LED directory as a dedicated LED driver
>> and not as a MFD device.  The device does have common brightness and ramp
>> features and those can be accomodated by a TI LMU framework.
>>
>> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
>> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>> current LED and general bindings guidelines.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../devicetree/bindings/leds/leds-lm3697.txt  | 77 +++++++++++++++++++
>>   .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------
>>   2 files changed, 78 insertions(+), 25 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> new file mode 100644
>> index 000000000000..a780f11acd38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> @@ -0,0 +1,77 @@
>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>> +
>> +The LM3697 11-bit LED driver provides high-
>> +performance backlight dimming for 1, 2, or 3 series
>> +LED strings while delivering up to 90% efficiency.
>> +
>> +This device is suitable for display and keypad Lighting
>> +
>> +Required properties:
>> +    - compatible:
>> +        "ti,lm3697"
>> +    - reg :  I2C slave address
>> +    - #address-cells : 1
>> +    - #size-cells : 0
>> +
>> +Optional properties:
>> +    - enable-gpios : GPIO pin to enable/disable the device
>> +    - vled-supply : LED supply
>> +
>> +Required child properties:
>> +    - reg : 0 - LED is Controlled by bank A
>> +        1 - LED is Controlled by bank B
>> +    - led-sources : Indicates which HVLED string is associated to which
>> +            control bank.  This is a zero based property so
>> +            HVLED1 = 0, HVLED2 = 1, HVLED3 = 2.
>> +            Additional information is contained
>> +            in Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Optional child properties:
>> +    - max_brightness - This determines whether to use 8 bit brightness mode
>> +               or 11 bit brightness mode.  If this value is not
>> +               set the device is defaulted to the preferred 8bit
>> +               brightness mode per 7.3.4.1 of the data sheet.
>> +               The values are 255 (8bit) or 2047 (11bit).
> 
> We should use led-max-microamp for that, if possible.
> 

Actually I was thinking this property could move to common.txt
LM3697 would use it and it is also defined in leds-pwm.txt leds-netxbig.txt 

But I could rename it to led-max-microamp and figure out an algo to convert to max brightness

Dan

-- 
------------------
Dan Murphy
