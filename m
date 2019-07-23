Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF963C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2022166E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfGWGKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:10:14 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:39508 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388040AbfGWGKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:10:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXbg848_1563862209;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXbg848_1563862209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:10:09 +0800
Subject: Re: [PATCH v3 1/2] cputime: remove duplicate code in
 account_process_tick
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190722073840.32613-1-alex.shi@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ed371595-b5b8-5376-5962-f2a2e91be12d@linux.alibaba.com>
Date:   Tue, 23 Jul 2019 14:10:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722073840.32613-1-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Forget this patchset. I sent out a new 3 patches.

Thanks
Alex


ÔÚ 2019/7/22 ÏÂÎç3:38, Alex Shi Ð´µÀ:
> The irqtime_account_process_tick path was introduced for precise ns irq
> time account from commit abb74cefa9c6 ("sched: Export ns irqtimes
> through /proc/stat") while account_process_tick still use jiffes. This
> divide isn't necessary especially now both paths are ns precison.
> 
> Move out the irqtime_account_process_tick func from IRQ_TIME_ACCOUNTING.
> So it do generally same things as account_process_tick whenever if
> IRQ_TIME_ACCOUNTING set or if sched_clock_irqtime enabled.
