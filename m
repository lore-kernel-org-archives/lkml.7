Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D79C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69A620651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qx3jZnMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfC2N5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:57:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41144 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfC2N5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:57:07 -0400
Received: from zn.tnic (p200300EC2F148A00C1243160B4274091.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c124:3160:b427:4091])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70261EC05A6;
        Fri, 29 Mar 2019 14:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553867826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U0WZGyd/5IklJVe3sv4mhTo8yGw9sEIuMYXwOUK3BUw=;
        b=Qx3jZnMS3giW9STxziJJ6b7dfywYLqBl9dIvlE8ARNN03TcIgzvs99bHEeVHPR1ba+1d7F
        iZnVXWqKOcP5t55VoHaiI0Ul+IUk8t6KVEDAT1u5gN84ov6Wwe6P7MH+7irMFVYpfK+ibH
        hta0x9DhmZVmTeK+u8h0DB+BNbnXJsA=
Date:   Fri, 29 Mar 2019 14:57:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number
Message-ID: <20190329135708.GF21152@zn.tnic>
References: <20190328230939.15711-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328230939.15711-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number

For the future:

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

I've fixed it up now.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
