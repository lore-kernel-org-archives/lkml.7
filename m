Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC01C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC72067C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lx+SAFNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDZKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:04:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48988 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfDZKEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:04:43 -0400
Received: from zn.tnic (p200300EC2F0E4E00083B53278C752809.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4e00:83b:5327:8c75:2809])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C625A1EC0380;
        Fri, 26 Apr 2019 12:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556273081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=auPB1WPrdnNiit8/jBeISgz2+faVgg7bplqJPpgozAw=;
        b=Lx+SAFNTKBvij+WocoOvv7amFC96vx2dzt3Ha48Ih/UMVywEHJN0Ai/UKEBhXK/xxR47x4
        aq8odr2rZcjNHL/BXFKuQyiYXcEAZQ0GcXGBH8G6gCoSnUGLjEZsenAifcV+Un2x9UVSm3
        aMVhciwtWZG/UszNZQFeVEWV5kgsdSw=
Date:   Fri, 26 Apr 2019 12:04:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     keescook@chromium.org, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        thgarnie@google.com, herbert@gondor.apana.org.au,
        mike.travis@hpe.com, frank.ramsay@hpe.com,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190426100441.GC4608@zn.tnic>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190415194755.GJ29317@zn.tnic>
 <20190426092348.GO3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426092348.GO3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 05:23:48PM +0800, Baoquan He wrote:
> I sent private mail to Kirill and Kees. Kirill haven't replied yet, he
> could be busy with something else as he doesn't show up recently on
> lkml.

I don't understand what the hurry is?

The merge window is imminent and we only pick obvious fixes. That
doesn't qualify as such, AFAICT.

> Kees kindly replied, and said he couldn't find this mail thread. He told
> I can add his Reviewed-by, as he has acked this patchset in v2
> thread. I just updated later to tune log and correct typos.
> http://lkml.kernel.org/r/CAGXu5j+o4aSx9mMDJqTMOp-VrvWes-2YEwR1f29z8dm0rUfzGQ@mail.gmail.com

Yes, when you get Reviewed-by:'s or other tags from reviewers, you
*add* them to your next submission when the patch doesn't change in
non-trivial fashion. You should know that...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
