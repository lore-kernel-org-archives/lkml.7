Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1FAC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E12187F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q1UVP4/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfHRUie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:38:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRUie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:38:34 -0400
Received: from zn.tnic (p200300EC2F259C00DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:9c00:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED40A1EC072D;
        Sun, 18 Aug 2019 22:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566160713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jmo8zNG4hlwL3nnXrc7gFWNpsh16djhvhsi9IbsTGM8=;
        b=Q1UVP4/Oux92wG1Up1sSvrHwtRc3CpsEJVvqxC6Yv5Glk272x3HW2clwRevU2lYhQzeSH3
        4cnr8aNZQyW9Ba22ut+XsDizEMXzS4GXBGqxRKaMdwnINCdx8zW40cR4+cz3SWreannJRp
        S1MFJexRxtMW2TvXwX0Vum0oxXzP7hw=
Date:   Sun, 18 Aug 2019 22:39:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190818203915.GD29353@zn.tnic>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190818201942.GC29353@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190818201942.GC29353@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 10:19:42PM +0200, Borislav Petkov wrote:
> #define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* "" VMware prefers VMCALL hypercall instruction */

And you can call that one something generic too: X86_FEATURE_VMCALL.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
