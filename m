Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC9C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B5F21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557283218;
	bh=gXo79XzPzH7ksKQt/v7qwBPzCp8whnJR8uHL6evR7ic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YwCr8362U/Zqx7qgp+EKgz/l5lqktppI0YCRDRYplATHxJVbJTlrn4DRjMyRYVfVG
	 TQVuMUWCSPdnefd+26/DBqNl+xTdIDXpVBB5rzHEJS7YhjdfX050Ysf5ZxX4U4Ia2x
	 eEWtTClTbx3KILTAicXMY6pu2Oi3Xnc3xxUAYnJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEHCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfEHCkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:40:13 -0400
Subject: Re: [GIT PULL] Audit patches for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283213;
        bh=gXo79XzPzH7ksKQt/v7qwBPzCp8whnJR8uHL6evR7ic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fGOnHKKY54owP2JxR/ALCwL3gWx/u//Z4hNaDBS9a+zkt7MqWs88B/41ohoiE1aIE
         /ieATh2jsQvu9hLpwQxapMt+y0ceorY9ds/dgrZFUfL+uMnem8331l/pXQLjA1A9Gj
         +i2UgW3NeVIoh5+Qp/ROhhsTxGY7fhHRuRtOJ2jY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQ8aEqiKo6oj8-qMTzbs73ipEbTf5akENYc-m6xg7JRXg@mail.gmail.com>
References: <CAHC9VhQ8aEqiKo6oj8-qMTzbs73ipEbTf5akENYc-m6xg7JRXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQ8aEqiKo6oj8-qMTzbs73ipEbTf5akENYc-m6xg7JRXg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20190507
X-PR-Tracked-Commit-Id: 70c4cf17e445264453bc5323db3e50aa0ac9e81f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02aff8db6438ce29371fd9cd54c57213f4bb4536
Message-Id: <155728321338.19924.590432199264381915.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:13 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:23:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02aff8db6438ce29371fd9cd54c57213f4bb4536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
