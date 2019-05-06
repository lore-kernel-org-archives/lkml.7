Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98153C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186047;
	bh=QXxnEiMjqgdYDUrcAGNNpSiZUyhV++GcSFhrW0fvNN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=t8efEeQtzsOug7EqC+V2GQMKv+URh0dsXjnqTF089PQCcp4zMU3vkGZmYd30B1zxO
	 miKmeixQn02K8BI26hyYOuBjCZzOt8OlKTdIm+weZVeXY0qFIYRJpH6YY1Yu2Sm53h
	 PUIjopmphWTpmIoqnTBySQm/Lba9REnzaB053ow0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEFXkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfEFXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:12 -0400
Subject: Re: [GIT PULL] x86/irq changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=QXxnEiMjqgdYDUrcAGNNpSiZUyhV++GcSFhrW0fvNN8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vjJCCIyy4Arn2oU6faTbm6vD59HgT39MdN8YiTIxaGU2sTZxTpHB9+xcKZzDevqR4
         ZvPieOOODX0wI/Hf1XWKXHcdXzQVAo/OE2tJP+ifi+HwVajC65yL08fh7eY01fW7qY
         beVhykcWiRgUtSqu0aWAKSuPT83PhdX6kPH8kHHs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506102742.GA119840@gmail.com>
References: <20190506102742.GA119840@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506102742.GA119840@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus
X-PR-Tracked-Commit-Id: 2c4645439e8f2f6e7c37f158feae6f6a82baa910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f147727030bf9e81331ab9b8f42d4611bb6a3d9
Message-Id: <155718601228.9113.2163655941593937952.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:27:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f147727030bf9e81331ab9b8f42d4611bb6a3d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
