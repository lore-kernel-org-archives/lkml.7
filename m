Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990FC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7473320B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEGOj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:39:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfEGOj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:39:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A73B7301988B;
        Tue,  7 May 2019 14:39:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDDA917ADD;
        Tue,  7 May 2019 14:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v5.2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506085014.GA130963@gmail.com>
 <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
 <20190506194339.GA20938@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <34c5c50d-cfe7-4b19-e889-62955d286f29@redhat.com>
Date:   Tue, 7 May 2019 10:39:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506194339.GA20938@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 07 May 2019 14:39:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 3:43 PM, Ingo Molnar wrote:
> * Waiman Long <longman9394@gmail.com> wrote:
>
>> On 5/6/19 4:50 AM, Ingo Molnar wrote:
>>> Linus,
>>>
>>> Please pull the latest locking-core-for-linus git tree from:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus
>>>
>>>    # HEAD: d671002be6bdd7f77a771e23bf3e95d1f16775e6 locking/lockdep: Remove unnecessary unlikely()
>>>
>>> [ Dependency note: this tree depends on commits also in the RCU tree, 
>>>   please disregard this pull request if you weren't able to pull the RCU 
>>>   tree for some reason. ]
>>>
>>> Here are the locking changes in this cycle:
>>>
>>>  - rwsem unification and simpler micro-optimizations to prepare for more 
>>>    intrusive (and more lucrative) scalability improvements in v5.3
>>>    (Waiman Long)
>> Is it possible to pull in also my "locking/rwsem: Prevent decrement of
>> reader count before  increment" patch for 5.2? The rests can wait until 5.3.
> Sure - how close is this to a straight:
>
> 	git revert 70800c3c0cc5
>
> ?
>
> If it's close enough then please resubmit this as a 'Revert "..."' patch, 
> which I'll queue up in locking/urgent.
As explained by Linus, it is not a straight revert.
> It also is a performance, not a correctness fix, and should probably get 
> a Cc: stable as well, right?

This patch is not for performance. It is fixing a regression and it does
have a cc: stable tag.

Thanks you for your help as I would like to backport the fix downstream.

Cheers,
Longman

