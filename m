Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F9C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8BB20706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFN6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:58:36 -0500
Received: from foss.arm.com ([217.140.110.172]:45418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfLFN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:58:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBEE1FB;
        Fri,  6 Dec 2019 05:58:35 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6686B3F718;
        Fri,  6 Dec 2019 05:58:34 -0800 (PST)
Date:   Fri, 6 Dec 2019 13:58:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/kernel/entry: refine comment of stack overflow
 check
Message-ID: <20191206135832.GG32767@arrakis.emea.arm.com>
References: <20191202113702.34158-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202113702.34158-1-guoheyi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 07:37:02PM +0800, Heyi Guo wrote:
> Stack overflow checking can be done by testing
> sp & (1 << THREAD_SHIFT)
> only for the stacks are aligned to (2 << THREAD_SHIFT) with size of
> (1 << THREAD_SIZE), and this is the case when CONFIG_VMAP_STACK is
> set.
> 
> Fix the code comment to avoid confusion.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Queued with Mark's suggested update.

-- 
Catalin
