Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54953C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED620674
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dVrpil9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfDXTYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:24:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58550 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:24:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OJOE5w066682;
        Wed, 24 Apr 2019 14:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556133854;
        bh=5nU/mChYmQQFCu0ILhVvef64xkJ8yAnIZdsupob8ZTQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dVrpil9Cyl8Paq9B+G+35W3RnwhXnQIGWOakjQOma+6Pi+WmRyKhc3BpX6FG5zkJd
         GmxbbNMTyd9/o/VAT3Ew5R2MNCznvZQtMnSP4DDI0a+1dXdM1s/wfrsvBSoVSWpBMU
         DgicLQ1ChPeikG9EkfZEyudZ0KH5+avTGKqsckMo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OJOEID120763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 14:24:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 14:24:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 14:24:13 -0500
Received: from [10.250.90.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OJODEG059672;
        Wed, 24 Apr 2019 14:24:13 -0500
Subject: Re: [PATCH v2 4/6] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <robh+dt@kernel.org>
CC:     <pavel@ucw.cz>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190405142855.3969-1-dmurphy@ti.com>
 <20190405142855.3969-4-dmurphy@ti.com>
 <04e160da-a73e-d330-3df4-8f420b3612b4@gmail.com>
 <1a1482f7-a683-49d5-69a3-aa73a641288e@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <fb03c31e-2050-0975-f737-dcf401c45380@ti.com>
Date:   Wed, 24 Apr 2019 14:24:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1a1482f7-a683-49d5-69a3-aa73a641288e@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump for Rob

On 4/12/19 2:34 PM, Jacek Anaszewski wrote:
> And one more:
> 
> [5] - LED naming patch set v3
> 
> On 4/11/19 9:48 PM, Jacek Anaszewski wrote:
>> Hi Rob,
>>
>> I've collected references to the DT patches we're waiting
>> to be reviewed. This is just to make sure that none of them
>> will be missed - recent traffic on the linux-leds list
>> is a bit heavier.
>>
>> [0] - draft of LED multi color class - we would especially like
>>        to get a feedback on the proposed brightness-model DT design
>> [1][2] - LM3697 backlight driver rework
>> [3][4] - LM36274 backlight driver with regulator support
>>
>> On 4/5/19 4:28 PM, Dan Murphy wrote:
>>> The LM3697 is a single function LED driver. The single function LED
>>> driver needs to reside in the LED directory as a dedicated LED driver
>>> and not as a MFD device.  The device does have common brightness and ramp
>>> features and those can be accomodated by a TI LMU framework.
>>>
>>> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
>>> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>>> current LED and general bindings guidelines.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> [...]
>> [0] https://marc.info/?l=linux-kernel&m=155414072611538&w=2
>> [1] https://marc.info/?l=devicetree&m=155447454524411&w=2
>> [2] https://lore.kernel.org/patchwork/patch/1058762/
>> [3] https://marc.info/?l=devicetree&m=155447624324995&w=2
>> [4] https://lore.kernel.org/patchwork/patch/1058779/
>>
> 
> [5] - https://marc.info/?l=linux-kernel&m=155405492231039&w=2
> 
