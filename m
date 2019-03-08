Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9390E20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l7C+TBoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCHVIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:08:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55754 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHVIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:08:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28L8VO1122932;
        Fri, 8 Mar 2019 15:08:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552079311;
        bh=ZWTTGyTvHvJr20kzN0lMY7xk4FIsBDGym+RyyL3K204=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l7C+TBohd10Mx/VnIvMCKNKK67l+hjJDCLHOdMI9YpnYueb+iyUQ6VthEBViKBZWx
         U2HKVRWQ39x5CJ4GnZlJcmf/c4FrvklnmdAda1gF23oxptbfLHBfnT0rBzMnDEZbui
         lq1i8CLyCsWhVp+3ZsQJbDc0dd7NjsJDNEQuNQGs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28L8Vis052784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 15:08:31 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 15:08:31 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 15:08:31 -0600
Received: from [172.22.114.154] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28L8U5N012651;
        Fri, 8 Mar 2019 15:08:30 -0600
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <tony@atomide.com>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-2-dmurphy@ti.com> <20190308151422.GA10378@amd>
 <6d9a5821-a634-8ea2-4fe3-0603af757668@ti.com> <20190308210649.GC17626@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9e0a5485-d338-e4e8-5333-cac873158a93@ti.com>
Date:   Fri, 8 Mar 2019 15:08:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190308210649.GC17626@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 3/8/19 3:06 PM, Pavel Machek wrote:
> 
>>>> +		led@1 {
>>>> +			reg = <1>;
>>>> +			led-sources = <1>;
>>>> +			ti,led-mode = <LM3532_BL_MODE_MANUAL>;
>>>> +			label = "keypad";
>>>
>>> I guess best variant would be inputX::backlight here, but that might
>>> be tricky to implement.
>>>
>>
>> Yeah because we don't know what input the keyboard would be on.
>> Unless there are APIs to retrieve that info.  I have not looked at the input
>> framework in a while.
> 
> Lets just make it "platform::kbd_backlight". *:kbd_backlight is
> already used by quite a few drivers.
> 

Sounds fine to me.  I will update in v3 as I posted v2 with a lot of deltas

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
