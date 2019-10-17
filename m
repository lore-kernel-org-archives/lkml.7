Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C0ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281A72082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437155AbfJQNwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:52:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730412AbfJQNwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:52:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0412B50D;
        Thu, 17 Oct 2019 13:52:30 +0000 (UTC)
Date:   Thu, 17 Oct 2019 15:52:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Whitcroft <apw@canonical.com>,
        "DavidS. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
Message-ID: <20191017135229.a4mvcyap6l34m5bk@pathway.suse.cz>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
 <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
 <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
 <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-10-17 21:29:55, Kefeng Wang wrote:
> 
> 
> On 2019/10/17 21:05, Petr Mladek wrote:
> > On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
> >> Hi all,
> >>
> >> On 2019/10/2 16:55, Petr Mladek wrote:
> >>> Linus,
> >>>
> >>> On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
> >>>> There are pr_warning and pr_warng to show WARNING level message,
> >>>> most of the code using pr_warn, number based on next-20190919,
> >>>>
> >>>> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
> >>>
> >>> The ratio is 10:1 in favor of pr_warn(). It would make sense
> >>> to remove the pr_warning().
> >>>
> >>> Would you accept pull request with these 32 simple patches
> >>> for rc2, please?
> >>>
> >>> Alternative is to run a simple sed. But it is not trivial
> >>> to fix indentation of the related lines.
> >>
> >> Kindly ping, should I respin patches with comments fixed?
> >> Is the patchset acceptable, hope to be clear that what to do next :)
> > 
> > I am going to check how many conflicts appeared in linux-next.
> > 
> > If there are only few then I'll take it via printk.git. This way
> > we get proper indentation and other changes.
> 
> There are some conflicts(not too much), and I have already rebased
> on next-20191017 with comment fixed, added Reviewed-by/Acked-by.
> I could resend them ASAP if necessary.

OK, resend them, please.

> > If there are too many conflicts then I'll ask Linus to do a mass
> > change using a script.
> 
> For tools parts(api/bpf/perf, patch [29-31]), it renames pr_warning
> to pr_warn, and make manually changes in some place, simply 'sed'
> maybe not enough.

Yup.

Best Regards,
Petr
