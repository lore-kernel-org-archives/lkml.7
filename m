Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2C021A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfIZHs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:48:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729343AbfIZHs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:48:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 047DA29B3125F2E72D70;
        Thu, 26 Sep 2019 15:48:56 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 15:48:52 +0800
Subject: Re: [PATCH v2 3/3] platform/x86: intel_oaktrail: Use pr_warn instead
 of pr_warning
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>
References: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
 <20190920111207.129106-1-wangkefeng.wang@huawei.com>
 <20190920111207.129106-3-wangkefeng.wang@huawei.com>
 <CAHp75VesyCCKqHKfa-L9gW7sufJZs2Tm60OgrgkY_H0ZcEuDYA@mail.gmail.com>
 <627e842d-cd00-e370-643f-fcaa0222cad5@huawei.com>
 <CAHp75VcyuaWYLAQZhwvPLO=JHKUpuTujSEAQL1PMeV5jK7QnCw@mail.gmail.com>
 <6251b209-ed1a-78ff-51df-ca0e663f5b05@huawei.com>
 <CAHp75Vd4DNqY-m6cz0t2Bg6ZS=v3qQ1oagYgbUwfd4daxLTyFA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <4669c5b0-8587-92b7-a9da-5fbbb5255ff4@huawei.com>
Date:   Thu, 26 Sep 2019 15:48:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd4DNqY-m6cz0t2Bg6ZS=v3qQ1oagYgbUwfd4daxLTyFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/26 15:32, Andy Shevchenko wrote:
> On Thu, Sep 26, 2019 at 9:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> On 2019/9/26 13:48, Andy Shevchenko wrote:
>>> On Thu, Sep 26, 2019 at 4:29 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>> On 2019/9/25 23:04, Andy Shevchenko wrote:
>>>>> On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>> You have to send to proper mailing lists and people.
>>>> Used get_maintainer.pl to find the people, and all already in the CC,  will add proper maillist into each patch.
>>>>
>>>>> Don't spam the rest!
>>>> Not so clearly, should I not CC other people not in the list below?
>>>>
>>>> [wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0018-platform-x86-eeepc-laptop-Use-pr_warn-instead-of-pr_.patch
>>>> Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
>>>> Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
>>>> Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
>>> You put a lot more people in Cc, than above list contains.
>>
>> This is a treewide change, and finally kill pr_warning in the whole linux code, so I add more people into Cc list.
> 
> No _this_ is change for only one subsystem / driver.
> Since the set is of independent patches, you may add all people to
> cover letter which I happened not to see and to the patches that are
> core of the series (like one with pr_warning() kill).
> 
> For now I considered them as completely independent to push thru my tree.
> In any case you have to carefully choose the Cc list per each patch in
> a treewide changes.
> 
>> Here is a brief discussion about how this be picked up,  is this ok for you?
>>
>> https://lore.kernel.org/lkml/82fe3d04-2985-7844-31bb-269655c83873@huawei.com/
> 
> I haven't got this. Care to do what I said above about cover letter
> and tell all stakeholders what you are expecting from them to do.

Got it, will put all stakeholders into cover letter next time.
Thanks for your patient guidance.
> 

