Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951ECA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46E20717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xf+EPQRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfJ1IcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:32:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40890 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJ1IcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:32:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S8WJwE087003;
        Mon, 28 Oct 2019 03:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572251540;
        bh=cb8t7x1Wna5/A3kIdSJHuz07Zq6Z8d9QRprTibbQH/A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xf+EPQRE/Ena49IcnlQZUSJ8d8p/R/q9CCHyoJCQn6Epmjw+ux4wrycN5aTtXHBQX
         1U8WI+NBrxo+aQf9ymhBaTiK/4ShGHAw0Q5kNx9SU5GHvqlyBvn8mX8eV4/lM19rlt
         /WKddutMSXZEovdcsa9DlrohABePQcY8RFls7iI0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9S8WJVw104270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 03:32:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 03:32:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 03:32:19 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S8WHVD088990;
        Mon, 28 Oct 2019 03:32:17 -0500
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir
 GPIO
To:     Rob Herring <robh@kernel.org>
CC:     <kishon@ti.com>, <aniljoy@cadence.com>, <adouglas@cadence.com>,
        <nsekhar@ti.com>, <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191024114042.30237-1-rogerq@ti.com>
 <20191024114042.30237-3-rogerq@ti.com> <20191025200603.GA10839@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <a01a51a5-2249-b26a-1df2-8034f333eb02@ti.com>
Date:   Mon, 28 Oct 2019 10:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025200603.GA10839@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 25/10/2019 23:06, Rob Herring wrote:
> On Thu, Oct 24, 2019 at 02:40:41PM +0300, Roger Quadros wrote:
>> This is an optional GPIO, if specified will be used to
>> swap lane 0 and lane 1 based on GPIO status. This is required
>> to achieve plug flip support for USB Type-C.
>>
>> Type-C companions typically need some time after the cable is
>> plugged before and before they reflect the correct status of
>> Type-C plug orientation on the DIR line.
>>
>> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
>> of 100 ms (min) to 200 ms (max).
>>
>> Allow the DT node to specify the time (in ms) that we need
>> to wait before sampling the DIR line.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Cc: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> index 8a1eccee6c1d..5dab0010bcdf 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> @@ -53,6 +53,21 @@ properties:
>>     assigned-clock-parents:
>>       maxItems: 2
>>   
>> +  typec-dir-gpios:
> 
> TI specific or could be generic?

This driver is TI only.

> 
>> +    maxItems: 1
>> +    description:
>> +      GPIO to signal Type-C cable orientation for lane swap.
>> +      If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
>> +      achieve the funtionality of an exernal type-C plug flip mux.
> 
> s/exernal/external/
> 
>> +
>> +  typec-dir-debounce:
> 
> Needs '-ms' suffix.
> 
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> 
> then you can drop this because standard units have type already.
> 
>> +    description:
>> +      Number of milliseconds to wait before sampling
>> +      typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
>> +      Type-C spec states minimum CC pin debounce of 100 ms and maximum
>> +      of 200 ms.
> 
> Express this as constraints:
> 
> minimum: 100
> maximum: 200
> default: ???
> 
> If the spec minimum is 100ms, then doesn't sampling ASAP violate the
> spec?

Good point. I'll change the default to 100.

Some board solutions seem to take even longer than 200. I can set
1000 ms as maximum.

> 
>> +
>>   patternProperties:
>>     "^pll[0|1]_refclk$":
>>       type: object
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

--
cheers,
-roger
  
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
