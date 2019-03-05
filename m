Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6143C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DABD20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e6Xa6SIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCEI5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:57:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfCEI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:57:11 -0500
Received: from zn.tnic (p200300EC2BCD6B00647FB0CB76B3F976.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:647f:b0cb:76b3:f976])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF72A1EC05DE;
        Tue,  5 Mar 2019 09:57:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551776230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TDMF2fOYsk12jUW+zkEE8boE8T2gVIyf6LaqrSTHNQk=;
        b=e6Xa6SIW6GBE30QdsGH0SH9kXfLlMbf/t5wa1iBLVhjs3Mqf77LPUTQGnyODJL3lqhmUjQ
        vqEzjOKJdwutGEyvEg8xQgLvYV7oMnfZU7mgt5rL3grdIxw5e1SNzpIZ5vQFBJaUe/L7qt
        WELNdh9rztPzMUY1GPk6aiJmrAJy1Ps=
Date:   Tue, 5 Mar 2019 09:57:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nirav =?utf-8?B?RGF2w6k=?= <niravd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/boot: clean up headers
Message-ID: <20190305085707.GA8256@zn.tnic>
References: <20190305095100.243a40e3@canb.auug.org.au>
 <20190305001221.31343-1-ndesaulniers@google.com>
 <CAKwvOdmCnwcUCNT0q=+g9sjTdg_tv3WMC6wWyOhkzDPqFMUhbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmCnwcUCNT0q=+g9sjTdg_tv3WMC6wWyOhkzDPqFMUhbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:15:49PM -0800, Nick Desaulniers wrote:
> Well, should have cut that out of the commit message too in V3...sigh.
> Boris assuming everyone's ok with this patch; can you just drop this
> sentence from the commit message should you apply the patch (or shall
> I send a v4)?

I'll take a look once the merge window is over and all the dust settles.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
