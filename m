Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7AC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E7D218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552771526;
	bh=D7XQSY07+HWJMWfEdqVUp20+WyAo6t+KLLs2rVGIYk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mp2xti+IycWFEbsyJq9dbZH8WFf8nGMg1nAXA2KpPwEnCeFpPgRxSFuUVPa79Sayy
	 boHQibZEzJ/sSwmdFnLcJ/YsK+YB6XRMTo2eEQztli5lNWvYA5bTI5Z4Q4b27XdcnI
	 fJ69vPLgas9sitgDzOOxIpzE3dNABNNOmV8cRbQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfCPVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPVZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:25:18 -0400
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552771517;
        bh=D7XQSY07+HWJMWfEdqVUp20+WyAo6t+KLLs2rVGIYk0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aTydi4j0+Z/ATpgjtSfoJY02ObwM1COmZ8C9OkdaaV/fcAV49YIwCMjCgUlYBDrFd
         oNiceszYn2hfDb+AOgBwf47doXgXjoy9o9yWJPqekdxakUFhQ69/AQN5CVpmYzSpiF
         6EwFNgy1KQuvloMtOieT8OcECxvbvG3qCoybhWVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/devdax-for-5.1
X-PR-Tracked-Commit-Id: c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f67e3fb4891287b8248ebb3320f794b9f5e782d4
Message-Id: <155277151790.28247.13079414442798739990.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Mar 2019 21:25:17 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 12:54:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/devdax-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f67e3fb4891287b8248ebb3320f794b9f5e782d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
