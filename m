Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B0720645
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QK21Zj2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDZNCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:02:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfDZNCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:02:32 -0400
Received: from zn.tnic (p200300EC2F0E4E004141C902DE160BE6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4e00:4141:c902:de16:be6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 146C71EC013F;
        Fri, 26 Apr 2019 15:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556283751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SeqUH0ApPS7hCTYZawRmDe1N0ubx1v5dXTbQHMRxXAw=;
        b=QK21Zj2eeaOW3nnW6N9hqPZd2FZoZ3IAZ0s72LS1lAr+B+Lh9NzM/oKefBcUtcQhkazk9F
        NcSuVvpvPy8Roi5K7L2BhmerTNmvTgsE5u6ogt6CuJ174YOM7fPIIHnMESkJ0T85Y34GJq
        XmOcaJ4ueRvyaNJR/OrNTwqJk/hc1Tw=
Date:   Fri, 26 Apr 2019 15:02:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
Message-ID: <20190426130226.GE4608@zn.tnic>
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com>
 <20190402103201.GF6826@zn.tnic>
 <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:59:54AM +0800, lijiang wrote:
> Hope this help. Thanks.

It does help, yes. When this explanation above is part of the commit
message, it helps immensely!

:-)

> So sorry for the delay, i am trying my best to explain it in detail.

I don't care about the delay as long as the commit messages properly
explain why the change is needed.

So thanks for doing that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
