Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78CEC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9B021848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BbVfEcGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfIEJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:15:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733117AbfIEJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:15:22 -0400
Received: from zn.tnic (p200300EC2F0A5F00AD0514FFC49C0308.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:ad05:14ff:c49c:308])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2096C1EC06F3;
        Thu,  5 Sep 2019 11:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567674921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FQa5pOo72S+jI4zr4GX6frwocxhPc2IhNcrD8ofhhsY=;
        b=BbVfEcGXDpQTPBcoxho2/6tKzLda03FGu3HD/5JwTOkwpf1zM6xZNKd550+fk0gH2lKQvM
        2cBe2xQZysVlippdBHUBYN0P84GqTbwW/+kdPhL/kCnizUytm8PO1D6lNZ0fs1zGzI8sCI
        +qXgajKfc9UQkllr23LyP8si42bqWYU=
Date:   Thu, 5 Sep 2019 11:15:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, vaibhavrustagi@google.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
Message-ID: <20190905091514.GA21479@zn.tnic>
References: <20190904214505.GA15093@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904214505.GA15093@swahl-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 04:45:05PM -0500, Steve Wahl wrote:
> The last change to this Makefile caused relocation errors when loading
> a kdump kernel.

How do those relocation errors look like?

What exactly caused those errors, the flags removal from
kexec-purgatory.o?

Because this is the difference I can see from

b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS")

Or is it something else?

Can we have the failure properly explained in the commit message pls?

> This change restores the appropriate flags, without

You don't have to say "This change" in the commit message - it is
obvious which change you're talking about. Instead say: "Restore the
appropriate... "

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
