Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D4C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214220873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfGSLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfGSLiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:38:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BADE0307D85B;
        Fri, 19 Jul 2019 11:38:08 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6F45C1A1;
        Fri, 19 Jul 2019 11:38:08 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190718113346.GA19574@linux-8ccs>
 <CAHk-=whjTFKB3TPPkgCvMX9P+C=hy2ZjhQy7C5reTQKV6MtuOw@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <e6fec7b7-40de-884e-a37b-f60dcc129c02@redhat.com>
Date:   Fri, 19 Jul 2019 07:38:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whjTFKB3TPPkgCvMX9P+C=hy2ZjhQy7C5reTQKV6MtuOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 19 Jul 2019 11:38:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/19 3:20 PM, Linus Torvalds wrote:
> On Thu, Jul 18, 2019 at 4:33 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Modules updates for v5.3
>>
>> - Fix bug where -EEXIST was being returned for going modules
> 
> Hmm.
> 
> I have pulled this, but this change makes me a bit nervous.
> 
> I have this dim memory of us having deadlocks in module loading
> because module loading triggered other modules to be loaded, and we
> had circular dependencies..
> 

Interesting.  I'll try to search around to see if I can find the thread.

P.

> This is from years and years ago (that whole state check is not
> recent), so my memory may simply be wrong, but I thought I'd mention
> it...
> 
>                    Linus
> 
