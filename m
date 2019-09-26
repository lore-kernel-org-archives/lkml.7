Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF8C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332D3222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbfIZBow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:44:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388922AbfIZBow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:44:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 132BA6BCFDA8F17F772B;
        Thu, 26 Sep 2019 09:44:49 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 09:44:46 +0800
Subject: Re: [PATCH 24/32] dma-debug: Use pr_warn instead of pr_warning
To:     Christoph Hellwig <hch@lst.de>
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
        <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-25-wangkefeng.wang@huawei.com>
 <20190925171304.GA16861@lst.de>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <7439236f-a8c8-df62-a1cd-7b6c45538ad7@huawei.com>
Date:   Thu, 26 Sep 2019 09:44:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925171304.GA16861@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/26 1:13, Christoph Hellwig wrote:
> On Fri, Sep 20, 2019 at 02:25:36PM +0800, Kefeng Wang wrote:
>> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
>> pr_warning"), removing pr_warning so all logging messages use a
>> consistent <prefix>_warn style. Let's do it.
> Please just send a script after -rc1 instead of sending all these
> little patches.

For all changes,  just git grep -w pr_warning | cut -d ':' -f1 | uniq | sort | xargs sed -i 's/pr_warning/pr_warn/g',

but I do need check them manually and make some minor improvements, like coalesce format, realign arguments,

and remove unnecessary line continuations. thus, send these littles patches.

Thanks.

> .
>

