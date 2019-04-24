Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A5120878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oeEKVgfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfDXJjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:39:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfDXJi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:38:59 -0400
Received: from zn.tnic (p200300EC2F08C6006C678EE1EA32B98E.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:c600:6c67:8ee1:ea32:b98e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 723871EC04B7;
        Wed, 24 Apr 2019 11:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556098738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JejLD+R960TRX+8V0U0wI4gGRyzSQFE2oqtfqgoPky8=;
        b=oeEKVgfGTgBDxThbtK4sOa2Wm+0pNaO62N0zaerGXSinbmPDRZp2/4pOjRrRp9DMMW6+EL
        dyf34GfeCzfaUMR9Mx10DwotXD5EGnVFoRTstn2c8wW9np5M7nYZF1+p82sahWcs7Mfx9c
        9Y0MBYKkzw4I+1mLUVQoOtTrZdp+DXg=
Date:   Wed, 24 Apr 2019 11:38:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com
Subject: Re: [PATCH v5 0/2] x86/boot: Use efi_setup_data for searching RSDP
 on kexec-ed kernel
Message-ID: <20190424093852.GB30142@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424092944.30481-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:29:42PM +0800, Baoquan He wrote:
> In this series, patch 2/2 has dependency on patch 1/1, otherwise
> it may cause system to reset to firmware on some machines.
> 
> The patch 2/2 is the version Boris organized:
> http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic
> 
> Patch 1/1 is based on Kairui's v1 patch, and add ACPI tables mapping:
> http://lkml.kernel.org/r/20190422092804.15534-1-kasong@redhat.com
> 
> Dave Young confirmed this patchset passed test on his t420 laptop, where
> the system resetting issue caused by patch 2/2 was found.

I guess but this does not give me the warm and fuzzy feeling one week
before the merge window.

So:

https://git.kernel.org/tip/36f0c423552dacaca152324b8e9bda42a6d88865

and we all can relax ourselves and take the next release cycle to test
the hell out of this before reenabling it again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
