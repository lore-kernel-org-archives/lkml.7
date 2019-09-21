Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756A20882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfIUBY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:24:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730608AbfIUBY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:24:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A9ED10FCBC2F5B5A952;
        Sat, 21 Sep 2019 09:24:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 21 Sep 2019
 09:24:18 +0800
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>, <dilinger@queued.net>,
        LKML <linux-kernel@vger.kernel.org>, <daniel.santos@pobox.com>,
        <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk>
 <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
 <20190920124532.GN1131@ZenIV.linux.org.uk>
 <20190920125442.GA20754@ZenIV.linux.org.uk>
 <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
 <CAFLxGvzeLTVfA17DMEi5tSkzkUgJncjX5oHWe207x7bfUtugtw@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <b2425bd2-38e9-cb9b-4151-94891f3a71d1@huawei.com>
Date:   Sat, 21 Sep 2019 09:24:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzeLTVfA17DMEi5tSkzkUgJncjX5oHWe207x7bfUtugtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2019/9/20 22:38, Richard Weinberger wrote:
> On Fri, Sep 20, 2019 at 4:14 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>> I still think this is easier to understand:
>>  Free the memory allocated by the current function in the failed branch
> 
> Please note that jffs2 is in "odd fixes only" maintenance mode.
> Therefore patches like this cannot be processed.
> 
> On my never ending review queue are some other jffs2 patches which
> seem to address
> real problems. These go first.
> 
> I see that many patches come form Huawei, maybe one of you can help
> maintaining jffs2?
> Reviews, tests, etc.. are very welcome!
> 
In Huawei we use jffs2 broadly in our products to support filesystem on raw
NOR flash and NAND flash, so fixing the bugs in jffs2 means a lot to us.

Although I have not read all of jffs2 code thoroughly, I had find and "fixed"
some bugs in jffs2 and I am willing to do any help in the jffs2 community. Maybe
we can start by testing and reviewing the pending patches in patch work ?

Regards,
Tao

