Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A605C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9632084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDCRIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:08:22 -0400
Received: from foss.arm.com ([217.140.101.70]:45172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCRIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E950780D;
        Wed,  3 Apr 2019 10:08:21 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E763F68F;
        Wed,  3 Apr 2019 10:08:20 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:08:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vdso: fix and clean-up Makefile
Message-ID: <20190403170818.GC17500@fuggles.cambridge.arm.com>
References: <1554281302-21105-1-git-send-email-yamada.masahiro@socionext.com>
 <20190403124438.GH16362@fuggles.cambridge.arm.com>
 <CAK7LNAQ4aabQoMwWZNUEACPC3_SQPdmq+5cAOQD-d+yvXE7Qzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ4aabQoMwWZNUEACPC3_SQPdmq+5cAOQD-d+yvXE7Qzg@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:04:23AM +0900, Masahiro Yamada wrote:
> On Wed, Apr 3, 2019 at 9:45 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Apr 03, 2019 at 05:48:22PM +0900, Masahiro Yamada wrote:
> > > - $(call if_changed,...) must have FORCE as a prerequisite
> > >
> > > - vdso.lds is a generated file, so it should be prefixed with
> > >   $(obj)/ instead of $(src)/.
> >
> > Hmm, this sounds quite alarming! How come out of tree builds seem to work
> > ok without this patch?
> 
> No, I do not mean like that.
> This is just cosmetic (at least for now).
> Kbuild conventionally use both $(obj) and $(src), but
> they are the same in most places.
> If you see the top of scripts/Makefile.build,
> $(src) is the same as $(obj).

Ah thanks, that makes much more sense. I'll queue this up for 5.2.

Will
