Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D99214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556149207;
	bh=LmXnlvwCJYCyLA4xLWEP62hzPXWnDZIaUAQaFIdXqqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k3MAg0d05qPz6MYH+h1zA+aNDGEetTcETNxlP9yQmUwcuUXlQGyv4tN6ENp2/0SaM
	 +LGdXx2C6akRC6/J0T4qxGVjjy1mLE55lftiPBrRBZB3vNi4BzHGkfeuhEQGoTedEN
	 Uh1xr3Mi7ddBzAa+8n6ME55iTi1V3PHEz9RhdTBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfDXXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbfDXXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:40:05 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556149204;
        bh=LmXnlvwCJYCyLA4xLWEP62hzPXWnDZIaUAQaFIdXqqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fj5Rw2/t3oEamY1/5hMeyuv/uFI86yGke4FhkXNvBTErHHvbLqtNPK+eLtvMu5yOQ
         0CX/Sn7mBgaNdPDh+4LG6Jg2tUAGL28jbX6iygbF3843mvUM45uute0Xkf6v84MyHp
         weID91bB5OalSYxag2MgoKzxKakKo4u6Tr+vFVz4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190424.151129.189814637915490695.davem@davemloft.net>
References: <20190424.151129.189814637915490695.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190424.151129.189814637915490695.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 20ff83f10f113c88d0bb74589389b05250994c16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd8dead0c39457e58ec1d36db93aedca811d48f1
Message-Id: <155614920489.7038.3957702774173564653.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Apr 2019 23:40:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Apr 2019 15:11:29 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd8dead0c39457e58ec1d36db93aedca811d48f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
