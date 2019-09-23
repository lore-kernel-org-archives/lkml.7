Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dWoKUwJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406552AbfIWJTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:19:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45716 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406312AbfIWJTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:19:35 -0400
Received: from zn.tnic (p200300EC2F060400856443B6AC31000F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:8564:43b6:ac31:f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05BBB1EC0A9C;
        Mon, 23 Sep 2019 11:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569230374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5pwsAyj8PZScyXe4qBM2nWIssrzB6uzFre3kbh+SHZg=;
        b=dWoKUwJz6Qm7+hRFvB2tRcKgOul7jqHdTs0YLawetWMz3v3zVthRaQqC8SIK9GWWsAWfOg
        I4asrhdfkkzCK7EeNi4CrPFp1kcKXnq0PEu8coT5WnAEMHCIki30BzZtePrmJ4dcHL2plw
        tOT282T1i+NQX53DOQMePZA8e23nabg=
Date:   Mon, 23 Sep 2019 11:19:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
Message-ID: <20190923091934.GA15355@zn.tnic>
References: <20190922083342.GO13569@xsang-OptiPlex-9020>
 <20190922150328.6722-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190922150328.6722-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 06:03:28PM +0300, Alexander Kapshuk wrote:
> This patch fixes the regexp warnings shown below:
> GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> 
> The ':' and '&' characters need not escaping when used in string constants
> as part of regular expressions.

How do you trigger this?

I don't see it in my builds so it looks like environment thing. What
flavor of awk is yours?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
