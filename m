Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5703C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020F21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDXOQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:16:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfDXOQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:16:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D5880D;
        Wed, 24 Apr 2019 07:16:38 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B3A3F5AF;
        Wed, 24 Apr 2019 07:16:33 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:16:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
Message-ID: <20190424141631.GH14829@fuggles.cambridge.arm.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Apr 16, 2019 at 09:26:13PM +0200, Thomas Gleixner wrote:
> On Fri, 12 Apr 2019, Josh Poimboeuf wrote:
> 
> > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> > v2, and Speculative Store Bypass.
> > 
> > The default behavior is unchanged.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > NOTE: This is based on top of Jeremy Linton's patches:
> >       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com
> 
> So I keep that out and we have to revisit that once the ARM64 stuff hits a
> tree, right? I can have a branch with just the 4 first patches applied
> which ARM64 folks can pull in when they apply Jeremy's patches before te
> merge window.

I'm assuming that this refers to the core/speculation branch in tip:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/speculation

but please can you confirm that I'm good to pull that into arm64?

Cheers,

Will
