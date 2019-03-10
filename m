Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3022320645
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCJKY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:24:56 -0400
Received: from foss.arm.com ([217.140.101.70]:44372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfCJKY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:24:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1150374;
        Sun, 10 Mar 2019 03:24:55 -0700 (PDT)
Received: from MBP.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A1C3F703;
        Sun, 10 Mar 2019 03:24:54 -0700 (PDT)
Date:   Sun, 10 Mar 2019 10:24:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] arm64 updates for 5.1-rc1
Message-ID: <20190310102444.GA48401@MBP.local>
References: <20190308164221.GA126180@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308164221.GA126180@arrakis.emea.arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 08, 2019 at 04:42:23PM +0000, Catalin Marinas wrote:
> The following changes since commit 6e4933a006616343f66c4702dc4fc56bb25e7b02:
> 
>   irqdesc: Add domain handler for NMIs (2019-02-05 14:37:05 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
> 
> for you to fetch changes up to b855b58ac1b7891b219e1d9ef60c45c774cadefe:
> 
>   arm64: mmu: drop paging_init comments (2019-03-01 16:40:07 +0000)

Were there any issues with this pull request or you haven't got around
to merging it yet?

I forgot to mention but in case it wasn't clear, my branch is based on
5.0-rc3. The irqdesc commit together with 3 more went in via tglx's
irq/core tree (commit a324ca9cad47 "Merge tag 'irqchip-5.1' of
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
irq/core"), hence the "git request-pull" common ancestor above.

Thanks.

-- 
Catalin
