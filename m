Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7F222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbfIZB3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:29:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388786AbfIZB3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:29:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69CD5C2D2E02629EA757;
        Thu, 26 Sep 2019 09:29:05 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 09:29:00 +0800
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
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <627e842d-cd00-e370-643f-fcaa0222cad5@huawei.com>
Date:   Thu, 26 Sep 2019 09:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VesyCCKqHKfa-L9gW7sufJZs2Tm60OgrgkY_H0ZcEuDYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/25 23:04, Andy Shevchenko wrote:
> On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
>> pr_warning"), removing pr_warning so all logging messages use a
>> consistent <prefix>_warn style. Let's do it.
>>
> You have to send to proper mailing lists and people.

Used get_maintainer.pl to find the people, and all already in the CC,  will add proper maillist into each patch.

> Don't spam the rest!
Not so clearly, should I not CC other people not in the list below?

[wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0018-platform-x86-eeepc-laptop-Use-pr_warn-instead-of-pr_.patch
Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
linux-kernel@vger.kernel.org (open list)
[wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0019-platform-x86-asus-laptop-Use-pr_warn-instead-of-pr_w.patch
Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
linux-kernel@vger.kernel.org (open list)
[wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0020-platform-x86-intel_oaktrail-Use-pr_warn-instead-of-p.patch
Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS,commit_signer:2/2=100%,authored:2/2=100%,added_lines:9/9=100%,removed_lines:23/23=100%)
platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
linux-kernel@vger.kernel.org (open list)

>> Cc: Corentin Chary <corentin.chary@gmail.com>
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Andy Shevchenko <andy@infradead.org>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/platform/x86/intel_oaktrail.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel_oaktrail.c
>> index 3c0438ba385e..1a09a75bd16d 100644
>> --- a/drivers/platform/x86/intel_oaktrail.c
>> +++ b/drivers/platform/x86/intel_oaktrail.c
>> @@ -243,7 +243,7 @@ static int oaktrail_backlight_init(void)
>>
>>         if (IS_ERR(bd)) {
>>                 oaktrail_bl_device = NULL;
>> -               pr_warning("Unable to register backlight device\n");
>> +               pr_warn("Unable to register backlight device\n");
>>                 return PTR_ERR(bd);
>>         }
>>
>> @@ -313,20 +313,20 @@ static int __init oaktrail_init(void)
>>
>>         ret = platform_driver_register(&oaktrail_driver);
>>         if (ret) {
>> -               pr_warning("Unable to register platform driver\n");
>> +               pr_warn("Unable to register platform driver\n");
>>                 goto err_driver_reg;
>>         }
>>
>>         oaktrail_device = platform_device_alloc(DRIVER_NAME, -1);
>>         if (!oaktrail_device) {
>> -               pr_warning("Unable to allocate platform device\n");
>> +               pr_warn("Unable to allocate platform device\n");
>>                 ret = -ENOMEM;
>>                 goto err_device_alloc;
>>         }
>>
>>         ret = platform_device_add(oaktrail_device);
>>         if (ret) {
>> -               pr_warning("Unable to add platform device\n");
>> +               pr_warn("Unable to add platform device\n");
>>                 goto err_device_add;
>>         }
>>
>> @@ -338,7 +338,7 @@ static int __init oaktrail_init(void)
>>
>>         ret = oaktrail_rfkill_init();
>>         if (ret) {
>> -               pr_warning("Setup rfkill failed\n");
>> +               pr_warn("Setup rfkill failed\n");
>>                 goto err_rfkill;
>>         }
>>
>> --
>> 2.20.1
>>
>

