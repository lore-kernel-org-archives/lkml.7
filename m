Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D06C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7735421841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560529208;
	bh=YSjErc7PG0zYq9LWy32CF1nC6yzHgA3XMXyS3+NrZzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PCkqW+Eah+fj3bC24elsQFO+EqpESZvXdNbZHtvWxQx5ZKSw7VZwOgQCkGTNDIrmW
	 VQBLoU9S+ck8jIDW+Q4AH2rdF2IrlvnMB/X+8RFdWOZo9ZchcOFJaiW1SAT9L0Z7Wj
	 qOuHGLkt6yv6xZhQB/xdjjW1Kd2tkCnGvn4dO/nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFNQUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFNQUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:20:06 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560529206;
        bh=YSjErc7PG0zYq9LWy32CF1nC6yzHgA3XMXyS3+NrZzU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=THxE7Y0ZBeZdlL9DlgYmmOGEe6VsBHxjzQ15etYEMSHVOaY7voqY6EtDIuMOtbWIy
         3mvSAe9Xpr6eU8QJu3ZHcUm4yVK0vuDvOY/WBJpvAcCLZeXFkLAX9F5Cq6P6gZ03N4
         5yqomUActKDQOdZKP+pTc195UzO5LR8/RJW/LwK4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190614150259.GC29231@fuggles.cambridge.arm.com>
References: <20190614150259.GC29231@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190614150259.GC29231@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 41040cf7c5f0f26c368bc5d3016fed3a9ca6dba4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72a20cee5d99d231809ee4d3d2c09a96a25451e2
Message-Id: <156052920631.12738.3532002147631387577.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jun 2019 16:20:06 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 16:02:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72a20cee5d99d231809ee4d3d2c09a96a25451e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
