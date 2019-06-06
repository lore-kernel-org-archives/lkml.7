Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFECC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2659B2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j7nQQJ5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFFGfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:35:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:35:33 -0400
Received: from zn.tnic (p200300EC2F1EFA008DFA61B32E935F4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:8dfa:61b3:2e93:5f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2E751EC0513;
        Thu,  6 Jun 2019 08:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559802932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2J8DdInKpmzx24fxQBHI91onaoiEPFdbvkx/W0JKw0I=;
        b=j7nQQJ5S7+y4LaPUb3HLb3yVvNdbIarVlYHw7h0sgWC1WKGWYo/gJgsYeZKphPGZ5AyWs+
        MwxEfNLVHLm9VspXJCb3tH8XEDQkQVHHvBDj/7p/Mf9Pii3faY2N2LeUhqShEhWHnTkIVY
        76x3wcRc+WJQeS/wAZYdWAE5W1HdAvg=
Date:   Thu, 6 Jun 2019 08:35:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, qiuxu.zhuo@intel.com,
        tony.luck@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH 1/3] x86/CPU: Add more Icelake model number
Message-ID: <20190606063525.GA26146@zn.tnic>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603134122.13853-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:41:20AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add the CPUID model number of Icelake (ICL) desktop and server
> processors to the Intel family list.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

You're sending this patch but it has Qiuxu's SOB too. What's that
supposed to mean?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
