Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ECC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938E620821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rr1KAXAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfDPISC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:18:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfDPISB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:18:01 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDC3D1EC02AE;
        Tue, 16 Apr 2019 10:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555402679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nDvF4S1+lIBCUzN9gKhXfZJ/hakwmK/N0HqonzHe4os=;
        b=rr1KAXAEEL6FA1ujlKRNq4PqFc/R35ZTNGY1Pokkytviu5F+hGeM8OQPD2YrdVfFfcoQUf
        bfzjeqbcrYvhQr5GWiOfxnR39n3W16Ze0X51J7h8LB3+LI1Jym62+6rSEmnZglf+2ccIFY
        bdhs7kxT15ctxIARAf8WlygMX4YjPI8=
Date:   Tue, 16 Apr 2019 10:15:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hao Feng <fenghao@hygon.cn>
Cc:     'Joerg Roedel ' <joro@8bytes.org>,
        'Paolo Bonzini ' <pbonzini@redhat.com>,
        ' Radim =?utf-8?B?S3LEjW3DocWZ?= ' <rkrcmar@redhat.com>,
        'Thomas Gleixner ' <tglx@linutronix.de>,
        'Ingo Molnar ' <mingo@redhat.com>,
        "' H. Peter Anvin '" <hpa@zytor.com>,
        Zhaohui Du <duzhaohui@hygon.cn>,
        Zhiwei Ying <yingzhiwei@hygon.cn>, Wen Pu <puwen@hygon.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] KVM: SVM: Add support for KVM_SEV_GM_GET_DIGEST
 command
Message-ID: <20190416081545.GA27892@zn.tnic>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
 <1555329868-17895-6-git-send-email-fenghao@hygon.cn>
 <20190415150910.GE29317@zn.tnic>
 <896956377bf441c3bfd911716418ce7e@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <896956377bf441c3bfd911716418ce7e@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 07:54:40AM +0000, Hao Feng wrote:
> Thanks for the comments, I thought there could be multiple signers...

There can be multiple signers but as you've read in the sections above,
those SOBs all have a meaning and in your case it wasn't clear what that
meaning is.

> After reading through the guidelines again, seems I should use the
> following statements instead?
> 
> Co-developed-by: Pu Wen <puwen@hygon.cn><mailto:puwen@hygon.cn>
> Signed-off-by: Pu Wen <puwen@hygon.cn><mailto:puwen@hygon.cn>
> Signed-off-by: Hao Feng <fenghao@hygon.cn><mailto:fenghao@hygon.cn>

Yes, as long as you realize that having the From: you makes you the
author of the patch and Pu Wen is fine with that.

Btw, you should fix your mailer to send plain text only and not add
those <mailto: > crap tags above.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
