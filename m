Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C02321734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfKAPxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:53:42 -0400
Received: from foss.arm.com ([217.140.110.172]:37790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKAPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:53:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2ED328;
        Fri,  1 Nov 2019 08:53:41 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4E853F719;
        Fri,  1 Nov 2019 08:53:40 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:53:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Julien Grall <julien@xen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH] docs/arm64: cpu-feature-registers: Rewrite bitfields
 that don't follow [e, s]
Message-ID: <20191101155338.GG17207@arrakis.emea.arm.com>
References: <20191101152022.8853-1-julien@xen.org>
 <20191101153803.GC3287@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101153803.GC3287@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:38:04PM +0000, Will Deacon wrote:
> On Fri, Nov 01, 2019 at 03:20:22PM +0000, Julien Grall wrote:
> > From: Julien Grall <julien.grall@arm.com>
> > 
> > Commit "docs/arm64: cpu-feature-registers: Documents missing visible
> > fields" added bitfiels following the convention [s, e]. However, the
> 
> typo: bitfiels
> 
> > documentation is following [s, e] and so does the Arm ARM.
> 
> This should be [e, s], although I think you can spell it out as "end" and
> "start" so people know what this is doing.

Thanks. I'll make the changes locally.

-- 
Catalin
