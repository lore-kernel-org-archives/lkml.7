Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D31C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F361D21873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lEIwx3RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfGSUic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:38:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10966 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfGSUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:38:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d322a430000>; Fri, 19 Jul 2019 13:38:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Jul 2019 13:38:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 19 Jul 2019 13:38:29 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 20:38:29 +0000
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
To:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>,
        <SCheung@nvidia.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.vnet.ibm.com>, <benh@kernel.crashing.org>,
        <bsingharora@gmail.com>, <dan.j.williams@intel.com>,
        <dnellans@nvidia.com>, <ebaskakov@nvidia.com>,
        <hannes@cmpxchg.org>, <jglisse@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <liubo95@huawei.com>, <mhairgrove@nvidia.com>, <mhocko@kernel.org>,
        <paulmck@linux.vnet.ibm.com>, <ross.zwisler@linux.intel.com>,
        <sgutti@nvidia.com>, <torvalds@linux-foundation.org>,
        <vdavydov.dev@gmail.com>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org> <20190719105239.GA10627@amd>
 <20190719114853.GB15816@ziepe.ca> <20190719120043.GA15320@infradead.org>
 <20190719120432.GC11224@amd>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b5143eb4-f519-57bc-4058-4ed934596ee1@nvidia.com>
Date:   Fri, 19 Jul 2019 13:38:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719120432.GC11224@amd>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563568707; bh=HOgbiC1squQlyZUEfp8+w/ovzOM9+ohIqBzXO8QodaU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lEIwx3RL04lFpBNY5+S/Kw1meYhtyvjL8ui4abkMkEnIpTrUAs8thEX5l66mPbQHD
         DT9/FtywQh1keTjnzfeOvVEgLB4yeQRQwvY01O21U4FJPx5KHn74cOqmXjVipWMvmd
         YPLOEM205r71SXNovjMmiRrBZ6imBZSFp54TXs6os43ujWgUQNfjb/0M3Dx6+ejJcd
         7Y0KCB0cOQfkYuhuS3JeriCtdXgsuHbRcE/3Ifr5Xe8HeO5QPaXc2/CErw9bWWtEkq
         viWB/uyB1gsFnPwpv6XwWTrGGJZgSo2/MjygaVNPma09JiD4ShLMxQq3UABzUSZ3ZP
         xAlbRrO1obU6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/19 5:04 AM, Pavel Machek wrote:
> On Fri 2019-07-19 05:00:43, Christoph Hellwig wrote:
>> On Fri, Jul 19, 2019 at 08:48:53AM -0300, Jason Gunthorpe wrote:
>>> It is like MMU_NOTIFIERS, if something needs it, then it will select
>>> it.
>>>
>>> Maybe it should just be a hidden kconfig anyhow as there is no reason
>>> to turn it on without also turning on a using driver.
>>
>> We can't just select it due to the odd X86_64 || PPC64 dependency.
>>
>> Which also answers Pavels question:  you never really need it, as we
>> can only use it for optional functionality due to that.
> 
> Okay, just explain it in the help text :-)..
> 
> Alternatively... you can have WANT_HMM_MIRROR option drivers select,
> and option HMM_MIRROR which is yes if WANT_HMM_MIRROR && (X86_64 ||
> PPC64), no?
> 

Yes. This really should be a hidden option that just auto-enables. It's
not ideal to require people to both *find* HMM_MIRROR, *and* figure out 
that they need it. (I think it's just this way due to the history of how
HMM got merged--it started off as a kind of experimental sandbox, so
it had it's own config options, to avoid bothering anything else.)

I'll send out a new patch to just auto-select. The WANT_HMM_MIRROR
approach seems accurate, given the (X86_64 || PPC64) complication, probably
after -rc1 is ready (I don't see the ODP code using HMM yet, so that
must not have been merged yet.)

Longer term, I vaguely recall that there is no strong reason preventing 
HMM from being made to work on other arches, and am hoping that it was
just done this way to save development time. I don't want to leave it 
this way unless there's a good reason to.

thanks,
-- 
John Hubbard
NVIDIA
