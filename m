Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8008C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EF020869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pUMNIMmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLSqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:46:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57500 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:46:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CIk2dA006981;
        Fri, 12 Apr 2019 13:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555094762;
        bh=XwopXtQi7+sc/15JTvjlEjAp2MqRIqAo4dsccnDSPoY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pUMNIMmN1Uks2A4EeQedxlfkNIQP4NO0HhY7FCOKoCpMwqvGOIrUbnrvYBdAz77Ch
         WyiLA5FawGQxKXZu1T6qgxE0Hahm0INHbnoxRIgwpwGtKyQddhnbq3j1aZb7mWXkny
         Tuv6o1szP2aoRlzzzyRoWJPyddlWBqNcE9RUph/Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CIk2Ys038260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 13:46:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 13:46:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 13:46:01 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CIk1cv008832;
        Fri, 12 Apr 2019 13:46:01 -0500
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Behun <marek.behun@nic.cz>
CC:     <robh+dt@kernel.org>, <pavel@ucw.cz>, <rdunlap@infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
 <4e22f95f-8658-99cd-145e-b96f9e8314f7@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <579add89-e274-07d2-04a4-4998917a62ff@ti.com>
Date:   Fri, 12 Apr 2019 13:46:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4e22f95f-8658-99cd-145e-b96f9e8314f7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 4/12/19 1:14 PM, Jacek Anaszewski wrote:
> Hi Marek,
> 
> On 4/12/19 12:07 AM, Marek Behun wrote:
>> Hi Dan,
>> this probaly was discussed, but I did not follow brightness model
>> discussions:
>> what will happen if I set yellow by writing into yellow mode
>> brightness, and then orange by writing orange model brightness?
>> Will the resulting color be a mix of yellow and orange, or will the
>> orange overwrite the yellow setting?
> 
> Orange will overwrite yellow settings. When color name is given
> it should be treated as a hue. Then changing brightness level
> should affect the lightness of a hue, similarly like changing
> L component of HSL color model. This will be however entirely
> up to DT brightness-model designer how they will design their models.
> We are not going to verify that in the LED multi color class.
> 
> It implies that it will be possible to define arbitrary range
> of color levels, not necessarily adhering to any established color
> model. I think it could be useful to define brightness model
> that allows to go from blue color (for cold) up to red (hot)
> for representing a temperature for instance.
> 
> These ideas will need however more documentation. Generally
> we aim to propose only a convention.
> 

Ah but what about the issue of writing the monochrome LED color.  With your description
it implies that when we write the red LED, the red LED will come on and if we write the blue
LED then the red LED in theory should turn off and the blue come on.

But these could be used to mix the colors to create some abstract violet that is not defined in the brightness
model.  Why should the brightness models and monochrome LEDs have two different operations.

Dan
