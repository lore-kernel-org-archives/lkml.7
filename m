Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4170C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435B206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="c6Cmgi5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgAGT4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:56:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGT4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:56:15 -0500
Received: from zn.tnic (p200300EC2F0FB400453AE1B66C2BC925.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:453a:e1b6:6c2b:c925])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79D601EC0CD3;
        Tue,  7 Jan 2020 20:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578426973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zJdzw9vdkkA44yZnoPDWFx4T2qfF2F6ZTtjuf1myUDQ=;
        b=c6Cmgi5FsxCq7tY22uGn4iuGnCPPUTmAyhNnQSgEVvj+eGfp/LheH8l2PFmsGIJDIsM9yU
        LKj2gYjB2yNraq8WCc0J2ejlawHofJhLD7Mckn2LwsF9ylF1TImESL5r3OhBSZquRFU1vr
        vcXEIvQ/oMC33a8uyNbqvZUkTb1Ci9o=
Date:   Tue, 7 Jan 2020 20:56:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Lei Wang <lewan@microsoft.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: EDAC driver for DMC520
Message-ID: <20200107195606.GM29542@zn.tnic>
References: <bdb29d6d-bc63-cf68-0e32-556740537cd8@broadcom.com>
 <20200107184926.GL29542@zn.tnic>
 <f56605f8-e49f-6b99-5735-b4bec75af9fd@broadcom.com>
 <5a3188d8-e23a-b0de-bef7-ff60dda339ab@gmail.com>
 <9364cef0-73ff-0bde-8e50-7463d0c20707@broadcom.com>
 <3dc9a736-16c9-7e87-b27c-bf3029d1a37f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dc9a736-16c9-7e87-b27c-bf3029d1a37f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 11:18:42AM -0800, Shiping Ji wrote:
> > If Lei is coming back soon then it may be best to wait for her?

Whoops, I made her a "he". Lei, sorry about that.

You add your SOB under the original author's one:

From: Lei Wang <leiwang_git@outlook.com>

<commit message>

Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Signed-off-by: you

The kernel tree is full of examples. git log is your friend.

> Yes, I followed the notes but apparently have missed some important
> steps. I'll go the above document and get it fixed.

Yes, it would be time well spent if you intend to deal with submitting
patches to the kernel in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
