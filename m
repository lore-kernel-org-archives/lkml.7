Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA58C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8342465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nUw9LW0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfLNHPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:15:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfLNHPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:15:32 -0500
Received: from zn.tnic (p200300EC2F0A5A00D0F33451B6E85A6B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:d0f3:3451:b6e8:5a6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6522C1EC03AD;
        Sat, 14 Dec 2019 08:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576307731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tMwjUthhqQ9hoTv144WJaupinyPbR61fTpHmQcNxzm8=;
        b=nUw9LW0Gh8geZdoxRoVJhxSqBO7U2bgPbupYXsFqsiYhEIqHNwediy/SLOz2srZrBwdxpo
        EO/D2m+UABG+bgnTYp9BUUBOrPdKmZwoHsSgR/z7D3pnSKJhCavLmSmUaBteHDKYFfgDce
        zngTL5CjuR7aXpwGLIP34g7OJcuR7lk=
Date:   Sat, 14 Dec 2019 08:15:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191214071529.GB28635@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
 <20191214033348.GJ28917@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214033348.GJ28917@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 11:33:48AM +0800, Baoquan He wrote:
> So in kernel there's no way to check if memory hotplug is supported in
> system.

Which makes it even worse. We will carry this bunch of code which would
be dead code on most systems. Do you understand now why I'm pushing back
on this to be designed as clean and as lean as possible?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
