Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C2C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EB621741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574951667;
	bh=EgeUU4IayHL4JT8g39X4o2o/GERIIpTcGciFtRo83Sc=;
	h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:
	 From;
	b=0ErGLMB+Nv5szL9QvrGWPF8OnMd1xxTem6zVQiDiHFs8FQpTBCR/DZ2EBrKkrz30V
	 xWxHNJ0BDaDEp8EHhb6fa6HmXs8E/vDdULz2Goe+3SnxfSiEpMW0NCY6wc9ml4ATit
	 5TRNabOBGsS90SKbqxDN6o3GYdgJ+LvxeJ/fmz+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1Oe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1Oe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:34:26 -0500
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6622071F;
        Thu, 28 Nov 2019 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574951665;
        bh=EgeUU4IayHL4JT8g39X4o2o/GERIIpTcGciFtRo83Sc=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=r9dFHHn65cpvkSZVaaHOfoxV2SH5GbXnXTrUhkYDonbnMnNUOcJ89z2Gy32Jd2dk1
         mEC5RN3juinlZGDNtStVG2g7t5KdWV9ggOafjhBLcz9zlyzHBAXnYUEK+tOFfZULYZ
         0oYABq6dWnHOAR5ikm4i/kxw1uw6ddoR7OuqPPnc=
