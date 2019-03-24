Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADBEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3820880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OVuVt4P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfCXVu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:50:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfCXVu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:50:59 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C4EF1EC00FF;
        Sun, 24 Mar 2019 22:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553464258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l3kONfTwnHD8vZF7xiWfX+ViLFXe+mDip9Bjw/iuA10=;
        b=OVuVt4P3vpXNIUv157i7hHXGG9j+YgCzXu+je3AGz/YBYNBll11Ly+ZofIGC2ltfDPb2MZ
        hUknIn3Y+mvnEbhc2bQV4B+hrV6Aq8X4gc9n9lj79lLPta9F3ndxklAdx8MyN9qKWkX3Ge
        7V/lwlpozmjYQU3e8tCKTKatMiDxwIM=
Date:   Sun, 24 Mar 2019 22:51:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86, putuser: copy pasta into 32 and 64-bit versions
Message-ID: <20190324215101.GL23289@zn.tnic>
References: <20190316210239.GB21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190316210239.GB21830@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 12:02:39AM +0300, Alexey Dobriyan wrote:
> I'm going to rewrite 64-bit version to use normal x86_64 calling convention.

This commit message is too laconic and it needs to be in passive voice
and impartial. Also, here or in your 4/4 I'm missing the justification
for why you're doing all this.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
