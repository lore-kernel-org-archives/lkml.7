Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB33C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2341420870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kULiMRwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCWQkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:40:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34636 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfCWQkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:40:05 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C9F41EC0104;
        Sat, 23 Mar 2019 17:40:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553359204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lOKXiEI7x8DXltXaOwmHZm2R5FxpOqAu6yXJN5vF8eE=;
        b=kULiMRwzFq3wTtNZhQI0f+SaxdVXB/+ctg8dYfTTeYr9am4Q5afukNEsLOVlZXrrWdf6bt
        cDqzvoLCECUFUABwcta6BQNs6MAk07hkAIUjm/RzhzkE6MD5YdLgrgdeP83o4flfkHwF7G
        VthEmVXiBwr7D2BC57hCqYsL2FRE8qw=
Date:   Sat, 23 Mar 2019 17:40:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190323164006.GG23698@zn.tnic>
References: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 11:42:20PM +0800, Pu Wen wrote:
> 
> v1->v2:
>   - Define bit 6 of ApicId with a descriptive name.
>   - Add description about why Hygon need to do something different than
>     what AMD does.

In the future, such patch changelogs belong right...

...

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---

<--- here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
