Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7AC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9767221734
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zl0Ymspj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfIHHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 03:22:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfIHHWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 03:22:55 -0400
Received: from zn.tnic (p200300EC2F2BAF0051BF1FB1AFF5BFE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f2b:af00:51bf:1fb1:aff5:bfe4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A4271EC0688;
        Sun,  8 Sep 2019 09:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567927370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2RnWpWREaSxvaBqTRRxv2hxkUN7nSvhHhcOLjCjCccE=;
        b=Zl0YmspjUUX6G3T9Il6zj/CSlO6t4GPGD58T/PSKJ2MDTFV48JTw5iOhkkEr0eAKqUZX3b
        8XWhTlMV/97H4SdOkEajiLzQybrJx6UB2hGO9AipxH1+8uH42qu+Tojc12QJERtvjusP+j
        ycV3w/e2j5R7DEPiC7vFAAGOLZoIPo0=
Date:   Sun, 8 Sep 2019 09:22:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
Message-ID: <20190908072248.GB16220@zn.tnic>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
 <20190907212610.GA30930@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907212610.GA30930@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 02:26:10PM -0700, Ricardo Neri wrote:
> > Wine users have encountered a number of 64-bit Windows games that use
> > these instructions (particularly sgdt), and were crashing when run on
> > UMIP-enabled systems.
> 
> Emulation support for 64-bit processes was not initially included
> because no use cases had been identified.

AFAIR, we said at the time that 64-bit doesn't need it because this is
legacy software only and 64-bit will get fixed properly not to use those
insns. I can probably guess how that went ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
