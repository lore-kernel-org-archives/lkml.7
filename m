Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8E320840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfHMWbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:31:13 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:36753 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfHMWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:31:13 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 18:31:13 EDT
Received: (qmail 3952 invoked by uid 1019); 13 Aug 2019 22:24:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2019 22:24:30 -0000
Date:   Tue, 13 Aug 2019 22:24:30 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Will Deacon <will@kernel.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the arm64
 tree
In-Reply-To: <20190813082422.lecgqtknnn5g4dyj@willie-the-truck>
Message-ID: <alpine.DEB.2.21.999.1908132220450.13287@utopia.booyaka.com>
References: <20190813093447.747a5853@canb.auug.org.au> <20190813082422.lecgqtknnn5g4dyj@willie-the-truck>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Tue, 13 Aug 2019, Will Deacon wrote:

> On Tue, Aug 13, 2019 at 09:34:47AM +1000, Stephen Rothwell wrote:
> > Today's linux-next merge of the risc-v tree got a conflict in:
> > 
> >   arch/arm64/kernel/topology.c
> > 
> > between commit:
> > 
> >   98dc19902a0b ("arm64: topology: Use PPTT to determine if PE is a thread")
> > 
> > from the arm64 tree and commit:
> > 
> >   60c1b220d8bc ("cpu-topology: Move cpu topology code to common code.")
> > 
> > from the risc-v tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks, Stephen.
> 
> Paul, Palmer -- If it's not too late, then it would probably be best to
> stick this commit (60c1b220d8bc) and any dependencies on their own stable
> branch so that we can both pull it into our respective trees and I can
> resolve this conflict in the arm64 tree, which I'll send early during the
> merge window.
> 
> Looking at your tree, I guess I could just pull in
> common/for-v5.4-rc1/cpu-topology if you promise never to rebase it. Failing
> that, you could fork a new branch from 60c1b220d8bc and I could just pull
> that part instead.

How about if we treat common/for-v5.4-rc1/cpu-topology as a stable branch?  
I wasn't planning to rebase it.  Then both of us can just merge it into 
our for-next branches for the merge window?  (It looks like I will need to 
rebuild the riscv for-next branch on top of v5.3-rc5, for unrelated 
reasons.)

Sound reasonable?


- Paul
