Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C5C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCE21707
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="xwkq7pij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfEZXhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 19:37:02 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.218]:42723 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbfEZXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 19:37:02 -0400
X-Greylist: delayed 1404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 19:37:01 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 5813C9D35
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 18:13:36 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V2KehXAjmYTGMV2KehX8ug; Sun, 26 May 2019 18:13:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CxkfiD4KZYM31MyYyEMRm8MEp37SM1b9k7E3WaUhpIk=; b=xwkq7pijV48c7i+TemwbqEMd/0
        qZYoc8x5OHRwXRietoDv7B7CCRb0f1LGrOAB0niRk+xIAQZwq2vybBbmD3GCfaJTGhW7QSktyyHHu
        poe0HtRtJbSuaSMkhwn+uAlMrBDNwPzgA8YUF+lnifmeyBM8X1BX5X3B29I+/1QG1Rmq+dnZHcEa1
        wLxAsJGayBpvYqse8wbLVamsROkFuJidefqlcW+34N0XVLnD/geLZBkzcktw1wFER9sMS3Dsr7ifV
        m7hT9uq5oUhcSDhvv7MbeSd09T6N2Y717xFClQfKdsP/R6WyXCpzW5b1y6HGr55iM3cTVVyn+jHTd
        6RIG0YSQ==;
Received: from [177.34.20.96] (port=44604 helo=[192.168.0.28])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV2Kd-0021VO-LO; Sun, 26 May 2019 20:13:35 -0300
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
To:     Rob Herring <robh@kernel.org>
Cc:     sre@kernel.org, krzk@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
 <20190415012635.6369-3-matheus@castello.eng.br>
 <20190429221353.GA25837@bogus>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <bca953be-8e9e-b20c-abeb-42f3615c7ddb@castello.eng.br>
Date:   Sun, 26 May 2019 20:13:31 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429221353.GA25837@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV2Kd-0021VO-LO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.28]) [177.34.20.96]:44604
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 10
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 7:13 PM, Rob Herring wrote:
> On Sun, Apr 14, 2019 at 10:26:33PM -0300, Matheus Castello wrote:
>> For configure low level state of charge threshold alert signaled from
>> max17040 we add "maxim,alert-soc-level" property.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> new file mode 100644
>> index 000000000000..9b2cc67d556f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> @@ -0,0 +1,24 @@
>> +max17040_battery
>> +~~~~~~~~~~~~~~~~
>> +
>> +Required properties :
>> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> 
> This is really a charger, not a battery.
> 

max17040 is a fuel gauge, max77836 MUIC has it integrated. Because of 
this we use it in the compatible list.

>> +
>> +Optional properties :
>> +- maxim,alert-soc-level :	The alert threshold that sets the state of
>> + 				charge level where an interrupt is generated.
>> +                          	Can be configured from 1 up to 32. If skipped
>> +				the power up default value of 4 will be used.
> 
> Units? This is a low or high alert? Does a common property make sense
> here?
> 

It is a low level alert. I will change the name of the property to 
"maxim,alert-low-soc-level" to make this clear and I will put the 
percent unit in the description.

I do not find any common property that I can use here, if I am wrong let 
me know.

>> +- interrupt-parent : 		The GPIO bank from the interrupt line.
> 
> Drop this. interrupt-parent is implied.

Ok, I will do.

> 
>> +- interrupts : 			Interrupt line see Documentation/devicetree/
>> +				bindings/interrupt-controller/interrupts.txt
>> +
>> +Example:
>> +
>> +	battery-charger@36 {
>> +		compatible = "maxim,max17040";
>> +		reg = <0x36>;
>> +		maxim,alert-soc-level = <10>;
>> +		interrupt-parent = <&gpio7>;
>> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> 
> Usually there are battery properties that need to be described too...
> 

I will fix this for "battery-fuel-gauge@36". I will also add the 
description for wake-source as optional property.

Thanks.

Best Regards,
Matheus Castello

>> +	};
>> -- 
>> 2.17.0
>>
