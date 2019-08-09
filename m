Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D2208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ij6x/fum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405647AbfHIHGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:06:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfHIHGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:06:05 -0400
Received: from zn.tnic (p200300EC2F0BAF001CD97DA1D84759A1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:af00:1cd9:7da1:d847:59a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D01381EC0BED;
        Fri,  9 Aug 2019 09:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565334364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BHFu1Yen1sPSEIzqT1smQQamL9wIyKv6QcXBLQdsNz8=;
        b=Ij6x/fum0mmGlXKg0CNeOmhIESG418I1H5D7YIOqtxiJnpgjSeXaH0FxXumhMV5Sr06rJH
        KpQaJ8KxY+/HQci4lRpbjF0gbW8r6Iya3Xdze6zt6xIoEn8FmpbjmkEjS8j0RTdkmAofoE
        ii82bIBlm5g99l305RsY7Yml3fKS11s=
Date:   Fri, 9 Aug 2019 09:06:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, toshi.kani@hpe.com,
        fei1.li@intel.com
Subject: Re: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Message-ID: <20190809070647.GA2152@zn.tnic>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1565300606.git.isaku.yamahata@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:54:17PM -0700, Isaku Yamahata wrote:
> Make PAT(Page Attribute Table) independent from
> MTRR(Memory Type Range Register).
> Some environments (mainly virtual ones) support only PAT, but not MTRR
> because PAT replaces MTRR.
> It's tricky and no gain to support both MTRR and PAT except compatibility.
> So some VM technologies don't support MTRR, but only PAT.
> This patch series makes PAT available on such environments without MTRR.

And this "justification" is not even trying. Which "VM technologies" are
those? Why do we care? What's the impact? Why do we want this?

You need to sell this properly.

Also, your patches are huge. You'd need to split them sensibly.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
