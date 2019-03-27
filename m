Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6686A21734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pff2Vris"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfC0NPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:15:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfC0NPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:15:35 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D2371EC014B;
        Wed, 27 Mar 2019 14:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553692534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ASbmkHgvY9fjFIiRiMGob+q5TJppeKvfkE7AtByBBnk=;
        b=pff2VrisBp/X1aqXxYAxWPs+kI57S2wIFCNB2adoGpWTGlMK10D4A4kyqRBFDPze1DSUiu
        1C+bPZkezhbiJ5kVeceowiLrCCGq94fJg4HeYiQdi1vU2Pp0JWsEN17XmPL0G4iy31tZ3+
        h5Jj6HY9adCnXc3xBfI+tmc07a2OkWY=
Date:   Wed, 27 Mar 2019 14:15:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
Message-ID: <20190327131536.GF32571@zn.tnic>
References: <20190225191109.7671-1-bp@alien8.de>
 <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
 <20190225194203.GI26145@zn.tnic>
 <4c48dea49377612eb85a699de8a52ee12eef3de3.camel@perches.com>
 <alpine.DEB.2.21.999.1903032242440.4505@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1903032242440.4505@trent.utfs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 10:47:00PM -0800, Christian Kujau wrote:
> If so, would simly removing it do the trick or is there more magic 
> involved? I don't have that many cross-compilers though and it's not even 
> build-tested:

There are cross compilers here:

https://www.kernel.org/pub/tools/crosstool/

which you can use.

And perhaps splitting that patch per architecture and letting arch
maintainers apply each, would be easier. I think.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
