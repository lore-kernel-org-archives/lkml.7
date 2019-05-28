Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD473C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949E42133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfE1PmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:42:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfE1PmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:42:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A53B968E89E32545B015;
        Tue, 28 May 2019 23:42:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 23:41:57 +0800
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
To:     Sven Van Asbroeck <thesven73@gmail.com>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
 <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com>
Date:   Tue, 28 May 2019 23:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 22:35, Sven Van Asbroeck wrote:
> On Tue, May 28, 2019 at 10:31 AM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
>>
> 
> checkpatch.pl errors remain:
> 
> $ ./scripts/checkpatch.pl < ~/Downloads/YueHaibing.eml
> ERROR: DOS line endings
> #92: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
> +^Iselect REGMAP_MMIO^M$

This seems text/plain messages have crlf set when saved as .eml file,

I do check my v2 patch is not crlf ending, but when save as eml file in

my thunderbird, it becomes crlf ending.

> 
> total: 1 errors, 0 warnings, 0 checks, 7 lines checked
> 
> 

