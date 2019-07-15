Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB090C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B721655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563150619;
	bh=HZoYn2+uheIa1RwUTP6rzrmJiKVQiN4EHyhGCQR83dc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=v4upLoK1XW+caMJcyy35iYMONeVuXFg7J/0kJC/Iu/5X4Vo7RZ4ihIBrNnVox6nUi
	 WfYDITOmQaGwfeSp0YQjh+wRCMm5P13ke9No4vfcxjVtlEPk/ELmg9+SA0IClZvBn+
	 f9gMaHhI4bGgUAvO08xpSJeQ1hkWlKGjYdom5SYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfGOAaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfGOAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:17 -0400
Subject: Re: [GIT PULL] UML changes for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150617;
        bh=HZoYn2+uheIa1RwUTP6rzrmJiKVQiN4EHyhGCQR83dc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HHCZL7+NmmFjAizwm0Tqe2nxlLviaVBeHdB1y3dRnjTQCnxbLjNmPyR8ttLibHJpo
         7DECiPIjIScUhbGtbw9F4z3yIt4rRfAVxdGpT7jULPhTBmi3hAjJlFcvxNUutBmden
         MSzgZrc5yzfOWoKPidVF6EkbSZh5Q4qFPto87I1c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1979519421.38685.1563130920671.JavaMail.zimbra@nod.at>
References: <1979519421.38685.1563130920671.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1979519421.38685.1563130920671.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.3-rc1
X-PR-Tracked-Commit-Id: b482e48d29f1461fd0d059a17f32bcfa274127b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2772a0e4833d1af1901b6f1a38136fb71d1350c
Message-Id: <156315061715.32091.3262692367550162371.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:17 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 21:02:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2772a0e4833d1af1901b6f1a38136fb71d1350c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
