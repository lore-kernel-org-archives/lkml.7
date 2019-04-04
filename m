Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55E82082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s9iIeE7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfDDMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33750 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34C7bYG085753;
        Thu, 4 Apr 2019 07:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554379657;
        bh=dB9FxF1Fr0tWpbEoSN87mfEh6nE2fOb+DiJX9WarJKg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s9iIeE7VacLT8N2YtQE9aekmhGdDdqDHCWhzyVeFVuPUYAMCNJH6raX3jz2vMyxkm
         Q8mfWFv1cxmWV5NHGb57y1EMMDEAnlLT6UaqaZK4LsC1ncfIghU62tr4PbtZ3u1vGX
         Xaf67zzwa2al2fS63UVdnGxvwqJjY5SkUqv5AjrI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34C7beb010772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 07:07:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 07:07:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 07:07:37 -0500
Received: from [172.22.74.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34C7amt066219;
        Thu, 4 Apr 2019 07:07:36 -0500
Subject: Re: [PATCH 1/5] dt-bindings: mfd: Update the ramp up/down property
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-2-dmurphy@ti.com> <20190404081907.GO6830@dell>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d25c9893-c90c-7020-91c9-f1b1372afe21@ti.com>
Date:   Thu, 4 Apr 2019 07:07:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404081907.GO6830@dell>
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

On 4/4/19 3:19 AM, Lee Jones wrote:
> On Mon, 25 Mar 2019, Dan Murphy wrote:
> 
>> Modify the ramp-up/down property and add the property description
>> to the binding.
> 
> This is the 'what', but where is the 'why'?
> 

I will add the why in v2.

Dan
<snip>

-- 
------------------
Dan Murphy