Reply-To: kbingham@kernel.org, kbingham@kernel.org
Subject: Re: [PATCH 3/3] drivers: auxdisplay: Add JHD1313 I2C interface driver
From:   Kieran Bingham <kbingham@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Simon Goda <simon.goda@doulos.com>
References: <20191128105508.3916-1-kbingham@kernel.org>
 <20191128105508.3916-4-kbingham@kernel.org>
 <CANiq72mnzeQ2SvKbFx+VMFhQnMYNeGQOXpKXy9Vz7kRZyXVbHg@mail.gmail.com>
 <41212589-163f-63a2-38ab-1a1fb05f4813@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=kbingham@kernel.org; keydata=
 mQINBFYE/WYBEACs1PwjMD9rgCu1hlIiUA1AXR4rv2v+BCLUq//vrX5S5bjzxKAryRf0uHat
 V/zwz6hiDrZuHUACDB7X8OaQcwhLaVlq6byfoBr25+hbZG7G3+5EUl9cQ7dQEdvNj6V6y/SC
 rRanWfelwQThCHckbobWiQJfK9n7rYNcPMq9B8e9F020LFH7Kj6YmO95ewJGgLm+idg1Kb3C
 potzWkXc1xmPzcQ1fvQMOfMwdS+4SNw4rY9f07Xb2K99rjMwZVDgESKIzhsDB5GY465sCsiQ
 cSAZRxqE49RTBq2+EQsbrQpIc8XiffAB8qexh5/QPzCmR4kJgCGeHIXBtgRj+nIkCJPZvZtf
 Kr2EAbc6tgg6DkAEHJb+1okosV09+0+TXywYvtEop/WUOWQ+zo+Y/OBd+8Ptgt1pDRyOBzL8
 RXa8ZqRf0Mwg75D+dKntZeJHzPRJyrlfQokngAAs4PaFt6UfS+ypMAF37T6CeDArQC41V3ko
 lPn1yMsVD0p+6i3DPvA/GPIksDC4owjnzVX9kM8Zc5Cx+XoAN0w5Eqo4t6qEVbuettxx55gq
 8K8FieAjgjMSxngo/HST8TpFeqI5nVeq0/lqtBRQKumuIqDg+Bkr4L1V/PSB6XgQcOdhtd36
 Oe9X9dXB8YSNt7VjOcO7BTmFn/Z8r92mSAfHXpb07YJWJosQOQARAQABtCRLaWVyYW4gQmlu
 Z2hhbSA8a2JpbmdoYW1Aa2VybmVsLm9yZz6JAlQEEwEKAD4CGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQSQLdeYP70o/eNy1HqhHkZyEKRh/QUCXWTt0QUJCyJXZAAKCRChHkZyEKRh
 /QYVD/95rP50k7PUx8ZzRGlWJtw8pGkWzyohQtkSeDhMYhR5Ud6dVVOjJxdAzSxnzeFDHniW
 plJ4z9hpczgnXpb2WNpccup7YzcpadCHG2M1nVZPqY3Szvfi+vjIm3Aa370FJeuhXgU65aBi
 NQv+lJR5R6qdyEkjT4YLSGf35fdoH4bAGHIKHtZH0iRvGcpt9YrygkGpCREnqHvzjXYBzDm6
 /0/2Qcf0aV0fZMeZ/EhkIL/zy452BRavJ6xJKBbGadm/dIEQsEdzfH4nbcfmsBpL4QdBzwon
 WQesFTVBpGpYIuToX5CB6WyXWnqkfUwcd7riEMciWLxqW82nLpfK96V9Blmumlj5RXjzzsN1
 aYMU8lxyeesEMiUmZDLY34DSP9jTcSZFTQkJ+VkXIgCbM8gXY8hEJ4Y5wYTG5XXDOVmXxO/k
 oR+51rx1gCOdo2jCu2gH84gemZv/Y0MPdL+vOph8AiuEZAUxUglSaLwZoX+5y3tRP9Pwp6Il
 DWlEfDW9s9N7x77Z9UbtgoM7K3BzFv/rhG/PXY+WUjjxQHRQN3GOhVXOtdl+ICijXgmBnOCO
 vB3cPxprqTqOX1mMo/FbckKzLuiNnJX2hPRvGcWgwwhzrTPoVS6DockCI5bketVjEAX4kH3+
 g0C4VZF7UOhTfgKjcUz1FQNsep1UsePjQE81yt6zt7kCDQRWBP1mARAAzijkb+Sau4hAncr1
 JjOY+KyFEdUNxRy+hqTJdJfaYihxyaj0Ee0P0zEi35CbE6lgU0Uztih9fiUbSV3wfsWqg1Ut
 3/5rTKu7kLFp15kF7eqvV4uezXRD3Qu4yjv/rMmEJbbD4cTvGCYId6MDC417f7vK3hCbCVIZ
 Sp3GXxyC1LU+UQr3fFcOyCwmP9vDUR9JV0BSqHHxRDdpUXE26Dk6mhf0V1YkspE5St814ETX
 pEus2urZE5yJIUROlWPIL+hm3NEWfAP06vsQUyLvr/GtbOT79vXlEn1aulcYyu20dRRxhkQ6
 iILaURcxIAVJJKPi8dsoMnS8pB0QW12AHWuirPF0g6DiuUfPmrA5PKe56IGlpkjc8cO51lIx
 HkWTpCMWigRdPDexKX+Sb+W9QWK/0JjIc4t3KBaiG8O4yRX8ml2R+rxfAVKM6V769P/hWoRG
 dgUMgYHFpHGSgEt80OKK5HeUPy2cngDUXzwrqiM5Sz6Od0qw5pCkNlXqI0W/who0iSVM+8+R
 myY0OEkxEcci7rRLsGnM15B5PjLJjh1f2ULYkv8s4SnDwMZ/kE04/UqCMK/KnX8pwXEMCjz0
 h6qWNpGwJ0/tYIgQJZh6bqkvBrDogAvuhf60Sogw+mH8b+PBlx1LoeTK396wc+4c3BfiC6pN
 tUS5GpsPMMjYMk7kVvEAEQEAAYkCPAQYAQoAJgIbDBYhBJAt15g/vSj943LUeqEeRnIQpGH9
 BQJdizzIBQkLSKZiAAoJEKEeRnIQpGH9eYgQAJpjaWNgqNOnMTmDMJggbwjIotypzIXfhHNC
 eTkG7+qCDlSaBPclcPGYrTwCt0YWPU2TgGgJrVhYT20ierN8LUvj6qOPTd+Uk7NFzL65qkh8
 0ZKNBFddx1AabQpSVQKbdcLb8OFs85kuSvFdgqZwgxA1vl4TFhNzPZ79NAmXLackAx3sOVFh
 k4WQaKRshCB7cSl+RIng5S/ThOBlwNlcKG7j7W2MC06BlTbdEkUpECzuuRBv8wX4OQl+hbWb
 B/VKIx5HKlLu1eypen/5lNVzSqMMIYkkZcjV2SWQyUGxSwq0O/sxS0A8/atCHUXOboUsn54q
 dxrVDaK+6jIAuo8JiRWctP16KjzUM7MO0/+4zllM8EY57rXrj48jsbEYX0YQnzaj+jO6kJto
 ZsIaYR7rMMq9aUAjyiaEZpmP1qF/2sYenDx0Fg2BSlLvLvXM0vU8pQk3kgDu7kb/7PRYrZvB
 sr21EIQoIjXbZxDz/o7z95frkP71EaICttZ6k9q5oxxA5WC6sTXcMW8zs8avFNuA9VpXt0Yu
 pJd2ijtZy2mpZNG02fFVXhIn4G807G7+9mhuC4XG5rKlBBUXTvPUAfYnB4JBDLmLzBFavQfv
 onSfbitgXwCG3vS+9HEwAjU30Bar1PEOmIbiAoMzuKeRm2LVpmq4WZw01QYHU/GUV/zHJSFk
