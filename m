Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E762064A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="N3XRBKtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfCYSME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:12:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44338 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfCYSME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:12:04 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30C1C1EC06CA;
        Mon, 25 Mar 2019 19:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553537523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RbbXfzuezoD7Op9HDM8ogvN/lNcOeJSlYV4LqWriCRs=;
        b=N3XRBKtTwX9vRTVC4eJBQC1Ep3QhUb08ezB/BD4q0Nkiq/LS7J5gcgB6nAsp2V3vKk1PuJ
        Z5TnBb4vYBiC6vQtMdCP4g5EqtFfNy3HOUQSA674t1GBpPVVy559As3kevIIpuQFlXH69r
        /BuyDzp/sxV3yWOa1U2zXGvljfE8N2Y=
Date:   Mon, 25 Mar 2019 19:12:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jim Mattson <jmattson@google.com>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Message-ID: <20190325181205.GP12016@zn.tnic>
References: <20190325171649.7311-1-bp@alien8.de>
 <20190325171649.7311-2-bp@alien8.de>
 <CALMp9eTX5x9vchMje6J-Fji6jGfHnz=sPVmSKwO-3zdChAZz=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eTX5x9vchMje6J-Fji6jGfHnz=sPVmSKwO-3zdChAZz=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:05:48AM -0700, Jim Mattson wrote:
> If the guest has written a non-zero value to this MSR, shouldn't it be
> able to read that value back?

See the second patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
