Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B5FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E45E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U0qv8esj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfDJLh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:37:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53690 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfDJLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:37:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ABbJN0057012;
        Wed, 10 Apr 2019 06:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554896239;
        bh=pLjml6l5c/g2rQfDbHaItqIri60FtM40EWbRqlqeUS0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U0qv8esjh2ZdlTCX6UtMiI8i5tBubf/C8exQOgAsu+YXrN8/e0di6pcnwCT0WDdml
         7SS0+4kxjT5DMhMygNZ8U0p+83N1479GChlpHyoxsowpj/cnFBiyPEzWJErnetnjEl
         vkp3DxnNloBNOsacGpYEXq7BR4jdOXxRtWIsGcLg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ABbJfD130937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Apr 2019 06:37:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 10
 Apr 2019 06:37:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 10 Apr 2019 06:37:19 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ABbIV1067999;
        Wed, 10 Apr 2019 06:37:18 -0500
Subject: Re: [PATCH 5/6] dt-bindings: leds: Add LED bindings for the LM36274
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190405145540.27703-1-dmurphy@ti.com>
 <20190405145540.27703-6-dmurphy@ti.com> <20190408101039.GC30958@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <84566e9f-f00a-0984-0279-67e49a2d9331@ti.com>
Date:   Wed, 10 Apr 2019 06:37:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408101039.GC30958@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel


On 4/8/19 5:10 AM, Pavel Machek wrote:
> On Fri 2019-04-05 09:55:39, Dan Murphy wrote:
>> Add the LM36274 LED specific bindings.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../devicetree/bindings/leds/leds-lm36274.txt | 82 +++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm36274.txt b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
>> new file mode 100644
>> index 000000000000..359990d85b28
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
>> @@ -0,0 +1,82 @@
>> +* Texas Instruments LM36274 4-Channel LCD Backlight Driver w/Integrated Bias
>> +
>> +The LM36274 is an integrated four-channel WLED driver and LCD bias supply.
>> +The backlight boost provides the power to bias four parallel LED strings with
>> +up to 29-V total output voltage. The 11-bit LED current is rogrammable via
> 29V
>
Ack


> 								Pavel
