Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D75C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABFB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561682716;
	bh=gkT6EDiC1IMj5K0ix6t8c4nRHIL5axGzqcojCIZCoPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Je3DGE2xekOx7UHULHFLm6jbclzWtItlVq5YwfiwYOctRXHaPRYz7mFDgOyE9V/zh
	 tEQQ77C6MTxzs+uiKCwLEMgxztF8BYVjIs+O+RZ/s/7erjs4mqWuJhQsD9AF94p7+V
	 nPsqpBK1Tlao9lfLCQlQ0i/4xCwzwDxRCqooAYfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF1ApP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfF1ApH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:45:07 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561682706;
        bh=gkT6EDiC1IMj5K0ix6t8c4nRHIL5axGzqcojCIZCoPs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j0Xjonmdz5SMhiwzl+If2pTY1Ip6bWk5U7y4/uhgcMrIfuu+jdExKI2plNIH48GAL
         4x2b3aVkx6vR4HBKwxnjhJnWRSef5+LQiU1W2Aef5KsmtnibEeeOe2neGeZGQhWyHp
         7lGmY23iwCkO8oeHyIkL5Wb37Wf6fO+PVns7opgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1906271134320.27227@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1906271134320.27227@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1906271134320.27227@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: b12bbdc5dd883f6575f57e529af26cd2c521b320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 763cf1f2d9bfc8349c5791689074c8c17edf660d
Message-Id: <156168270680.1895.6288156914906043251.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:45:06 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 11:37:47 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/763cf1f2d9bfc8349c5791689074c8c17edf660d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
