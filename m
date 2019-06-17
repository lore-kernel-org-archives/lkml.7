Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF7EC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EB120657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mVWrpD+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfFQNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:45:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48584 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfFQNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:45:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5HDj53A055630;
        Mon, 17 Jun 2019 08:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560779105;
        bh=bmlEosqIheue8sh7rxjAemA/jBzcfDLP/M7QkasVbzw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mVWrpD+HygCwj7C0nElze1ON1Ta3ERXApDsjcza2Fb7G0N6u9Y3FU/BRIF5BYyqqu
         73jx1Ue4i1X/3SY72oZMKgb/ruGZG0yIRkHvhRP7NLFA+lNSmgfl4EL/YdOidI27vT
         pGYN/efsB82p69Y7AMlYiwJ0sGZlGsS/dHQGn4/I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5HDj5t7100260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jun 2019 08:45:05 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 17
 Jun 2019 08:45:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 17 Jun 2019 08:45:05 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5HDj4fU125494;
        Mon, 17 Jun 2019 08:45:04 -0500
Subject: Re: [PATCH] dt: leds-lm36274.txt: fix a broken reference to
 ti-lmu.txt
To:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <79b9bf3388eb231da77c6a804862d21339262d0a.1560421387.git.mchehab+samsung@kernel.org>
 <20190617131220.GD21113@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a15bace8-90a8-4201-86af-9fb464024f0a@ti.com>
Date:   Mon, 17 Jun 2019 08:45:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617131220.GD21113@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/19 8:12 AM, Pavel Machek wrote:
> On Thu 2019-06-13 07:23:15, Mauro Carvalho Chehab wrote:
>> There's a typo there:
>> 	ti_lmu.txt -> ti-lmu.txt
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Dan Murphy <dmurphy@ti.com>
>
>> @@ -6,7 +6,7 @@ up to 29V total output voltage. The 11-bit LED current is programmable via
>>   the I2C bus and/or controlled via a logic level PWM input from 60 uA to 30 mA.
>>   
>>   Parent device properties are documented in
>> -Documentation/devicetree/bindings/mfd/ti_lmu.txt
>> +Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>   
>>   Regulator properties are documented in
>>   Documentation/devicetree/bindings/regulator/lm363x-regulator.txt
