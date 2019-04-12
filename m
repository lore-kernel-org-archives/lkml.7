Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8877BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C69B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qzlEpaJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:24:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40244 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfDLIYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:24:46 -0400
Received: from zn.tnic (p200300EC2F0884007C96562F0B339423.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:7c96:562f:b33:9423])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A231B1EC04B9;
        Fri, 12 Apr 2019 10:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555057485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G2hXViwABHA/ST5f19qcgrbsoJrRHVF39/dtzzomT5g=;
        b=qzlEpaJavmkiUOaYm9FNONhslt7rzrrulgpPqEJqEHQ/U0DEX68idC2MYWjaD8t9z7mhm0
        MIKGr9zTt4S3saR3/30Ppi6eaR8fqPhgBqCXOqAQLsIyUe4CDTVxtCLZEuY/P9Q4pGVGAH
        VNb/YhE/CXm1lw4h8vOyI4HMMMSbR4o=
Date:   Fri, 12 Apr 2019 10:24:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 2/4] x86: Add the support of ACRN guest
Message-ID: <20190412082438.GA19808@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
 <20190408143952.GF15689@zn.tnic>
 <ab54d5a4-4f4c-9401-2e98-f0ac09d023b1@intel.com>
 <20190411134900.GG30080@zn.tnic>
 <222b3a4a-6706-ed11-a8cf-9e6f516cc7fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <222b3a4a-6706-ed11-a8cf-9e6f516cc7fe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 08:36:34AM +0800, Zhao, Yakui wrote:
> So we will leverage the X86_FEATURE_X2APIC bit from CPUID to indicate
> whether the x2apic is supported in linux guest when ACRN hypervisor is
> detected.
> Is this fine to you?

Yes, put that more precise info in the comment pls.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
