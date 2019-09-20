Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C955BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F05217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j6oCpHsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394215AbfITD3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:29:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390917AbfITD3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ETMEGzJM+KCsw/WwZ9tFFZ4suXXVOZT3Pp/x4qDbO20=; b=j6oCpHsXFK0RGqsI61aHSA4bv
        4GjOdMQ6wNCgdj4fzdMikUgCRlbnFRambj5v/uSl6Dozj2EYyfPzh9kXpIk3ECoUf6S7c2rlF0giS
        ehHXceArkHVh9EyvJF7fSaCooXb6pNqmNkoYZSR3WO5kW4ozY5LcL/OUgNT4L/k4xWe1cVV72Bty7
        z09Gh+gZtJDzmuWHnjqlZp4zbwO3krKFsnTxdUBVuYpmjcnaIAdGlEr8RA7KbyAZ8km8mVg/EgBUx
        pcRK9/pXBH5+nzoFXi9eSyHhkUV+fiNpJ2meLcjya7B5D9SYZWqWPItvUz56bAWHhFM45dTYUuekd
        wm2DJA71A==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB9c6-0005ap-BV; Fri, 20 Sep 2019 03:29:42 +0000
Subject: Re: [PATCH 1/2] soc: ti: big cleanup of Kconfig file
To:     santosh.shilimkar@oracle.com, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>
References: <8437a1f9-18f2-dd03-4fea-de5ba71f25c9@infradead.org>
 <97a9a11e-7784-111e-c134-ef88bd6b51ec@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7fd80120-1743-302c-ebc4-f5c7e9b0be05@infradead.org>
Date:   Thu, 19 Sep 2019 20:29:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <97a9a11e-7784-111e-c134-ef88bd6b51ec@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 6:14 PM, santosh.shilimkar@oracle.com wrote:
> On 9/19/19 3:33 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Cleanup drivers/soc/ti/Kconfig:
>> - delete duplicate words
>> - end sentences with '.'
>> - fix typos/spellos
>> - Subsystem is one word
>> - capitalize acronyms
>> - reflow lines to be <= 80 columns
>>
>> Fixes: 41f93af900a2 ("soc: ti: add Keystone Navigator QMSS driver")
>> Fixes: 88139ed03058 ("soc: ti: add Keystone Navigator DMA support")
>> Fixes: afe761f8d3e9 ("soc: ti: Add pm33xx driver for basic suspend support")
>> Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
>> Fixes: a869b7b30dac ("soc: ti: Add Support for AM654 SoC config option")
>> Fixes: cff377f7897a ("soc: ti: Add Support for J721E SoC config option")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Cc: Sandeep Nair <sandeep_n@ti.com>
>> Cc: Dave Gerlach <d-gerlach@ti.com>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> ---
>> @Santosh: MAINTAINERS says that you maintain drivers/soc/ti/*,
>> but there is more that Keystone-related code in that subdirectory
>> now... just in case you want to update that info.
>>
> Yes am aware there more drivers and so far I have been taking
> care of everything in drivers/soc/ti/*

OK :)

>>   drivers/soc/ti/Kconfig |   20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
> Patch looks fine to me. Do you want me to pick this up ?
> 

Yes, please.

-- 
~Randy
