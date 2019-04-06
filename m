Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCAC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1410D218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PQAUGfW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDFJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:32:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfDFJcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:32:05 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 756C71EC0573;
        Sat,  6 Apr 2019 11:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554543124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nliKl2iyzaMHB1fj8CUzaj32ewAH5fY88MgKXCgGssY=;
        b=PQAUGfW1Vm/sJIeho1TFST8W8KMBh6f/tOMKs8czejwpIc6t8O2fsXW19PWZBPOmOU4BLa
        ipR03V3SkSkZZJNCKc1cvtiZ0KLkSldC2zUOoubhNaN3+vwizXDUFIPxqn4rQrWYfIRcGL
        YZgKTQc5cHGv0iN3UGA5vEYfiS4FmSU=
Date:   Sat, 6 Apr 2019 11:32:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
Message-ID: <20190406093201.GB14245@zn.tnic>
References: <20190405045711.30339-1-bp@alien8.de>
 <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic>
 <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
 <20190405082447.GD23348@zn.tnic>
 <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
 <20190405162527.GP22763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405162527.GP22763@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:25:27AM -0700, Matthew Wilcox wrote:
> I don't think that's a good idea; we should only document functions we
> want other people to use.

Yap.

> I could also go for renaming this to __size_ab_plus_c.

Let's just leave it short as it is now - the comment should be good
enough.

Btw, is anyone picking this up or should I?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
