Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE32020651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pIaBt54w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfHEQHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:07:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfHEQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:07:25 -0400
Received: from zn.tnic (p200300EC2F065B00683A29B48F14DC99.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5b00:683a:29b4:8f14:dc99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EF5F1EC0C2D;
        Mon,  5 Aug 2019 18:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565021244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nklzz8qf9O25R5GwMPqR04q/XG5M8sTeEqMATsDpR4s=;
        b=pIaBt54w3IWNfN5oJf4gE/TpmB3FBoo7JGeWbvQ8R5RKJF/PLQmztYKzW/kKrrmRGjye71
        2RqHgNkP2vshHh1JQndXgfaVqOAdPYXcUYU4rSxRdcj2s8tRZ9j5PZSzUeogWKWhAS2166
        OcBc5gvtA5rz4GH92eqa10OKtXj/FWM=
Date:   Mon, 5 Aug 2019 18:07:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 06/10] x86/resctrl: Introduce utility to return
 pseudo-locked cache portion
Message-ID: <20190805160723.GC18785@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <12976aa4707da37b0fcc9ea196eed53eaa253d07.1564504901.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12976aa4707da37b0fcc9ea196eed53eaa253d07.1564504901.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:29:40AM -0700, Reinette Chatre wrote:
> To prevent eviction of pseudo-locked memory it is required that no
> other resource group uses any portion of a cache that is in use by
> a cache pseudo-locked region.
> 
> Introduce a utility that will return a Capacity BitMask (CBM) indicating
> all portions of a provided cache instance being used for cache
> pseudo-locking. This CBM can be used in overlap checking as well as
> cache usage reporting.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)

s/utility/utility function/g

so that there's no ambiguity...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
