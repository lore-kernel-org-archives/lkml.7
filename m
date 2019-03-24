Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15054C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D7620811
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jw4U1Pof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfCXVcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:32:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXVcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:32:36 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4D901EC082D;
        Sun, 24 Mar 2019 22:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553463155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oGDLmf5WFfLXG1Ix6w4r5S8DaE6qXVPzNkgC811/6fM=;
        b=jw4U1Pofs6TgLvSCx23Dv2arp8f1ZyfH/tbKEGd6nWVtFwnKmsksycUzJSyWBhs4j5OPE1
        22DqjNZGhycM+/rGfOc9IlCOu2ktg99BKoI44L/b82fvpr9IhlVwR1CpslRNpTInV9wo0T
        d4hhoVhhI2yPZTGjao3vfeEV7eiJDK8=
Date:   Sun, 24 Mar 2019 22:32:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86, putuser: add ASM_CALL_CONSTRAINT
Message-ID: <20190324213048.GK23289@zn.tnic>
References: <20190316210127.GA21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190316210127.GA21830@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 12:01:27AM +0300, Alexey Dobriyan wrote:
> Clobber stack pointer given that assembly does CALL.

Clobber?

Comment over ASM_CALL_CONSTRAINT talks about something else.

Also, pls change all your subject prefixes to

"x86/uaccess: ..."

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
