Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6104DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348F920850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YDGFspFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCTTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:06:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:06:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2KJ6FeD057630;
        Wed, 20 Mar 2019 14:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553108775;
        bh=PDsMvF5ovyvEfZYfdZsw6m08ZAQ7BRvEOwFvsRzfCB0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YDGFspFDLc5pOxJ6Q8oXbxQnlpsX8z5NGgCOTdoQjVJe6fGEQRi7zKgmopbBBGT1J
         n2wBIl/OfCkVVGmZUVIW+vMOU1z3RnRWanOXmUaJcjvYBcf8rqObES0QY2DeZLMMDv
         fEibjxf/e5nM9aMX4Jp8MvY07C93tohbN5Y12Kks=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2KJ6EVg040403
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 14:06:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 14:06:14 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 14:06:14 -0500
Received: from [172.22.82.186] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2KJ6Eb2028147;
        Wed, 20 Mar 2019 14:06:14 -0500
Subject: Re: [PATCH v4 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>, <tony@atomide.com>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190313123249.17258-4-dmurphy@ti.com>
 <8623d5bd-e369-9f90-a749-224119e5861b@ti.com>
 <08406168-b20e-527f-23c7-e6543f5b5c10@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c89ebac6-3053-4bb0-c85b-3daa4e7fc52d@ti.com>
Date:   Wed, 20 Mar 2019 14:05:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <08406168-b20e-527f-23c7-e6543f5b5c10@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/20/19 2:00 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> On 3/20/19 1:39 PM, Dan Murphy wrote:
>> Hello
>>
>> On 3/13/19 7:32 AM, Dan Murphy wrote:
>>> Introduce the Texas Instruments LM3532 White LED driver.
>>> The driver supports ALS configurability or manual brightness
>>> control.
>>>
>>> The driver also supports associating LED strings with specific
>>> control banks in a group or as individually controlled strings.
>>>
>>
>> I have a v5 series ready for posting and only the DT was reviewed.
>>
>> Do we have any comments on the code?
> 
> I've just added one comment. After it is addressed please submit v5.
> 

Thank you.  I will give it through the night for others to comment and I will post
v5 tomorrow.

Dan

-- 
------------------
Dan Murphy
