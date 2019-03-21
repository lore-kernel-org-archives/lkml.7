Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F406C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0549F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553195115;
	bh=WT06vey0q19Q/07yyxW+oyzM4dYgj1oI4z3SGxt91rM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yOAD2zb4hlHmPOQQCObH+Ltkiiqr2aDdZoqHzhm+lMxWFYVl+cewvZr3YIEosMre3
	 FQx95teCYZSelmRZCv3UnG1Mjjet0PkzX6fJvs0rHjo9iERmiK0Q4yk8uSXVMjsimN
	 16APU6i6bCH2MRicooOrN00CMOQtqngc/l48hYzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfCUTFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbfCUTFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:05:11 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553195111;
        bh=WT06vey0q19Q/07yyxW+oyzM4dYgj1oI4z3SGxt91rM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EdcY+h6+IbZTOFi9qgQF8JZLysMKvkRn2RdwoCRCyexMbgjAxUvB8zjkd6iQ2yYuA
         TCWc6m/CJhUKhAyllHrKA+dDDJ11rtKdSndjmE4mkm5wPFXyzCRkLpcSAlxm4EU69v
         EfWz7nW9UdTUxeKHQju2si48q6mgwmCSPRlvsXds=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190321173817.GA62913@arrakis.emea.arm.com>
References: <20190321173817.GA62913@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190321173817.GA62913@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: e5a5af7718610c819c4d368bb62655ee43a38011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d92da1fbb72490f999b7d0e809d13d0d52dc78ac
Message-Id: <155319511134.18000.287163132890245443.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Mar 2019 19:05:11 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Mar 2019 17:38:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d92da1fbb72490f999b7d0e809d13d0d52dc78ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
