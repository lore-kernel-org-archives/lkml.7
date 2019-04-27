Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F366C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F842206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YpXBY7ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfD0IU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:20:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54136 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0IUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:20:25 -0400
Received: from zn.tnic (p200300EC2F1D42004591EACC18991034.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:4200:4591:eacc:1899:1034])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B391E1EC06A7;
        Sat, 27 Apr 2019 10:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556353224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OUBrU38/bdwH6IKEmTFQqICNbpW5PNPRyLYNwtxh2Jo=;
        b=YpXBY7ZDWmgG+yAd8wnUm1d+N17uQoPMeZbt5JlMkcg53KMhoj5xn0vu+q93cqIAVbE+Y0
        uXHnflyEo3E8gVQRUcXIuLyI2fmhW+x1J8PD73mK4oQREgLG69qpZUY0ui4kJPgWR1FfLU
        vHCDrt22G3AxupJmfSNKd7RqCGw9vCs=
Date:   Sat, 27 Apr 2019 10:20:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove various memory encryption exports
Message-ID: <20190427082019.GA12360@zn.tnic>
References: <20190427061935.4876-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190427061935.4876-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 08:19:35AM +0200, Christoph Hellwig wrote:
> None of these is used in modular code, and we should probably try to
> keep it that way.  They can be added back if we really get a legitimate
> modular user.

You're going to love this:

87df26175e67 ("x86/mm: Unbreak modules that rely on external PAGE_KERNEL availability")

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
