Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD66C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfDDRQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfDDRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24DE786678;
        Thu,  4 Apr 2019 17:16:22 +0000 (UTC)
Received: from treble (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C0B80FE;
        Thu,  4 Apr 2019 17:16:20 +0000 (UTC)
Date:   Thu, 4 Apr 2019 12:16:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Apr 3 (objtool)
Message-ID: <20190404171618.6u36y5zu3euvd4zp@treble>
References: <20190403192407.13a99513@canb.auug.org.au>
 <d37e0909-cacc-7c6c-4376-33891fa69f53@infradead.org>
 <20190403205305.tqqwttjytunzgtub@treble>
 <6a2455b9-5c02-99dc-e41c-e6b7d1c3118d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a2455b9-5c02-99dc-e41c-e6b7d1c3118d@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 04 Apr 2019 17:16:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:29:17PM -0700, Randy Dunlap wrote:
> On 4/3/19 1:53 PM, Josh Poimboeuf wrote:
> > On Wed, Apr 03, 2019 at 08:02:43AM -0700, Randy Dunlap wrote:
> >> On 4/3/19 1:24 AM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20190402:
> >>>
> >>
> >> on x86_64:
> >>
> >> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x909: unreachable instruction
> > 
> > Your .o file looks odd.  I can't recreate the issue when I build the
> > same object.
> 
> This (randconfig) build has tracing enabled?  Could that have anything to do
> with it?

No, I can't see any reasonable explanation for it other than a buggy
toolchain.

> The randconfig file is attached.

I still can't recreate with your randconfig.

> > Did the issue only just now show up?  Can you bisect it?  What version
> > of binutils are you using?
> 
> > ld -v
> GNU ld (GNU Binutils; openSUSE Leap 42.3) 2.31.1.20180828-19
> 
> 
> My build logs show it first occurred (in my randconfig builds) in
> linux-next-20190204.

It seems really odd.  Can you do a bisect?

-- 
Josh
