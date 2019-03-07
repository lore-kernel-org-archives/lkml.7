Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7404FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382D420851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551992122;
	bh=OaZu3Uskvb8ACBhL343K1GfCRhHmhUZDqnc9PD3Z3eY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f3XbaGpvpAUsxtJNp1rVmzDeIrB5N4CRd5CSUT+MQjPc9FN+Vx5jZ2aIze6kQK01f
	 MtdY0TSp6MSWaZ9fEoiE5WIUy1w4dpSMKL8rKN6ZO9q6CFaOb8D1mcp4P2OhDUPmtA
	 LTbglw1YtYFT829fqZjXB+vjXYki8wc7SL2stJ2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCGUzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfCGUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:55:17 -0500
Subject: Re: [GIT PULL] Audit patches for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551992116;
        bh=OaZu3Uskvb8ACBhL343K1GfCRhHmhUZDqnc9PD3Z3eY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QzXPVL+PzNddHi4dKhT5xgq7XQp5Muj1fArW+vGfwFKFH8vq2OVZrtsxkkmwm0GcI
         BQH0jOMIvRVO+kan0KWwy1KYuK6UAP/cmGBvfMrZO0/+/+r8Giaz/IyUVOJD0a3sMy
         fgiuzym4xZn2LxjrYaG1d4777dPywiHYSjllmTcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRzEap1iU0PAMw44oXnjdSoDBb+S8=es0MGfpC2dDGVGA@mail.gmail.com>
References: <CAHC9VhRzEap1iU0PAMw44oXnjdSoDBb+S8=es0MGfpC2dDGVGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRzEap1iU0PAMw44oXnjdSoDBb+S8=es0MGfpC2dDGVGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20190305
X-PR-Tracked-Commit-Id: 131d34cb07957151c369366b158690057d2bce5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be37f21a08ce65c7632c7f45e1755a4b07f278a0
Message-Id: <155199211663.24626.1068384532678243554.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 20:55:16 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 17:35:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20190305

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be37f21a08ce65c7632c7f45e1755a4b07f278a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
