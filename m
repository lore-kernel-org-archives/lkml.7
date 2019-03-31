Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9B320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p/ktOyrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfCaNAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 09:00:43 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:63317 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 09:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554037242; x=1585573242;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4r12QF1YlbKuvihZ49I4lEJ1jPMVtrS644wwjHYgVxw=;
  b=p/ktOyrIEMJ9gwuHwbYCLYDDSqrSIK3qzIYithfyeOrTtj4jIt/Br4+N
   yDGGSV6l7PPuMyoTKGTa0Iiac320nqP3fWglGva6pzNKHf+hTl4C+vYTG
   qELLfvJf3zCVFVaoSKQkWepbBW9U4KJfb/+c1mjeoIBmh2kyw8VLAjltK
   E=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="725132981"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 13:00:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2VD0XTR116107
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 13:00:37 GMT
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 13:00:36 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 13:00:36 +0000
Received: from [10.55.99.151] (10.55.99.151) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Sun, 31 Mar 2019 13:00:30 +0000
Subject: Re: [PATCH 2/7] irqchip/alpine-msi: Update driver license to use SPDX
To:     Mukesh Ojha <mojha@codeaurora.org>, <tsahee@annapurnalabs.com>,
        <antoine.tenart@bootlin.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <barakw@amazon.com>,
        <vaerov@amazon.com>, <linux-kernel@vger.kernel.org>,
        <hanochu@amazon.com>, <linux-acpi@vger.kernel.org>,
        <zeev@amazon.com>, <dwmw@amazon.co.uk>, <jonnyc@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <alisaidi@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
 <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
 <c99273a0-f85a-9fd1-84d4-d5062385a94f@codeaurora.org>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <c2591ea0-29ea-3b54-768d-aa3c8914c8de@amazon.com>
Date:   Sun, 31 Mar 2019 16:00:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <c99273a0-f85a-9fd1-84d4-d5062385a94f@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2019 3:46 PM, Mukesh Ojha wrote:
> 
> On 3/31/2019 6:04 PM, Hanna Hawa wrote:
>> Update driver license to be in-line with Linux conventions.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> 
>> ---
>>   drivers/irqchip/irq-alpine-msi.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-alpine-msi.c 
>> b/drivers/irqchip/irq-alpine-msi.c
>> index ae2fca7..ec6a606 100644
>> --- a/drivers/irqchip/irq-alpine-msi.c
>> +++ b/drivers/irqchip/irq-alpine-msi.c
>> @@ -1,13 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> 
> Please fix this as per.
> https://lkml.org/lkml/2019/2/13/570
> 
I'll fix in next patch-set, I'll wait for more inputs on other patches 
in the series.

Thanks,
Hanna
> 
> cheers,
> Mukesh
> 
>>   /*
>>    * Annapurna Labs MSIX support services
>>    *
>>    * Copyright (C) 2016, Amazon.com, Inc. or its affiliates. All 
>> Rights Reserved.
>>    *
>>    * Antoine Tenart <antoine.tenart@free-electrons.com>
>> - *
>> - * This file is licensed under the terms of the GNU General Public
>> - * License version 2. This program is licensed "as is" without any
>> - * warranty of any kind, whether express or implied.
>>    */
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
