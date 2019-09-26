Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54928C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283E621A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfIZGYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:24:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbfIZGYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:24:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A79049522AA36A02A663;
        Thu, 26 Sep 2019 14:09:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 14:09:10 +0800
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
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6251b209-ed1a-78ff-51df-ca0e663f5b05@huawei.com>
Date:   Thu, 26 Sep 2019 14:09:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcyuaWYLAQZhwvPLO=JHKUpuTujSEAQL1PMeV5jK7QnCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/26 13:48, Andy Shevchenko wrote:
> On Thu, Sep 26, 2019 at 4:29 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> On 2019/9/25 23:04, Andy Shevchenko wrote:
>>> On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>> You have to send to proper mailing lists and people.
>> Used get_maintainer.pl to find the people, and all already in the CC,  will add proper maillist into each patch.
>>
>>> Don't spam the rest!
>> Not so clearly, should I not CC other people not in the list below?
>>
>> [wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0018-platform-x86-eeepc-laptop-Use-pr_warn-instead-of-pr_.patch
>> Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
>> Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
>> Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
> You put a lot more people in Cc, than above list contains.

This is a treewide change, and finally kill pr_warning in the whole linux code, so I add more people into Cc list.

Here is a brief discussion about how this be picked up,  is this ok for you?

https://lore.kernel.org/lkml/82fe3d04-2985-7844-31bb-269655c83873@huawei.com/


>
>> acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
>> platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
> This had been absent in your submission.

Ok , will be more careful about this next time.

Thanks.

>
>> linux-kernel@vger.kernel.org (open list)

