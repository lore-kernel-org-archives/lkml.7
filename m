Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C524C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8D22D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfHTLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:49:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbfHTLts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:49:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0C39179BBA873435022;
        Tue, 20 Aug 2019 19:49:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 19:49:40 +0800
Subject: Re: [PATCH v2 linux-next 0/2] change mux_configure32() to static
To:     Vinod Koul <vkoul@kernel.org>
References: <20190814072105.144107-1-maowenan@huawei.com>
 <20190820114105.GW12733@vkoul-mobl.Dlink>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <bdd606cb-535f-c153-d51f-4571db2d23dc@huawei.com>
Date:   Tue, 20 Aug 2019 19:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190820114105.GW12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/20 19:41, Vinod Koul wrote:
> On 14-08-19, 15:21, Mao Wenan wrote:
>> First patch is to make mux_configure32() static to avoid sparse warning,
>> the second patch is to chage alignment of two functions.
> 
> The subsystem name is "dmaengine" please use that in future, I have
> fixed that and applied

Okay, thanks.

> 
>> v2: change subject from "drivers: dma: Fix sparse warning for mux_configure32"
>> to "drivers: dma: make mux_configure32 static", and cleanup the log. And add 
>> one patch to change alignment of two functions. 
>>
>> Mao Wenan (2):
>>   drivers: dma: make mux_configure32 static
>>   drivers: dma: change alignment of mux_configure32 and
>>     fsl_edma_chan_mux
>>
>>  drivers/dma/fsl-edma-common.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.20.1
> 

