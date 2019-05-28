Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A46206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfE1OKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:10:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbfE1OKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:10:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B52CB8CCC9D50648A2C0;
        Tue, 28 May 2019 22:10:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 22:10:45 +0800
Subject: Re: [PATCH -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
To:     Sven Van Asbroeck <thesven73@gmail.com>
References: <20190528133214.21776-1-yuehaibing@huawei.com>
 <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a98ba89b-59d6-3a3b-a342-2f3de796c0a2@huawei.com>
Date:   Tue, 28 May 2019 22:10:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 21:41, Sven Van Asbroeck wrote:
> Hello YueHaibing,
> 
> On Tue, May 28, 2019 at 9:33 AM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
>>
>> drivers/staging/fieldbus/anybuss/arcx-anybus.o: In function `controller_probe':
>> arcx-anybus.c:(.text+0x9d6): undefined reference to `__devm_regmap_init_mmio_clk'
>>
>> Select REGMAP_MMIO to fix it.
> 
> Thank you for noticing this, I appreciate it !
> 
> However, when I run this patch through the scripts/checkpatch.pl
> script, it reports
> some issues. Could you fix and post v2 please?
> 
> checkpatch.pl output follows:
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #68:
> arcx-anybus.c:(.text+0x9d6): undefined reference to
> `__devm_regmap_init_mmio_clk'
> 
> ERROR: DOS line endings
> #87: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
> +^Iselect REGMAP_MMIO^M$
> 
> total: 1 errors, 1 warnings, 0 checks, 7 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Your patch has style problems, please review.

Thanks, will fix it in v2.

> 
> 

