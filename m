Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD50C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1532082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfDLMeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:34:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:48871 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLMeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:34:46 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Apr 2019 21:34:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5A7E7180C0E;
        Fri, 12 Apr 2019 21:34:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 12 Apr 2019 21:34:45 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1D1561A04E1;
        Fri, 12 Apr 2019 21:34:45 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0BA6B120487;
        Fri, 12 Apr 2019 21:34:45 +0900 (JST)
Subject: Re: [PATCH v2 0/3] Bugfix and cleanup the timer driver for Milbeaut
 M10V
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1555054611-23566-1-git-send-email-sugaya.taichi@socionext.com>
 <2b6c5bad-485e-657d-e5fe-17fb6281041e@linaro.org>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <5a58fdda-ada9-09bb-6d82-2e636f47df08@socionext.com>
Date:   Fri, 12 Apr 2019 21:34:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2b6c5bad-485e-657d-e5fe-17fb6281041e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/04/12 20:09, Daniel Lezcano wrote:
> On 12/04/2019 09:36, Sugaya Taichi wrote:
>> This series fixes a bug and cleanup code about timer driver for
>> Milbeaut M10V.
>> Since it is difficult to separate, it is integrated into a series.
>>
>> Changes from v1:
>>   -Add "Fixes" tag.
>>
>> Sugaya Taichi (3):
>>    clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
>>    clocksource/drivers/timer-milbeaut: Add shutdown function
>>    clocksource/drivers/timer-milbeaut: Cleanup common register accesses
>>
>>   drivers/clocksource/timer-milbeaut.c | 66 +++++++++++++++++++++++++-----------
>>   1 file changed, 47 insertions(+), 19 deletions(-)
> 
> Series applied for 5.2
> 
> Thanks
> 
>    -- Daniel
> 
> 

Thank you!

