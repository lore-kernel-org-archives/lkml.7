Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F55C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B620665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfG3B2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:28:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728352AbfG3B2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:28:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2725EAC0D4F5177E9A9;
        Tue, 30 Jul 2019 09:28:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 09:28:35 +0800
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
To:     Jeff Moyer <jmoyer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
 <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
 <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
 <20190729154720.GS1131@ZenIV.linux.org.uk>
 <x49h874n86m.fsf@segfault.boston.devel.redhat.com>
CC:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcrl@kvack.org>,
        <wangkefeng.wang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <04c42460-972a-e2fa-767b-ea3eff07496f@huawei.com>
Date:   Tue, 30 Jul 2019 09:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <x49h874n86m.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/29 23:59, Jeff Moyer Wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
>> On Mon, Jul 29, 2019 at 10:57:41AM -0400, Jeff Moyer wrote:
>>> Al, can you take this through your tree?
>>
>> Umm...  Can do, but I had an impression that Arnd and Deepa
>> had a tree for timespec-related work.  OTOH, it had been
>> relatively quiet last cycle, so...  If they have nothing
>> in the area, I can take it through vfs.git.
> 
> Hmm, okay.  Yi, can you repost the patch, adding my Reviewed-by tag, and
> CC-ing Arnd and Deepa:
>

Yes, will do.

Thanks,
Yi.

