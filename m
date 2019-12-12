Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0EBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4929920663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NbknARQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfLLKtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:49:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfLLKtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:49:10 -0500
Received: from zn.tnic (p200300EC2F0A5A00E16017ED12C324A2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:e160:17ed:12c3:24a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACE191EC0CDE;
        Thu, 12 Dec 2019 11:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576147748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EPfoLb9lKUcjdPu39+KMYmEH9Hw//YBrthz+icR0AW0=;
        b=NbknARQrx9uwKvhOR2kLMiCNaD8FQXkGP0lG0YjOJTQzJFnkIgNHRn0NfJJAgAMpGS+/l/
        JXUUef0ivZdP6+1mahsF6HrQjdF1nbul1u1ReaCUptVvdSdbGrsK/T8GjZOjl5DgjOc0/q
        0do1y5Ea1ho0sO80VeenI8J5ccSzpdA=
Date:   Thu, 12 Dec 2019 11:49:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: make stub function static inline
Message-ID: <20191212104902.GC4991@zn.tnic>
References: <52170.1575603873@turing-police>
 <20191211213819.GG14821@zn.tnic>
 <186227.1576107233@turing-police>
 <20191212085757.GA4991@zn.tnic>
 <20191212100609.hadfiiivm62obyfc@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212100609.hadfiiivm62obyfc@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:06:09AM +0100, Luc Van Oostenryck wrote:
> The Sparse warning about reload_ucode_amd() is only present if your
> config has CONFIG_MICROCODE_AMD not set.

Ha, of course. Otherwise it doesn't see the

void reload_ucode_amd(void) {}

declaration.

Thanks for pointing this out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
