Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18509C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2D124683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YecgCsSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTKFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:05:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:05:39 -0500
Received: from zn.tnic (p200300EC2F0ED600DC469E28B29B59E9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:dc46:9e28:b29b:59e9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4668A1EC0BED;
        Fri, 20 Dec 2019 11:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576836338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DMfNsoTS3Jp30mfhEhFAKDx1K58MITCksuLDayfcbsM=;
        b=YecgCsSj5vMtOTmSNAo6x+yiSPr1N0aUpxNBseaRMwiYbqF9C6ZX4SOyarqri/2BPy/97B
        hq1Qsb0SkQGlFx3hoIlBRDI2hBpc9JzS6pEtOX3GZ5X3uairxSXil2dcl4i58hR0nSmBWc
        BsagUdp06Aj3EyMaFefc1SAEO/IDQtk=
Date:   Fri, 20 Dec 2019 11:05:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: define arch_crash_save_vmcoreinfo() if
 CONFIG_CRASH_CORE=y
Message-ID: <20191220100536.GC1397@zn.tnic>
References: <9e9eb78c157d26d80f8781f8ce0e088fd12120b4.1575309711.git.osandov@fb.com>
 <20191218104113.GB24886@zn.tnic>
 <20191219202807.GA826140@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219202807.GA826140@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:28:07PM -0800, Omar Sandoval wrote:
> Yes, I'm talking about reading VMCOREINFO from /proc/kcore at runtime,
> no kdump involved. crash [1] and my own tool, drgn [2], use this for
> live debugging.

Ok, please state the gist of the use cases in the commit message so that
it is clear why you're doing this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
