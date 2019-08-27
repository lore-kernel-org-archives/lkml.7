Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98790C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0292077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eL3U/jP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfH0NKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:10:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbfH0NKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:10:35 -0400
Received: from zn.tnic (p200300EC2F0CD000F02F6C1468024718.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:f02f:6c14:6802:4718])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 975791EC0B89;
        Tue, 27 Aug 2019 15:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566911433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O36I11NR1TCXF+c0kx9q6zN8+NXYhHhq5Irre2ThJw=;
        b=eL3U/jP2V+9BgFmUx2XVAEzxHUZCz/v86h5uaRhGjMr31UHC+T2CTAkJSXBFSpwruJ1XvO
        gBUuQnvSiU8VFgpWBOnNbhbeKHz7Be5KDdYVQv8jCO1AI1FJMduxPKTWMaGj4DvmS1AVpf
        pDpkFlNfJpLwsKGI8UtliZUEbNSdwOM=
Date:   Tue, 27 Aug 2019 15:10:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190827131029.GF29752@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823081316.28478-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:13:14AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The new header is intended to be used by drivers using the backdoor.
> Follow the kvm example using alternatives self-patching to
> choose between vmcall, vmmcall and io instructions.
> 
> Also define two new CPU feature flags to indicate hypervisor support
> for vmcall- and vmmcall instructions.

I could use some of the explanation why we need two feature flags added
here from:

https://lkml.kernel.org/r/970d2bb6-ab29-315f-f5d8-5d11095859af@shipmail.org

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
