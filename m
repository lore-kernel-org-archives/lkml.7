Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB8C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E52083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600818;
	bh=U23Fsk2NX+vv8L/g9KkqElrn6QEPwPPTDnaiOXhUWhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TLZlUcCQzbSzCGCVQKHP4t+sE/U2KH+XSPMt0jO8XGkEDxeycWX2wHOzRbrvz+Xpk
	 XZq5NreVqfSaeZNr/yuudTzfKFHuKpTQfx7Dc/pw+2h54fjwS2yOhTZuEgdc0CUdYp
	 Cy9XKQXB57csXXx+jgm7XykxAUUqMGYBHv1ivNY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfDRPUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389538AbfDRPUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:20:06 -0400
Subject: Re: [GIT PULL] s390 patches for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600805;
        bh=U23Fsk2NX+vv8L/g9KkqElrn6QEPwPPTDnaiOXhUWhQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xPhiDq3A4sr11CEjt+pK5icOtIJBr7qVuxytIi0t0wgvRf9pPX5pTaCVBCgsem59d
         gHzOFjrKjfub2PV4YkO0VrOGy5OH02jzGEg+s800ykcNkAEPqaEY2pJX3ByZQcdu5t
         I0pCJGBtIfIhwlrldAeba7cSg2jHjkn8LSp+M/Gc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190418164733.798aa386@mschwideX1>
References: <20190418164733.798aa386@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190418164733.798aa386@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.1-3
X-PR-Tracked-Commit-Id: 35af0d469c6694c05f06e75c5d75caee9be66122
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d22113a2cd1f908e0e4809aa101542b02fb2abc2
Message-Id: <155560080552.14770.17896343530438068771.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Apr 2019 15:20:05 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Apr 2019 16:47:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d22113a2cd1f908e0e4809aa101542b02fb2abc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
