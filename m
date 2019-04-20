Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B0C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169F721479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfDTDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:13:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbfDTDNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:13:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83048725AFBA253BE0CF;
        Sat, 20 Apr 2019 11:13:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sat, 20 Apr 2019
 11:13:24 +0800
Subject: Re: [PATCH -next] regulator: Make symbols static
To:     Mark Brown <broonie@kernel.org>
References: <20190416144109.33692-1-yuehaibing@huawei.com>
 <20190419161206.GA18211@sirena.org.uk>
CC:     <lgirdwood@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <27596178-6321-738c-18ed-c8bddb7c3ff4@huawei.com>
Date:   Sat, 20 Apr 2019 11:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190419161206.GA18211@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/20 0:12, Mark Brown wrote:
> On Tue, Apr 16, 2019 at 10:41:09PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warnings:
>>
>> drivers/regulator/stm32-pwr.c:35:5: warning:
>>  symbol 'ready_mask_table' was not declared. Should it be static?
>> drivers/regulator/stm32-pwr.c:47:5: warning:
>>  symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
>> drivers/regulator/stm32-pwr.c:57:5: warning:
>>  symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?
> 
> This doesn't apply against current code, please check and resend (I
> think it's just that someone else made similar fixes already but didn't
> check properly).

Yep, there is already a fix from kbuild test robot:

82f26185a912 ("regulator: ready_mask_table[] can be static")

> 

