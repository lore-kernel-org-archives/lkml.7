Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EFBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175BF217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="otPgQFe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfDHPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:10:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDHPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:10:15 -0400
Received: from zn.tnic (p200300EC2F07270021E2DB6109CF2936.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:21e2:db61:9cf:2936])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FDF21EC027B;
        Mon,  8 Apr 2019 17:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554736213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=76BhWAV+Oz+leNAtoaJxpaHozdsK8akHjk6hGJCdbJY=;
        b=otPgQFe4GcOmFk3+zD8oProaTZL33Y+jXOFUiEUt8gmfhcCWh4F30BGuvrF5conAmBKu/A
        csI68dtwvmx/kIsUL00gNgzIjvoN5E4VLsNmb6Xxw34DmStzk2fsVomMAbfL78Oj8K9d/8
        pn6VzxKCw6KsQvjJ/TJtUbPV2ybpqyc=
Date:   Mon, 8 Apr 2019 17:10:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 4/4] x86: Add hypercall for acrn_guest
Message-ID: <20190408151010.GI15689@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554711131-21514-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:12:11PM +0800, Zhao Yakui wrote:
> When acrn_hypervisor is detected, the hypercall is needed so that the
> acrn guest can query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for Guest system.

Good example.

What is "Guest system" and why is capitalized? Do you mean "the guest
operating system" or simply "the guest"?

> So the hypercall is added so that the kernel can communicate with the

"So add the hypercall so that... "

> low-level acrn-hypervisor.

Is it acrn_hypervisor or acrn-hypervisor or the ACRN hypervisor or ...?

Unify the naming pls.

> On x86 it is implemented by using vmacll when

During last review Thomas said:

"is implemented with the VMCALL instruction"

You still have it wrong. Which makes me think you haven't even gone over
*all* review comments as this is the second missed review comment in a
4-patches set.

So I'm going to stop reviewing here and won't look at your patches until
you incorporate *all* review comments from all people.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
