Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C745214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RoLTxt7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfDAIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:39:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55454 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731774AbfDAIjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:39:07 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B1AB1EC0310;
        Mon,  1 Apr 2019 10:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554107946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCirMZg/uMkGk6UeRZJAmvhn66l8um2NKOXj+fKIZmA=;
        b=RoLTxt7gqR/6AqjeLygzFIDW/XTLjtEwxSpCvq+oNqdQk20SWs61LWfgrpNUcR6ymyLfCR
        qhWOs/6mIq9F2wfH09UtcAaosE/EE8vgDw8+LvGHQqyJ7uACtenN2aiU6a+ggBquLaXW4A
        pmD2QF1qy+tMWp5PTj5m6cm1xfSvf2w=
Date:   Mon, 1 Apr 2019 10:39:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Erwan Velu <e.velu@criteo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/intel_pstate: Do not issue the not supported
 message on !Intel
Message-ID: <20190401083902.GC28264@zn.tnic>
References: <20190330100225.14744-1-bp@alien8.de>
 <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:11:51AM +0000, Erwan Velu wrote:
> I'd suggest something like this and keep the 'CPUID not supported' part 
> untouched.
> 
>      if (no_load) || (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)

Yeah, that's the usual thing we do in such cases and the better idea,
I'll do that in v2.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
