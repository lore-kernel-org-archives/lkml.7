Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B71C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C087420818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nw1pg/zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDLInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:43:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34446 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:43:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3C8h0ds009665;
        Fri, 12 Apr 2019 03:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555058580;
        bh=yUUKA0UXKyys+vF96x8txOkwFgRc6vlthQvouVHG5Ew=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nw1pg/zXjcqBYnUNLU5sqr8yNYOSHf3yyh2zwtcUTvesEB5q0sKyz9N89KTsa5cHR
         06r9ddv+P0pCI9QKhqxioCaXBiDbfyIMcdHQqSpQa8tluGM057gWTfFWgkhIvr0gNB
         aEPqDtkJfj4rvWQgFCuNRxUldi8XBTBIOUN9sO4Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3C8h0TX043196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 03:43:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 03:43:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 03:43:00 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3C8gttn095783;
        Fri, 12 Apr 2019 03:42:56 -0500
Subject: Re: [PATCH v6 06/12] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-7-lokeshvutla@ti.com>
 <20190411150023.GQ2839@atomide.com>
 <9cd4b818-905c-08a4-5675-a5ee763cea98@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <7e41405b-74e2-dc53-982a-766dee8a6884@ti.com>
Date:   Fri, 12 Apr 2019 11:42:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9cd4b818-905c-08a4-5675-a5ee763cea98@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 07:24, Lokesh Vutla wrote:
> 
> 
> On 11/04/19 8:30 PM, Tony Lindgren wrote:
>> Hi,
>>
>> * Lokesh Vutla <lokeshvutla@ti.com> [190410 04:15]:
>>> +Example:
>>> +--------
>>> +The following example demonstrates both interrupt router node and the consumer
>>> +node(main gpio) on the AM654 SoC:
>>> +
>>> +main_intr: interrupt-controller0 {
>>> +	compatible = "ti,sci-intr";
>>> +	ti,intr-trigger-type = <1>;
>>> +	interrupt-controller;
>>> +	interrupt-parent = <&gic500>;
>>> +	#interrupt-cells = <3>;
>>> +	ti,sci = <&dmsc>;
>>> +	ti,sci-dst-id = <56>;
>>> +	ti,sci-rm-range-girq = <0x1>;
>>> +};
>>
>> To me it seems there should not be too many of these interrupt
>> controller nodes for each SoC. Maybe you're already planning on
>> doing it, but I suggest that you just add more specific compatibles
>> and then look up the dst-id from a mapping table in the driver
>> similar to what patch 04/12 in this series is already doing.
>>
>> That way you don't need to add custom TI specific (firmware
>> defined) device tree properties listed above ;)
> 

< snip: I think Lokesh had a bad day or something :) >

Anyways, the reason why we want these as custom properties in the DT is 
that there are multiple instances of the routers within one SoC. On 
AM65x we have MAIN NAVSS, MCU NAVSS, GPIOs for both etc., if we add 
driver data for each of these, it easily explodes quite a bit. 
Especially going forward with new SoCs.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
