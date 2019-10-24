Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4B820684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571912717;
	bh=9ua7zFuiH5fKqiw1gYBXsuFyIEUExKT/bxIiD1Atahs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B4PFPxJ/SBZVpeYrhPNJvwl0O0i6xdhHF4BKO5nkPvd+2NZ17sQ20/9Os0/nmmssd
	 N5KPf4SM6HiDgvowowA2L45URVAcVF6z+CD61EipqrMlNjHSmKErvSqWJw5zZQbxQT
	 9NTEJnzZyoeapDcLmaNGrsCq9r6165Nx6XMginWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438735AbfJXKZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407344AbfJXKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:07 -0400
Subject: Re: [GIT PULL] VFIO fixes for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912707;
        bh=9ua7zFuiH5fKqiw1gYBXsuFyIEUExKT/bxIiD1Atahs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L2IfEz65TP0NqHo5Hqrpgv7zQOOnPpDUHTFUnx1U2wndwn8pg5Y4jdtYpj+TBnbZk
         uxXKb4f5uQ36OZNyzL4bxU4hM2kGdn196NCL0Y8AjAHxk5zf+x5WdouakH5X9EKGay
         YJIzWxrsb9UKND+G4Fl+s27KZ4w3ZJHnLC5r1n+M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023110822.6122562f@x1.home>
References: <20191023110822.6122562f@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023110822.6122562f@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.4-rc5
X-PR-Tracked-Commit-Id: 95f89e090618efca63918b658c2002e57d393036
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64131618e8c8a1d5c1470d4d788214f6d4b43cde
Message-Id: <157191270740.16083.17616593345898198780.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:07 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 11:08:22 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64131618e8c8a1d5c1470d4d788214f6d4b43cde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
