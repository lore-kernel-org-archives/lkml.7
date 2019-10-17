Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB57FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0620640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394102AbfJQNFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbfJQNFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD714AFC1;
        Thu, 17 Oct 2019 13:05:51 +0000 (UTC)
Date:   Thu, 17 Oct 2019 15:05:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "DavidS. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
Message-ID: <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
 <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
> Hi all,
> 
> On 2019/10/2 16:55, Petr Mladek wrote:
> > Linus,
> > 
> > On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
> >> There are pr_warning and pr_warng to show WARNING level message,
> >> most of the code using pr_warn, number based on next-20190919,
> >>
> >> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
> > 
> > The ratio is 10:1 in favor of pr_warn(). It would make sense
> > to remove the pr_warning().
> > 
> > Would you accept pull request with these 32 simple patches
> > for rc2, please?
> > 
> > Alternative is to run a simple sed. But it is not trivial
> > to fix indentation of the related lines.
> 
> Kindly ping, should I respin patches with comments fixed?
> Is the patchset acceptable, hope to be clear that what to do next :)

I am going to check how many conflicts appeared in linux-next.

If there are only few then I'll take it via printk.git. This way
we get proper indentation and other changes.

If there are too many conflicts then I'll ask Linus to do a mass
change using a script.

I am sorry for late reply. I have never pushed such a mass change.
I hoped that anyone more experienced will provide some opinion ;-)

Best Regards,
Petr
