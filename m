Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41511CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201B4217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJ3KFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:05:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35775 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:05:40 -0400
X-Originating-IP: 91.217.168.176
Received: from [172.20.50.240] (unknown [91.217.168.176])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3DAAE60004;
        Wed, 30 Oct 2019 10:05:38 +0000 (UTC)
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: Document Kizbox2 boards
 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191017085405.12599-1-kamel.bouhara@bootlin.com>
 <20191017085405.12599-2-kamel.bouhara@bootlin.com>
 <20191029014949.GA22009@bogus>
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
Message-ID: <3c3b1763-5185-34b6-8f68-bbc153eb916f@bootlin.com>
Date:   Wed, 30 Oct 2019 11:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029014949.GA22009@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 02:49, Rob Herring wrote:
> On Thu, Oct 17, 2019 at 10:54:04AM +0200, Kamel Bouhara wrote:
>> Document devicetree's bindings for the SAMA5D31 Kizbox2 boards of
>> Overkiz SAS.
>>
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> ---
>>   .../devicetree/bindings/arm/atmel-at91.yaml   | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> index c0869cb860f3..7636bf7c2382 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> @@ -80,6 +80,41 @@ properties:
>>             - const: atmel,sama5d3
>>             - const: atmel,sama5
>>   
>> +      - description: Overkiz kizbox2 board without antenna
>> +        items:
>> +          - const: overkiz,kizbox2-0
>> +          - const: atmel,sama5d31
>> +          - const: atmel,sama5d3
>> +          - const: atmel,sama5
>> +
>> +      - description: Overkiz kizbox2 board with one head
>> +        items:
>> +          - const: overkiz,kizbox2-1
>> +          - const: atmel,sama5d31
>> +          - const: atmel,sama5d3
>> +          - const: atmel,sama5
>> +
>> +      - description: Overkiz kizbox2 board with two heads
>> +        items:
>> +          - const: overkiz,kizbox2-2
>> +          - const: atmel,sama5d31
>> +          - const: atmel,sama5d3
>> +          - const: atmel,sama5
>> +
>> +      - description: Overkiz kizbox2 board with three heads
>> +        items:
>> +          - const: overkiz,kizbox2-3
>> +          - const: atmel,sama5d31
>> +          - const: atmel,sama5d3
>> +          - const: atmel,sama5
>> +
>> +      - description: Overkiz kizbox2 board Rev2 with two heads
>> +        items:
>> +          - const: overkiz,kizbox2-rev2
>> +          - const: atmel,sama5d31
>> +          - const: atmel,sama5d3
>> +          - const: atmel,sama5
> 
> These can all be made a single items list with the 1st entry being an
> enum of all the boards. The board description can be a comment.
> 
> Rob
> 
Yes agree, actually it's already done in v2, by the way thanks for the 
review.

-- 
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
