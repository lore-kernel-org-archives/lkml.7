Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB038C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0320848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fSPZsoNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgAGStc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:49:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgAGStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:49:31 -0500
Received: from zn.tnic (p200300EC2F0FB4001C0F6E794847FFF7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:1c0f:6e79:4847:fff7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B43D71EC0985;
        Tue,  7 Jan 2020 19:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578422969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=prJXbdZ0G6DtKTXl0d7vCCyv/ZmBVWRGcQzxuDDAYeA=;
        b=fSPZsoNUw5Cor3fhNQHJZWrhN/pUgJSB4jeTW3Wf+wrx+3he+2C3DTQ/T7IIXMB6WdDbsH
        /j4Q4FGTDb9c2eyxKJOR3z7+S4p3580qkHS1/ZX9hX+eALz//AJ1YmY2oxECGMXvcZaNcy
        j8jphI14T3aOS9rjLIrW8acWzHwsMqw=
Date:   Tue, 7 Jan 2020 19:49:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Lei Wang <lewan@microsoft.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: EDAC driver for DMC520
Message-ID: <20200107184926.GL29542@zn.tnic>
References: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:57:26AM -0800, Scott Branden wrote:
> Hello EDAC Maintainers,
> 
> Could somebody have a look at the DMC520 patch series that has been waiting
> for a response since November:
> https://patchwork.kernel.org/patch/11248785/

Well, the dt bindings stuff is still being discussed:

https://patchwork.kernel.org/patch/11248783/

Also, looking at this again, the patch authorship looks really fishy:

Sender is

From: Shiping Ji <shiping.linux@gmail.com>

however, he doesn't have his SOB in there and previous iterations were
done with Lei Wang whose SOB *is* there so I dunno what's going on.

*Especially* if Lei Wang is being added as a maintainer of that driver
by the second patch but he's not sending this driver himself. If this
driver is going to be orphaned the moment it lands upstream, I'm not
going to take it.

So at least those two things need to be fixed/clarified first.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
