Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC41C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E66D2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IBtIjL4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfFRJhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:37:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfFRJhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:37:39 -0400
Received: from zn.tnic (p200300EC2F07D6004142CF2FAC564D4B.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d600:4142:cf2f:ac56:4d4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C39E1EC0249;
        Tue, 18 Jun 2019 11:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560850658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KR5XOgtOR1Y9OY2GsmPtNNKKqA765DvHq6Cuv1heUKI=;
        b=IBtIjL4UroCJLdiy8aNoxV39Vr7ZRkpkZfMr84zCuFNj1r8iG362RypuUNNwmRON7lv4iI
        S8EDTEdbTQTTsoN0PnizPRPyQ2D6J/pCGsg6/dfU1T9untAbT325t3Y7VMwo0FfZRuwdWL
        46ZfbyE0QAtIsu7CM+2ThTu6xWdXnII=
Date:   Tue, 18 Jun 2019 11:37:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190618093730.GA5629@zn.tnic>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
 <20190617104740.GG27127@zn.tnic>
 <7a35c79d-370e-5595-234e-0aafc527331b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a35c79d-370e-5595-234e-0aafc527331b@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:43:00AM +0000, Lendacky, Thomas wrote:
> Yes and no...  it doesn't say how it is done, namely through the use of
> memblock_reserve() calls and when and where those occur.

Ah ok, so you found that out and documented it now. Good.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
