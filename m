Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A377C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6F2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qXK/xH1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfD1KDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:03:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfD1KDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:03:18 -0400
Received: from zn.tnic (p200300EC2F259800C9269D51E7686BB3.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:9800:c926:9d51:e768:6bb3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE3131EC0A99;
        Sun, 28 Apr 2019 12:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556445797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BkN+81qJhjEL0fEOxLh9ql9Vh6kkvXEmZSQ0d9MLr4k=;
        b=qXK/xH1ko8zi9c7LkTPefiT0A0DQ2yZGEDTXTDXd69/nyvNR9zVW20YgluQp5+0L3lvEie
        Ih06LtstT0RYkqRMZTZHUDBcL/ndViE5mdR7f0B5cqzLnIxtI2VC3FcIdqTR5fpHBD/ez3
        YsLZe+vmYCplHiGdgtCXmC7jcftFnJo=
Date:   Sun, 28 Apr 2019 12:03:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190428100309.GA2334@zn.tnic>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
 <20190427085816.GB12360@zn.tnic>
 <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 09:56:35AM +0800, Zhao, Yakui wrote:
> Thanks for the reminder about the access width.
> It is 64-bit register. What I said is the "movq", not "movl".
> (I understand that movl is incorrect for 64-bit register).

I didn't say anything about movl. I think what you're trying to say is
that because your inputs like hcall_id and param1/2 are unsigned longs,
you want a 64-bit move.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
