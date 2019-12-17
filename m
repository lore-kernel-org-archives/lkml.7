Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37224672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576610417;
	bh=NDKeryPqubm+d0ft0C++dCI1kj7Mc+AXZ/frfhaIW4M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M2ImoNm6QEs2sXngh+OjhGbE0SlJb+Dvw6vTN9Qd4TdVwh3/MbwzrFYMdc0RfHcJd
	 UuFq8kS/bzS3AzS/v4EOX7qniz8Ez+BvI27FUVTNS9NUHfeqcMloTBkFQoQhALfJ9K
	 B3+HVsiYZajMb5u+T9c/+9FoOOH5homMV6DfYXIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLQTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQTUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:14 -0500
Subject: Re: [GIT PULL] locking fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610414;
        bh=NDKeryPqubm+d0ft0C++dCI1kj7Mc+AXZ/frfhaIW4M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S/HGEldRTETo4EugPRbVshdxTXX1PmoVYjQu6YFU3czsHXa+ospIqTb61vLAkgIT0
         ZrcvbeCvVCGbIVUTJqghNWFn04IEDOV+SybsegkNb0brVInjSoViby7Te1jq/Gy7cm
         4GX4fQZDnuSB3NO+EWVo6DKyiJkFFoyHLUiGpkrY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217112719.GA123630@gmail.com>
References: <20191217112719.GA123630@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217112719.GA123630@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: c571b72e2b845ca0519670cb7c4b5fe5f56498a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e8a0d5ff8408b1e54be0546df0b2ca9d04264cd
Message-Id: <157661041421.14288.2212457192876473208.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:27:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e8a0d5ff8408b1e54be0546df0b2ca9d04264cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
