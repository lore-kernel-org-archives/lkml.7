Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD7420B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fOzhg0Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfFLTxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:53:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387950AbfFLTxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:53:45 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EBE01EC0997;
        Wed, 12 Jun 2019 21:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560369224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=py1v7DAHn2xf6KNNxQqQyHWoEZd+TXB25zDhYSm/igw=;
        b=fOzhg0HswJxnttpfPW1QgvKgNyknc6mo146RZB0YFzfp7xUjoNf5qSR8i2lkMVk1NwKheQ
        TlMBKEuq9AGdB2cDtDgf9u6fsUfDWat/psrjUX5yDDtKGlF58H9ekPqpJq4ih7rMYl/0G7
        A/8DLNHLKjFbIn9Vs2uqODGdLXY7/G8=
Date:   Wed, 12 Jun 2019 21:53:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Qian Cai <cai@lca.pw>, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/mm: fix an unused variable "tsk" warning
Message-ID: <20190612195339.GR32652@zn.tnic>
References: <1559338641-6145-1-git-send-email-cai@lca.pw>
 <20190612175543.GO32652@zn.tnic>
 <87a7emy8dh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7emy8dh.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 01:19:06PM -0500, Eric W. Biederman wrote:
> Since I am removing the tsk parameter from all of the synchrnous signal
> sending functions, on all of the architectures it was easier to go
> through my own tree than -tip.

Yeah, I remember reading a mail about it...

> The removal of tsk from force_sig_fault is what caused the warning
> in do_sigbus.
> 
> My apologies I was a little slow in getting that patch added and
> generating work for other folks.

That's fine - now we know what the situation is.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
