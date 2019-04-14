Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA5DC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0B2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ai6QHIky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDNO3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:29:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNO3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 10:29:31 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63AA31EC0104;
        Sun, 14 Apr 2019 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555252169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0tP6hoqtQENoly861EN4P78bPYJcM/3W36gOx1YTfWw=;
        b=Ai6QHIkyw2+/p1QNjJ0JSEz5HX+07Bkj/1NoSgV8QMZclo819VtGsPRNCr9/nRJejMd12r
        jlod7Ujap5RMfGuMyu0ATt4c7LJodVRyjOmaYD6czyFJv0xYsl/mQWwq2/nCKynWzcv7hI
        VKyuCuGiLsz/5jx9wTrWhbH8DpgCQj0=
Date:   Sun, 14 Apr 2019 16:27:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [1/3] x86: Update DEBUG_TLBFLUSH options description.
Message-ID: <20190414142709.GA569@zn.tnic>
References: <20190410224449.10877-1-atish.patra@wdc.com>
 <20190410224449.10877-2-atish.patra@wdc.com>
 <20190411065617.GA29422@infradead.org>
 <580d95d1-224f-a372-c656-1d2cbb19d868@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580d95d1-224f-a372-c656-1d2cbb19d868@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:14:54PM -0700, Atish Patra wrote:
> On 4/10/19 11:56 PM, Christoph Hellwig wrote:
> > Given that this option enables generic code (which you reuse for RISC-V
> > later in this series) please also move the config option to
> > mm/Kconfig, proabbly keyed off another ARCH_HAVE_DEBUG_TLBFLUSH
> > symbol that the architecture can select.
> > 
> 
> Sure.

And when you do that, instead of deleting the help text, make it
generic. Otherwise, there's no explanation anymore, how that option is
supposed to be used through tlb_flushall_shift.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
