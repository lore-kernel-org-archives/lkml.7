Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8659721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OF6Q1o0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfCVRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:16:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfCVRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:16:31 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB2341EC045C;
        Fri, 22 Mar 2019 18:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553274989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WqsIUsl+if7U1/hb25/XqokbuPCLS8mEFxCUJ5S7Bf0=;
        b=OF6Q1o0hZ0cTU5vxxWRlrnEwH9FlGJkuO1G35eXcBXnRPILeuGHg3E3RdinyHMCGLgJ+0R
        4qAJnaHh4xwsg17LnhtTjacTzAavj+DAjI023aKOANusiTB9Mg5MgrU9pFw0XSDR0FCdH2
        d2UoNpNSgPzOk9kWs6Jz76Ug4ptCPmc=
Date:   Fri, 22 Mar 2019 18:16:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190322171632.GI12472@zn.tnic>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 12:19:01AM +0800, Pu Wen wrote:
> > Sounds to me like you're programming the initial APIC ID not
> > the same way as AMD do...
> 
> In the same way.

So why do you need to do something different than what AMD does?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
