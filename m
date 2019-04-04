Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1116C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E1206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DCNujwYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDDMJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:09:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51256 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:09:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34C9Ijp060066;
        Thu, 4 Apr 2019 07:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554379758;
        bh=h9bM5mvozZ7xNX26D9bVmXYOr/QnmV9xbxgNfAhDx5A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DCNujwYLcPbj2Fom2LZg+IJ+8DH14L9buVptayxxdsAMAUi4bnO66tzL/UCujZrD9
         OFCKWjh6wW3s7LXAo5nDdFqJkOoQj4vQQmLKNMz8EngMeaPqZrOEu4XGOPy3aL5dNI
         Qkab3TdWXjMYssbq+sRaiPW2dl64e2x/L3Vtdk8U=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34C9IZK013563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 07:09:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 07:09:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 07:09:17 -0500
Received: from [172.22.74.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34C9HpW069163;
        Thu, 4 Apr 2019 07:09:17 -0500
Subject: Re: [PATCH 4/5] mfd: ti-lmu: Remove support for LM3697
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-5-dmurphy@ti.com> <20190404081736.GM6830@dell>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6ebe491c-f124-2849-2e3a-0209dd5a2620@ti.com>
Date:   Thu, 4 Apr 2019 07:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404081736.GM6830@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee

Thanks for the review

On 4/4/19 3:17 AM, Lee Jones wrote:
> On Mon, 25 Mar 2019, Dan Murphy wrote:
> 
>> Remove support for the LM3697 from the ti-lmu
> 
> Bit of an odd place to insert a line feed.
> 

I will fix in v2.

>> driver in favor of a dedicated LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/leds/Kconfig                |  2 +-
>>  drivers/mfd/Kconfig                 |  2 +-
>>  drivers/mfd/ti-lmu.c                | 17 -----------
>>  include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
>>  include/linux/mfd/ti-lmu.h          |  1 -
>>  5 files changed, 2 insertions(+), 64 deletions(-)
> 
> I'm fine with the patch.
> 
> Can you edit drivers/leds/Kconfig as part of a separate patch please?
> Keeping this in sync with this change is not critical and would add a
> whole bunch of process which we can really do without.
> 

Ack.  I will add this when I add the LM3697 config in the Kconfig

Dan

-- 
------------------
Dan Murphy
