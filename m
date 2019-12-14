Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB23C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6DD24656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="chfeFSas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfLNM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 07:27:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfLNM1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 07:27:42 -0500
Received: from zn.tnic (p200300EC2F0A5A009CBB5BB8E6A81C1F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:9cbb:5bb8:e6a8:1c1f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 682DF1EC095C;
        Sat, 14 Dec 2019 13:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576326460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KMOGp1DUcIN500Sf6UYZB3bgYUnXmeQfVRfnvzyLKHY=;
        b=chfeFSasyOvGnWur6zP4vjznxjIxTClbROkym4G+z0Jf+v1/F5zEEQxoTkld0mGQ3/uuKy
        tToyhG1ZCVWakFI2UFgtYTvuCB6F7DakzuI+cYbEVgsMl4UWGFpe0VnsQfw8qY1N6MDSvc
        c5dUrY9q0OXDBpPggRMfLryMpBiGwm8=
Date:   Sat, 14 Dec 2019 13:27:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191214122734.GC28635@zn.tnic>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> Bhupesh Sharma (5):
>   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>   Documentation/arm64: Fix a simple typo in memory.rst
>   Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'
>   Documentation/vmcoreinfo: Add documentation for 'TCR_EL1.T1SZ'

why are those last two separate patches and not part of the patches
which export the respective variable/define?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
