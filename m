Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5101C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF6C2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="D4rmrg3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfC3LJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:09:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56014 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfC3LJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:09:31 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B877B1EC08EF;
        Sat, 30 Mar 2019 12:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553944170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a3pWCpuP9rG+l4QvfzsLnn6oAnxhNpPSshux0qU4usw=;
        b=D4rmrg3+IOYqao+STaeDHQ9O4XW/SQr9p9UBYiB9aarV3aBPuulLdDPV0qJX7/R5uewpWB
        8D+zfHlNlF0+MgjuEMj6STJCbo0bV9z1u5boAzEKfTAQNIYuQ4R6HdLhUR1D2pEtbHokvm
        NaTEo+nctj01oPuUfeWWhwRFgK8iz1o=
Date:   Sat, 30 Mar 2019 12:09:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: INFO: rcu detected stall in corrupted (3)
Message-ID: <20190330110933.GC5935@zn.tnic>
References: <000000000000b08190058543449f@google.com>
 <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
 <daec0343-b905-f483-602b-9c0b9e9b1379@i-love.sakura.ne.jp>
 <20190330104529.GB5935@zn.tnic>
 <77650d72-e2ec-e084-c929-210b16b8afb9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77650d72-e2ec-e084-c929-210b16b8afb9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 07:57:50PM +0900, Tetsuo Handa wrote:
> Yes. But what such threshold be? 0.1 second? 1 second? 10 seconds?
> Can we find a threshold where everyone can agree on?

This is what we do all day on lkml: discussing changes so that (almost)
everyone is happy with them.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
