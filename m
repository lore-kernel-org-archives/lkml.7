Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B939C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428720673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rw+EH+Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFFHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:33:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFHdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:33:43 -0400
Received: from zn.tnic (p200300EC2F1EFA008DFA61B32E935F4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:8dfa:61b3:2e93:5f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10CC01EC0997;
        Thu,  6 Jun 2019 09:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559806422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oDuZcljZ6XPfPpxNTNWHMC/JG/+jzdqwlSZ4IwPbjkI=;
        b=Rw+EH+Nxh1cToJX0wiYHeUl9ZoruJkvobehk/I31YYZaBe4pIVlrbwWap/Xfj0t/FGcXXF
        FPx4WpfAFA7iDIRBgnoSqNLHGwgNfVVsh4VfD/Bd6YFbDLM472uR4v0k643kfL9HaGmKeK
        bcz6lfkC4vTd3eNYiSfbJZjDIYJaZ8E=
Date:   Thu, 6 Jun 2019 09:33:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] x86/CPU: Add more Icelake model number
Message-ID: <20190606073336.GB26146@zn.tnic>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190606063525.GA26146@zn.tnic>
 <E6AF1AFDEA62A94A97508F458CBDD47F7A22F284@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E6AF1AFDEA62A94A97508F458CBDD47F7A22F284@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:13:18AM +0000, Zhuo, Qiuxu wrote:
> During internal co-work, based on Kan's original patch, I got the
> "#define" in the Ice Lake group sorted by model number(the header of
> the file requires the sorting) and added my SOB. Dropping my SOB or
> adding a text "[Qiuxu: Get the macros in the Ice Lake group sorted
> by model number.]" at the end of the commit message - which one is
> better/clear for you?

I'll add that note when applying.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