Message-ID: <22736d5f-b078-eb1f-8ee7-bff2f7774a6f@kernel.org>
Date:   Thu, 28 Nov 2019 14:34:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <41212589-163f-63a2-38ab-1a1fb05f4813@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On 28/11/2019 14:08, Kieran Bingham wrote:
> Hi Miguel,
> 
> On 28/11/2019 13:43, Miguel Ojeda wrote:
>> Hi Kieran,
>>
>> On Thu, Nov 28, 2019 at 11:55 AM <kbingham@kernel.org> wrote:
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8f075b866aaf..640f099ff7fb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8837,6 +8837,10 @@ S:       Maintained
>>>  F:     Documentation/admin-guide/jfs.rst
>>>  F:     fs/jfs/
>>>
>>> +JHD1313 LCD Dispaly driver
>>
>> Typo (and it should be all uppercase; and perhaps "Display" is not
>> needed given LCD is there; but see also comments on the title below).
> 
> Good spot, and good point "Liquid Crystal Display Display" is a bit
> redundant.
> 
>> Also missing the "S:" entry.
> 
> Ah yes, I think we can add the following here:
> 
> S:      Maintained
> 
>>> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
>>> index b8313a04422d..cfc61c1abdee 100644
>>> --- a/drivers/auxdisplay/Kconfig
>>> +++ b/drivers/auxdisplay/Kconfig
>>> @@ -27,6 +27,18 @@ config HD44780
>>>           kernel and started at boot.
>>>           If you don't understand what all this is about, say N.
>>>
>>> +config JHD1313
>>> +       tristate "JHD1313 Character LCD support"
>>> +       depends on I2C
>>> +       select CHARLCD
>>> +       ---help---
>>> +         Enable support for Character LCDs using a JHD1313 controller on I2C.
>>> +         The LCD is accessible through the /dev/lcd char device (10, 156).
>>> +         This code can either be compiled as a module, or linked into the
>>> +         kernel and started at boot.
>>> +         This supports the LCD panel on the Grove 16x2 LCD series.
>>> +         If you don't understand what all this is about, say N.
>>
>> Would it be useful/worth for users to put "Grove series" and/or "I2C"
>> in the tristate title? (i.e. like the help section explains and also
>> like the MODULE_DESCRIPTION says).
> 
> I have struggled with the difference between the definition of this
> driver (which supports a 'JHD1313') vs the 'product' that uses it (the
> Grove display), and I also suspect that as it's just an implementation
> of a more generic part, so I'm also contemplating renaming this. For
> instance, the products at:
> 
> 	http://www.jhdlcd.com.cn/162character.html
> 
> All seem to reference an SPLC780D controller, and have varying
> properties of backlight colour, and text colour.
> 
> Thus I highly suspect that the JHD1313 is just a specific
> variant/implementation of the range which is utilised by the Grove LCD
> board. (which makes jhd1313 a bad name for this driver...)
> 
> Do you have any experience in these various part numbers, to suggest
> perhaps a better naming?
> 
> Or I wonder if anyone has any relevant contacts at either Seeed, or JHD
> or any other related part here...
> 
> Now that I track down the SPLC780D, I see:
> 
> 	https://www.newhavendisplay.com/app_notes/SPLC780D.pdf

Following the rabbit-hole even deeper, I have now discovered that Seed
have now put up a /real/ JHD1313 datasheet:

https://github.com/SeeedDocument/Grove_LCD_RGB_Backlight/blob/master/res/JHD1313%20FP-RGB-1%201.4.pdf

However, that leads down a further path - as it references in the block
diagram on page 12 that the I2C component (which is really what this
driver is about) is an AIP31068L (or equivalence) which handles the
bridging between the I2C interface, and the segment driver.

(And this is yet again, another newhaven-display part)

So that's pushing me towards the idea that this is in fact a
newhaven,aip31068l device driver.

Perhaps we would support compatibles such as "jhd,jhd1313",
"jhd,jhd1214" as convenience aliases though ?


Any thoughts from anyone?


> Which leads to 'yet another vendor', and actually I already see
> newhaven,.* in vendor-prefixes.yaml ... however this looks like it
> relates to just the 'LCD driver', and does not provide the I2C interface
> - so the device is of course more complex than a single part.
> 
> Anyway, certainly adding in I2C would be beneficial though.
> 
> 
>>> diff --git a/drivers/auxdisplay/jhd1313.c b/drivers/auxdisplay/jhd1313.c
>>> new file mode 100644
>>> index 000000000000..abf270e128ac
>>> --- /dev/null
>>> +++ b/drivers/auxdisplay/jhd1313.c
>>> @@ -0,0 +1,111 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +
>>
>> Unconventional (AFAIK) empty line.
> 
> Ooops, I can drop that one :-D
> 
>> Thanks for the driver!
> 
> You're welcome. The charlcd_ framework makes it easy to add an LCD over
> I2C, and I hope this can be useful to others.
> 
>> Cheers,
>> Miguel

--
Kieran
