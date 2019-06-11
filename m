Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8ABC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9596F2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391402AbfFKPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:41:16 -0400
Received: from foss.arm.com ([217.140.110.172]:36298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390823AbfFKPlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:41:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BA47337;
        Tue, 11 Jun 2019 08:41:15 -0700 (PDT)
Received: from c02tf0j2hf1t.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793AC3F246;
        Tue, 11 Jun 2019 08:41:11 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:41:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH 2/2] arm64/mm: show TAINT_CPU_OUT_OF_SPEC warning if the
 cache size is over the spec.
Message-ID: <20190611154105.GE10165@c02tf0j2hf1t.cambridge.arm.com>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
 <20190611151731.6135-3-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611151731.6135-3-msys.mizuma@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:17:31AM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Show the warning and taints as TAINT_CPU_OUT_OF_SPEC if the cache line
> size is greater than the maximum.

In general the "out of spec" part is a misnomer, we tend to apply it to
CPU features that are not supported by the kernel rather than some CPU
feature not compliant with the architecture (we call the latter errata).

I suggest you drop this patch.

-- 
Catalin
