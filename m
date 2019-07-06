Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2FC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451F1206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562434818;
	bh=z5hFh7+m7rcLHJljqqLpOtT6HHmKEupwUrTFWBB+5ic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pr/zRrTAHGucaOzS4lw8SA7FKfCj245FXdzHEbAz+eHRwJsBSA/csMYOrc4gErAKU
	 +/F8DNVfeFsxfdj7Avz9CwL+SVmHZ/tN3wdXui8A4mBwnI2GrQr7K+kNhpN4xP4t0U
	 A+cuVZLduXadnTnL9lKGGcZAcdk+0iYcxcZnjyro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfGFRkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfGFRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:40:07 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562434807;
        bh=z5hFh7+m7rcLHJljqqLpOtT6HHmKEupwUrTFWBB+5ic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I99IjSVnb8TiHXtRlF53UTfzsTlJxVJxX2N16Uo6qnZozyTEao2P9kqI3gO8yOIs9
         YAj7XSsxnapwpjjf9ba/hbxxoILmJrn/bMBVp8i+RNM0QdAjgBnQZ1A8FYoKWjKUbx
         v/+swV7TkE48/yU6gNKHjbtE7vHsYQJ+tFqMp9vY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190706162350.4tyzj44jppjb4hwq@pburton-laptop>
References: <20190706162350.4tyzj44jppjb4hwq@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190706162350.4tyzj44jppjb4hwq@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.2_2
X-PR-Tracked-Commit-Id: f2ff671f894151a611eae246a1f25b61d6c0354b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc0e65f47def010d8d1c4cf09bdc698fe061b77
Message-Id: <156243480718.9000.17219757110844120248.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 17:40:07 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 16:23:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.2_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc0e65f47def010d8d1c4cf09bdc698fe061b77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
