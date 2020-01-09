Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3ADC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0026020880
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o8hyLvww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgAIUuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:50:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgAIUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:50:50 -0500
Received: from zn.tnic (p200300EC2F0C57004DD84C0E473AA3AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:4dd8:4c0e:473a:a3ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A72D1EC0CAD;
        Thu,  9 Jan 2020 21:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578603049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XCRML0Cx0Cx5kYs7V7J7wBoduSfA5eUznn1aXx4A2M0=;
        b=o8hyLvwwD7oXavXJt1E6gwf4KFTqynRv/IHPls1+Pl5+0TqyDiyfESW1Mesb9DL5dIGUG6
        aFxxnoY6rZsMFY7fsYyIdByRjwGaX5bfIl2CI5WSQIA8X5ne2Xl+8tpfB09PZrLO0Mby6k
        Zl5sWaCenVU6qCYHPE2KcWz+NVxgsE8=
Date:   Thu, 9 Jan 2020 21:50:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200109205041.GJ5603@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
 <20200109204638.GA523773@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109204638.GA523773@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop fanc.fnst@cn.fujitsu.com from Cc because it bounces.

On Thu, Jan 09, 2020 at 03:46:41PM -0500, Arvind Sankar wrote:
> The boot/compressed Makefile resets KBUILD_CFLAGS.  Following hack and
> building with W=1 shows it, or just add -Wunused in there.

I'm interested in how he reproduced it on the stock tree, without
additional hacks or changes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
