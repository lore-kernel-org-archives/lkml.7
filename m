Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646DC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342E820857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RuFfLcGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfDBLxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:53:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34424 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDBLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:53:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32BrV3R049013;
        Tue, 2 Apr 2019 06:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554206011;
        bh=A+/yNFGAasYygghk616I28v7p8AvbtQE0el+4KQgItQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RuFfLcGojPwi6YRN1P00NgoGz0mYAnR21EaD4MhtzpaH4mgBMEMD+OAXKrsV00s0D
         gXYiPUtuJ6Gn8hjnNohdJuBWcKMxswtjOLM4mg/qoWLlgjrT/49mQ/YXzBBD7+40d/
         ZnKAoH3FqAMXM/S1ylH4DOtI1hPcTFq3qoHkHPZs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32BrVqa069095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 06:53:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 06:53:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 06:53:31 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32BrVEK032694;
        Tue, 2 Apr 2019 06:53:31 -0500
Subject: Re: [RFC PATCH 3/5] documention: leds: Add multicolor class
 documentation
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-4-dmurphy@ti.com> <20190401212709.GA14681@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e2621a54-4c5c-4235-9aba-39a856cfbe88@ti.com>
Date:   Tue, 2 Apr 2019 06:53:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401212709.GA14681@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the comments

On 4/1/19 4:27 PM, Pavel Machek wrote:
> Hi!
> 
>> +Under the "colors" directory there are two files created "sync" and
>> +"sync_enable". The sync_enable file controls whether the LED brightness
>> +value is set real time or if the LED brightness value setting is deferred until
>> +the "sync" file is written.  If sync_enable is set then writing to each LED
>> +"brightness" file will store the brightness value.  Once the "sync" file is
>> +written then each LED color defined in the node will write the brightness of
>> +the LED in the device driver.
>> +
>> +If "sync_enable" is not set then writing the brightness value of the LED to the
>> +device driver is done immediately.  Writing the "sync" file has no
>> affect.
> 
> I believe better solutions exists for this problem.
> 

I agree there are other solutions.  Better not so sure.
We keep kicking a solution down the road we have been talking about adding something to the kernel
for almost 5 months now, but no one can decide what to do.

How do we move a solution forward?
Should we just forget the whole idea and keep developing against the current framework?

> One was discussed before -- have single file which contains
> coefficients for r/g/b channels.
> 

That has been presented as well and the concept was not well received either.

> Or at least... you should not really need separate sync and
> sync_enable files. One should do.
> 

The idea here was to be able to set the LED brightness immediately on a single LED
with a single brightness write or setup the color brightness on all the LEDs and then
sync the LED brightnesses.

If you wanted to control a single LED for notifications the user space may have to do

echo 0 > blue/brightness
echo 0 > green/brightness
echo 255 > red/brightness
echo 1 > sync

As opposed to just
echo 255 > red/brightness

But if that is not a concern then removing the sync_enable is fine with me from a code standpoint
but not from a user space side.

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
