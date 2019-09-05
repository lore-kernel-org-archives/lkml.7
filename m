Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CDC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF752070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfIEFDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIEFDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:03:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 124C3AEC4;
        Thu,  5 Sep 2019 05:03:16 +0000 (UTC)
Date:   Wed, 4 Sep 2019 22:03:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190905050308.mfgiha2y2wydxwtx@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
 <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
 <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
 <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
 <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Michel Lespinasse wrote:

>Hi Davidlohr,
>
>On Wed, Sep 4, 2019 at 5:52 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>> Ok, so for that I've added the following helper which will make the
>> conversion a bit more straightforward:
>>
>> #define vma_interval_tree_foreach_stab(vma, root, start)
>>        vma_interval_tree_foreach(vma, root, start, start)
>
>Yes, that should help with the conversion :)
>
>> I think this also makes sense as it documents the nature of the lookup.

Because this is a nice helper regardless of the interval tree stuff, I went
ahead and sent a patch as well as the conversion, which is quite trivial,
and hopefully akpm can pick it up for -next; which makes one less patch
to carry when doing the interval tree conversion series.

Thanks,
Davidlohr
