Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEBAC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC03D21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="THNzId3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgABKBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:01:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgABKBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:01:34 -0500
Received: from zn.tnic (p200300EC2F00E700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 727051EC02FE;
        Thu,  2 Jan 2020 11:01:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577959293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=maDj4h+HahgtslAbCIK0Uoo902uNLg7RsleRmS1ioo4=;
        b=THNzId3fRIdEwTBZ+97XOQdhFYzSz2t4qnHvetvr9mxvFi9AouEabYdtdJ6qQfXqRHHN62
        dC6ND+h1uAsK291eocO+jMQDfr9g2X8DM9wvoM0zW7BR1O4V56WU9yjjfdTq4Mv3a5pNP6
        R36sM7fIukuD21lDjyPWzEFg3JKgWwc=
Date:   Thu, 2 Jan 2020 11:01:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
Message-ID: <20200102100125.GC8345@zn.tnic>
References: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
 <498AAA9C-4779-4557-BBF5-A05C55563204@amacapital.net>
 <20200102092733.GA8345@zn.tnic>
 <20200102094946.3vtwrvxcyohlqoxh@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200102094946.3vtwrvxcyohlqoxh@box.shutemov.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 12:49:46PM +0300, Kirill A. Shutemov wrote:
> Caller can indicate the bitness directly. It's always 32-bit for UMIP and
> get_seg_base_limit() can use insn->x86_64.

You can always send patches.

Just don't "fix" it for the sake of fixing it and the "cleanup" should
really be a cleanup not just converting it to something else. Oh, and
you need to test it too...

But you know all that. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
