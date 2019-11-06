Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50483C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0902084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfKFIgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:36:47 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49677 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfKFIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:36:47 -0500
X-Originating-IP: 92.137.17.54
Received: from [192.168.10.51] (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 88F3240011;
        Wed,  6 Nov 2019 08:36:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: Document Kizboxmini boards
 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
 <20191018140304.31547-2-kamel.bouhara@bootlin.com>
 <20191029122935.GA8412@bogus>
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
Message-ID: <4b529b27-ccb1-d58d-fc08-1ce478b33f32@bootlin.com>
Date:   Wed, 6 Nov 2019 09:36:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029122935.GA8412@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2019 13:29, Rob Herring wrote:
> On Fri, Oct 18, 2019 at 04:03:03PM +0200, Kamel Bouhara wrote:
>> Document devicetree's bindings for the SAM9G25 Kizbox Mini boards of
>> Overkiz SAS.
>>
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> ---
>>   .../devicetree/bindings/arm/atmel-at91.yaml        | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> index 1e72e3e6e025..666462988179 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> @@ -35,6 +35,20 @@ properties:
>>                 - atmel,at91sam9x60
>>             - const: atmel,at91sam9
>>   
>> +      - description: Overkiz kizbox Mini Mother Board
>> +        items:
>> +          - const: overkiz,kizboxmini-mb
>> +          - const: atmel,at91sam9g25
>> +          - const: atmel,at91sam9x5
>> +          - const: atmel,at91sam9
>> +
>> +      - description: Overkiz kizbox Mini RailDIN
>> +        items:
>> +          - const: overkiz,kizboxmini-rd
>> +          - const: atmel,at91sam9g25
>> +          - const: atmel,at91sam9x5
>> +          - const: atmel,at91sam9
> 
> These 2 can also be combined into 1 entry.
> 
Ok done in v3.

Thanks.
>> +
>>         - items:
>>             - enum:
>>                 - atmel,at91sam9g15
>> -- 
>> 2.23.0
>>

-- 
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
