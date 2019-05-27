Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F3C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4344D2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A00FDt0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfE0WqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:46:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfE0WqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:46:24 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35F9D1EC0235;
        Tue, 28 May 2019 00:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558997183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tz/wYb9ZTgdeeX3it/ip9i6gjcnrr3qGX3T9govsyN4=;
        b=A00FDt0XL2VDLFTI3YDevRLRnGbVfr9F/RxbMyYPU0160EDi+hHxDI8VR0iCK6IntFjcDs
        pNTTUm562Hy4xb7/A/ZRrnHiavdC96SW9M3xOtWgV9if6uvzmS4E1+RSpgGF3LvpqLYiQj
        XWYT01QmqHjSZnnQ0tyAvqskPgtK/Wk=
Date:   Tue, 28 May 2019 00:46:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [PATCH v6 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190527224618.GB8209@cz.tnic>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
 <20190515073715.GC24212@zn.tnic>
 <b8210e0e-bdf2-3e17-ce9a-d7a3ca0e6672@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8210e0e-bdf2-3e17-ce9a-d7a3ca0e6672@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:57:09AM +0800, Zhao, Yakui wrote:
> I refer to the Xen/KVM hypercall to add the ACRN hypercall in one separate
> header.

And?

> The ACRN hypercall is defined in one separate acrn_hypercall.h and can be
> included explicitly by the *.c that needs the hypercall.

Sure but what else will need the hypercall definition except stuff which
already needs acrn.h? I.e., why is the separate header needed?

> The hypercall will be used in driver part. Before the driver part is added,
> it seems that the defined ACRN hypercall functions are not used.
> Do I need to add these functions together with driver part?

Yes, send functions together with the stuff which uses them pls.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
