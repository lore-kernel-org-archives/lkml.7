Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EDC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF48D218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfHOI6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:58:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOI6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:58:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3445528;
        Thu, 15 Aug 2019 01:58:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800573F706;
        Thu, 15 Aug 2019 01:58:20 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:58:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/kmemleak: increase the max mem pool to 1M
Message-ID: <20190815085817.GA9352@arrakis.emea.arm.com>
References: <1565807572-26041-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565807572-26041-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:32:52PM -0400, Qian Cai wrote:
> There are some machines with slow disk and fast CPUs. When they are
> under memory pressure, it could take a long time to swap before the OOM
> kicks in to free up some memory. As the results, it needs a large
> mem pool for kmemleak or suffering from higher chance of a kmemleak
> metadata allocation failure. 524288 proves to be the good number for all
> architectures here. Increase the upper bound to 1M to leave some room
> for the future.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
