Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646EE2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394795AbfITGbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:31:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388940AbfITGbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:31:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 021F0F182499586AC685;
        Fri, 20 Sep 2019 14:31:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 14:31:27 +0800
Subject: Re: [PATCH 18/32] platform/x86: Use pr_warn instead of pr_warning
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-19-wangkefeng.wang@huawei.com>
 <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <ccbe3ffc-d84f-6c18-f88d-bc7a0b531d66@huawei.com>
Date:   Fri, 20 Sep 2019 14:31:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/20 14:26, Andy Shevchenko wrote:
> On Fri, Sep 20, 2019 at 9:10 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
>> pr_warning"), removing pr_warning so all logging messages use a
>> consistent <prefix>_warn style. Let's do it.
>>
> Please, split on three patches (per driver).
ok, will send v2, thanks.
>
>>  drivers/platform/x86/asus-laptop.c    |  2 +-
>>  drivers/platform/x86/eeepc-laptop.c   |  2 +-
>>  drivers/platform/x86/intel_oaktrail.c | 10 +++++-----

