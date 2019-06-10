Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB08C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CF7206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kZvnhNOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfFJLYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:24:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbfFJLYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:24:37 -0400
Received: from zn.tnic (p200300EC2F052B00DC69C02FEF5E8A62.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:dc69:c02f:ef5e:8a62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AC991EC058B;
        Mon, 10 Jun 2019 13:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560165876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ah8te1umBfDARXJum2UBL7IkROuTWyGRC83CORZOQPc=;
        b=kZvnhNOLKQUZDEgg8h6ue3KRJPUeSo1yM9LyFvufiadt02+CLDjUlQtbz9ZORrvrGtQKue
        fPHdQq8SRGk8iwNVjoDt9WXg5PSems6Uz1RGMvZh+X1IyHwqw5Z+nOp1UbayFeyW8AXASP
        9sKfokWBhR1b87y9kN1sM5rqSYjNnBo=
Date:   Mon, 10 Jun 2019 13:24:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Message-ID: <20190610112431.GC5488@zn.tnic>
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
 <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
 <20190610105959.GB5488@zn.tnic>
 <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 11:07:05AM +0000, Junichi Nomura wrote:
> I had tested the version I posted here on bunch of physical machines
> I had access and confirmed it didn't broke working setups:
> https://lore.kernel.org/lkml/20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp/
> 
> Since the logic in the patch seems unchanged, I'm very sure it's ok.

Ok, thanks for testing.

I'll add your Tested-by.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
