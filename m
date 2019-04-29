Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957542075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HVlw3m+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfD2MvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:51:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfD2MvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:51:06 -0400
Received: from zn.tnic (p200300EC2F073600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E61C11EC027B;
        Mon, 29 Apr 2019 14:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556542265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bA2DoZBdBxjCQTavTzxSc5Np+MuR/nnLiokGPyDt0i8=;
        b=HVlw3m+fIF2XMTA1R+vvf1ylQ6diXofFpsgL4of6CWSFQb6v4/OEzkOvM6zB1xxzh0iPlC
        dctwnxi0SXRhG0k7iRlkIwjEHwVBT5Wxhfhl+iwKoNWLR6gP/15u0urGvUvWIpVeHVRQjC
        qJUrgog+zUByu6mW7RxYBNYyMsVaJS8=
Date:   Mon, 29 Apr 2019 14:50:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com
Subject: Re: [PATCH v5 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190429125059.GB2324@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190427161121.GC12360@zn.tnic>
 <20190428054114.GS3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190428054114.GS3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 01:41:14PM +0800, Baoquan He wrote:
> About this place, do you think below change is OK to you?
> 
> ~~~
> The current code only builds identity mapping for physical memory during
> kexec-type loading. The regions reserved by firmware are not covered.
> In the later code change, the boot decompressing code of kexec-ed kernel
> will try to access EFI systab and ACPI tables, lacking identity mapping for
> them will cause error and reset system to firmware.

Yap, better.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
