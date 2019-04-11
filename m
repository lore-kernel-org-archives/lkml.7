Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07863C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D156F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDKHLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:11:15 -0400
Received: from mx.socionext.com ([202.248.49.38]:31638 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKHLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:11:15 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Apr 2019 16:11:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id C0DF16117D;
        Thu, 11 Apr 2019 16:11:13 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 11 Apr 2019 16:11:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 805A340372;
        Thu, 11 Apr 2019 16:11:13 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 685B4120487;
        Thu, 11 Apr 2019 16:11:13 +0900 (JST)
Subject: Re: [PATCH 0/3] Bugfix and cleanup the timer driver for Milbeaut M10V
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <30226b29-bee5-6410-6ddc-5943c834dc15@socionext.com>
Date:   Thu, 11 Apr 2019 16:11:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is ping..
Does anyone have any comments?


On 2019/03/25 12:05, Sugaya Taichi wrote:
> This series fixes a bug and cleanup code about timer driver for
> Milbeaut M10V.
> Since it is difficult to separate, it is integrated into a series.
> 
> Sugaya Taichi (3):
>    clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
>    clocksource/drivers/timer-milbeaut: Add shutdown function
>    clocksource/drivers/timer-milbeaut: Cleanup common register accesses
> 
>   drivers/clocksource/timer-milbeaut.c | 66 +++++++++++++++++++++++++-----------
>   1 file changed, 47 insertions(+), 19 deletions(-)
> 

