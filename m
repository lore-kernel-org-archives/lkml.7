Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9610C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F20520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jtJ7iMll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCDTOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:14:34 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54888 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:14:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24JEG3n092792;
        Mon, 4 Mar 2019 13:14:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551726856;
        bh=SdSdaTUKGuTQV33VcADHbb+AiiyloRtVau1XhnnuVnM=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=jtJ7iMllcML2O3VT+EDP5cd+6rptJznlqApixvn89Ld+6twko/YQKxejXGZp9Z3G4
         g5X6mtYZ6xOpo/5K1XA8fYBf8HME4a5djD2XdxiFkbpt7KQsZyw6t0R+36KEq0s0rk
         WZ0BefpYnHCmVN2VE5+86iAR0IYC9jwaeWEu9xpU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24JEGsT129524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 13:14:16 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 13:14:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 13:14:15 -0600
Received: from [172.22.87.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24JEFI8032326;
        Mon, 4 Mar 2019 13:14:15 -0600
From:   Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <lee.jones@linaro.org>, <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com> <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com> <20181026083703.GB19434@amd>
 <bdb73aa2-60d9-3356-f934-091f738e20a0@ti.com> <20190302230725.GA9225@amd>
Message-ID: <46624fe6-c767-1872-c8c0-06cbf9a59e05@ti.com>
Date:   Mon, 4 Mar 2019 13:14:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190302230725.GA9225@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 3/2/19 5:07 PM, Pavel Machek wrote:
> Hi!
> 
>> I just want to follow up here and let you know that I have not abandoned this.
>> I am trying to rework and fix up the ti lmu binding as asked by Pavel.  Its proving
>> to be a bit of a challenge based on looking forward to what will be the implementation.
>>
>> I also did go offline and speak with Tony.  I have a Droid 4 so I can test all of this on
>> production hardware as well.
>>
>> Updated patchset will take some time to get out.
> 
> Is there any progress here?
> 
> This is needed for display on Droid 4, so it is somehow
> important... and Milo Kim's patches are pretty reasonable.
> 
> I still believe best way forward is to merge them, and let you submit
> any improvements on top of them...
> 

I had looked at this a while back.  And I will pick this up again as it seems that the
multi color framework will take longer than expected.

For the Droid 4 it uses the lm3552 backlight driver, at least that is what is in the DT.

There is a lm3530 backlight driver that is already available and could be upgraded to DT support and have the lm3552
added to it but the issues are the 3532 has 3 outputs and the 3530 has 1 and the register map is a bit different.

There are register differences between the two devices but the driver already has ramp support, PWM support (exponential/linear),
ALS support and manual support already available along with user space configuration.

I was working on creating a new lm3532 driver based off the lm3530 driver or adapting the 3530 to include the 3532 and
making the driver generic to this family.

Dan

> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
