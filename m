Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F071C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE762183E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pC2CK4Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHRSIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:08:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfHRSIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:08:42 -0400
Received: from zn.tnic (p200300EC2F259C00703A980AE4B2B198.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:9c00:703a:980a:e4b2:b198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC9141EC0947;
        Sun, 18 Aug 2019 20:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566151721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBCAv+4kYgJEACiz8C02kJUNEYlK7ZFvRwxPj7CxqlE=;
        b=pC2CK4ZfABUDL5ZgQwBnz2pIXXVJDQIroFH3YIy97BW+MtxLmDWt9bbfmlNinbJRbgG1dE
        gaRw2in6fs0nZhS/OPQu5xtSTRgfGcTzybeS7AHz72jWYB96Hs4Gd9TrMlegrbgUr6ir90
        AHMxw0NsecTxlBlDGR90bFFTzACs5+I=
Date:   Sun, 18 Aug 2019 20:09:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for updated vmware hypercall instruction
Message-ID: <20190818180929.GA29353@zn.tnic>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818143316.4906-1-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 04:33:12PM +0200, Thomas Hellström (VMware) wrote:
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: <linux-input@vger.kernel.org>

In the future, when you CC people on patches, pls CC them for all
patches - not only a subset. Had to fish out 3/4 and 4/4 from lkml.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
