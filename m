Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B0E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GCjn/XBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfDRKLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:11:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRKLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:11:38 -0400
Received: from zn.tnic (p200300EC2F112E00403003D72BA0966D.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:4030:3d7:2ba0:966d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5ED3D1EC04CD;
        Thu, 18 Apr 2019 12:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555582297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SZJZziXh8tdVC4uZVmskFCb7LR20UezZTpC+pF4JG04=;
        b=GCjn/XBBywYfjV62oFL4iKPQZbdHRs9RiaASsProaCnvB6V/OZKvl/E0bqU2OMiv7C/H8L
        YUA/fTBHwtUisuQHAXV9731NopqQCzjmhMXu66UL97lDG20TWxCd76iO8NlpmtXOdLbmpt
        qEQk1/gkYpOaq06yiBkv6uaHxsR6zQg=
Date:   Thu, 18 Apr 2019 12:11:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v4 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190418101136.GE27160@zn.tnic>
References: <1555293657-32233-1-git-send-email-yakui.zhao@intel.com>
 <1555293657-32233-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555293657-32233-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:00:57AM +0800, Zhao Yakui wrote:
> When ACRN hypervisor is detected, the hypercall is needed so that the
> ACRN guest can query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for guest operating system.
> 
> Add the hypercall so that the kernel can communicate with the low-level
> ACRN hypervisor. It is implemented with vmacll instruction.

This still has unfixed stuff from 2 review cycles ago.

Thomas corrected this in his review to:

"is implemented with the VMCALL instruction"

https://lkml.kernel.org/r/alpine.DEB.2.21.1904052110370.1802@nanos.tec.linutronix.de

You ignored it.

I reminded you about it and suggested to check and incorporate *all*
review feedback before sending another version:

https://lkml.kernel.org/r/20190408151010.GI15689@zn.tnic

You ignored it again.

Now, if you get ignored, you know why, right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
