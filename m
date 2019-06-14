Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B9C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00EF2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfFNKUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:20:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfFNKUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:20:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FADF3EF;
        Fri, 14 Jun 2019 03:20:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D72D3F246;
        Fri, 14 Jun 2019 03:22:03 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:20:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
Message-ID: <20190614102017.GC10659@fuggles.cambridge.arm.com>
References: <1560461641.5154.19.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560461641.5154.19.camel@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
> LTP hugemmap05 test case [1] could not exit itself properly and then degrade the
> system performance on arm64 with linux-next (next-20190613). The bisection so
> far indicates,
> 
> BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-next/core'
> GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-next/fixes'

Did you finish the bisection in the end? Also, what config are you using
(you usually have something fairly esoteric ;)?

Thanks,

Will
