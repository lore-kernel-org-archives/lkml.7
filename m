Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D99C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EFF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJODN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:13:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfJODN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:13:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A4D272D82E6D5D0C390;
        Tue, 15 Oct 2019 11:13:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 11:13:17 +0800
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Will Deacon <will@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunrong Guo <chunrong.guo@nxp.com>,
        "Olof Johansson" <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
 <20191011103342.GL25745@shell.armlinux.org.uk>
 <CAK8P3a1ADTc0woWWNjpeqYEtgb=snj264P4QNWOj7ZRMDv8WNg@mail.gmail.com>
 <20191012145055.GO25745@shell.armlinux.org.uk>
 <20191014162416.uz33olqhgvzioqdk@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bc3bfa97-af61-ce7a-5392-55cd50474a37@huawei.com>
Date:   Tue, 15 Oct 2019 11:13:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191014162416.uz33olqhgvzioqdk@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/15 0:24, Will Deacon wrote:
> On Sat, Oct 12, 2019 at 03:50:55PM +0100, Russell King - ARM Linux admin wrote:
>> On Sat, Oct 12, 2019 at 12:47:45AM +0200, Arnd Bergmann wrote:
>>> On Fri, Oct 11, 2019 at 12:33 PM Russell King - ARM Linux admin
>>> <linux@armlinux.org.uk> wrote:
>>>> 32-bit ARM experience is that telco class users really like big
>>>> endian.
>>>
>>> Right, basically anyone with a large code base migrated over from a
>>> big-endian MIPS or PowerPC legacy that found it cheaper to change
>>> the rest of the world than to fix their own code.
>>
>> I think you need to step off your soap box!  Big endian isn't going
>> away, and it likely has nothing to do with code bases.  Just look at
>> networking and telco protocols.  Everything in that world tends to
>> be big endian.  BE is what is understood in that world, and there's
>> little we can do to change it.
>>
>> Demanding that they switch to LE is tantamount to you demanding that
>> their entire world change - it ain't going to happen.
> 
> Oh, I wasn't demanding anything! Just interested to know if big-endian is
> actually being used because it's not something that I'm able to test
> sensibly and I haven't see anywhere near the amount of (public) effort to
> keep it supported as for little-endian. However, having asked the question,
> it's clear that it does have some users so we'll keep maintaining it on a
> best-effort basis and rely on those users to let us know if anything breaks.

Sure, we (Huawei kernel team) did that and we will do that in the future
as well.

Thanks
Hanjun

