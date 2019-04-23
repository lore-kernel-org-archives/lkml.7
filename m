Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2AF20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zg9ysvyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfDWPSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:18:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDWPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:18:07 -0400
Received: from zn.tnic (p200300EC2F10CC00CD06C04685BA476A.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:cc00:cd06:c046:85ba:476a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E77E1EC0235;
        Tue, 23 Apr 2019 17:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556032686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oMcz3bUHYswDDrQ7QNWUvTaNZqSc2N0gU9YWSBX2G7Y=;
        b=Zg9ysvyrkxlCHY+wjzIehwuweBRqpa3za/U3tQWiNZ4fJPJgmjSSBieEAScDxl1r+RQRdK
        vMGx8vkRffIbxrVle4rb+3/EjihMjLGKOkHBcEz/4Utz2r4ZXcpAfQTMFgfk8HV5ei6449
        Adlm7xBtsHa5pK/iJ/PiUmXNyGmDUgQ=
Date:   Tue, 23 Apr 2019 17:18:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190423151804.GC16353@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
 <20190418074510.GB27160@zn.tnic>
 <20190418095015.GB18646@arrakis.emea.arm.com>
 <20190423132518.GA16353@zn.tnic>
 <1556029006.6132.1.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556029006.6132.1.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:16:46AM -0400, Qian Cai wrote:
> In reality, this is only the second place that needs this kmemleak_free_part()
> call for all those years since kmemleak was born.

And? Which place warrants doing it right? The third? Fourth?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
