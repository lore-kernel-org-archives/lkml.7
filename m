Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD251C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vnXCDsW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfDBNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47290 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfDBNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:44:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32DiNCo112585;
        Tue, 2 Apr 2019 08:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212663;
        bh=J6pYEexdvRmWufpZJ5S9lvcoxxQlJJ7TaS/1TPiMFiU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vnXCDsW3JM7T+lRb8aLTiRs4DpH9mp/xy2ys2dRtl4vyqb6jrTFqJ23AZ1amjBonL
         Cupu8iYo4Th2r8YA8kBikZXNnDNRsdlscUBGYoit9MX02VOm7WQ05SaKNZsHA7f8cR
         /cFySFT6eB0OtmGIq3vVd1zcZ1AN+oxJ7F6kpRvU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32DiNpb080079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:44:23 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:44:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:44:23 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DiMD4061012;
        Tue, 2 Apr 2019 08:44:22 -0500
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>
CC:     <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
 <20190402132440.GA10359@basecamp>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
Date:   Tue, 2 Apr 2019 08:44:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402132440.GA10359@basecamp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian

On 4/2/19 8:24 AM, Brian Masney wrote:
> On Tue, Apr 02, 2019 at 07:56:55AM -0500, Dan Murphy wrote:
>> This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
>> and not use led-sources.  But led-sources is the property of choice.
>>
>> led@0 {
>> 	reg = <0>;
>> 	led-sources = < 0 1 >;
>> 	label = "main-lcd";
>> 	default-brightness = <200>;
>> 	max-brightness = <255>;
>> };
> 
> OK, I see. I wondered how we could do that in device tree.
> 
>>> +    properties:
>>> +      label:
>>> +        description: |
>>> +          The label for this LED. If omitted, the label is taken from the node
>>> +          name (excluding the unit address). It has to uniquely identify a
>>> +          device, i.e. no other LED class device can be assigned the same label.
>>> +
>>> +      led-sources:
>>> +        description: |
>>> +          List of device current outputs the LED is connected to.
>>> +        allOf:
>>> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +          - minItems: 1
>>> +            maxItems: 2
>>> +            items:
>>> +              minimum: 0
>>> +              maximum: 1
>>> +
>>
>> label and led-sources are already defined in the common.txt no need to redefine them here.
> 
> If I'm going to use the new-style bindings, then I'll need to convert
> common.txt over to use the new format as well so that the automated
> schema validations will work. I'm willing to do that work if there is
> interest from the LED / backlight maintainers. The main issue is that
> there are 62 references to the file common.txt in the directory
> Documentation/devicetree/bindings/leds/. Would the maintainers prefer:
> 
> - Once common.txt is converted to common.yaml, make common.txt only
>   have a line stating that the common bindings were moved into
>   common.yaml. We can remove this file once all of the other bindings
>   are converted to the new-style format.
> 
> - Update all references to common.txt to common.yaml. (1 patch or 62
>   patches?)
> 
> - Or, just go with the older-style binding format for now.
> 
> Thanks Dan for your other comments. They make sense and I'll incorporate
> those changes into my next version.
> 

That is up to the maintainers.

Also one other comment I noticed when reviewing the code that there is no definition to
which child led properties are optional and which are required?

Dan

> Brian
> 


-- 
------------------
Dan Murphy
