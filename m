Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8158CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415032184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="b4PHaMd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKNtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:49:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:49:07 -0400
Received: from zn.tnic (p200300EC2F0ABD00B0506403E4AFEFF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bd00:b050:6403:e4af:eff4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1B241EC0A8F;
        Thu, 11 Apr 2019 15:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554990546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sPs7o/G+UQ9SWhBybAWOHU16f+ESKLmeQTXgWc3iDEk=;
        b=b4PHaMd3lnkYsUM1bgRqQpAU0BjQTZG4mrY2vo3r/XTyATwlWo9GzdJQg5Uk0FVIQzCNxO
        wBET439tMUuIG+2jfr900avOm6DbkE6Afa0/oIA0XFcQNZlf6h2/u+Q+Q8Vx7Wbp9xlAi+
        htaC6dnmnonH11DjTCjI3GUEJ2wyvRc=
Date:   Thu, 11 Apr 2019 15:49:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 2/4] x86: Add the support of ACRN guest
Message-ID: <20190411134900.GG30080@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
 <20190408143952.GF15689@zn.tnic>
 <ab54d5a4-4f4c-9401-2e98-f0ac09d023b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab54d5a4-4f4c-9401-2e98-f0ac09d023b1@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 05:15:48PM +0800, Zhao, Yakui wrote:
> Currently the x2apic is not enabled in the first step.
> Next step it needs to check the cpu info reported by ACRN hypervisor to
> determine whether the x2apic should be supported.

What "cpu info"? CPUID or something ACRN-specific?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
