Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD99C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6821556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GYSMAXPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLKVi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:38:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLKVi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:38:26 -0500
Received: from zn.tnic (p200300EC2F094900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 097A21EC0AE5;
        Wed, 11 Dec 2019 22:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576100305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGkiTVcUk+NEM/wd8hG815hjBGSpOCVVcvQQq81PWjc=;
        b=GYSMAXPKMJ36gvKjQCLlWTRHWc8/0fZXwLgs7FsJm55/KH8Gd484YmAtF7sI+OwE9l/ZAJ
        8RuCK+j8wzrNWny9O7o5etcz8pd4RRWyTD6X6k0S7wFinKugWiXCY46n0+wgzP1kD4X2oq
        91eE3Zro+RhHh7MUEhi91q8q1vW/xpc=
Date:   Wed, 11 Dec 2019 22:38:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: make stub function static inline
Message-ID: <20191211213819.GG14821@zn.tnic>
References: <52170.1575603873@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52170.1575603873@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:44:33PM -0500, Valdis Klētnieks wrote:
> When building with C=1 W=1, both sparse and gcc complain:
> 
>   CHECK   arch/x86/kernel/cpu/microcode/core.c
> ./arch/x86/include/asm/microcode_amd.h:56:6: warning: symbol 'reload_ucode_amd' was not declared. Should it be static?
>   CC      arch/x86/kernel/cpu/microcode/core.o
> In file included from arch/x86/kernel/cpu/microcode/core.c:36:
> ./arch/x86/include/asm/microcode_amd.h:56:6: warning: no previous prototype for 'reload_ucode_amd' [-Wmissing-prototypes
> ]

Hmm, I don't see this with gcc 9.2 and sparse 0.6.1 here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
