Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A003C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4191E206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235716;
	bh=m6SkJTcA1pq9MpGhsuoTbbwoCSVG04Al3Xdqo4EcSyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mQF7b/tO1h6UYp41LplZ4HHWJt66x7PtvmsycW+ysq3biGeg2dmPHGHnJgniUMt5Q
	 QMJKvLXZvMlqxHNspC1ymLsKsl3AucKVgLm+l4jfidFthcs2rPJzm6TTDLa7E3uRzP
	 T5qCzduXK91Vw4t3t3EB0f1waTyOZDviuuuRNijc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfKHRzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbfKHRzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:10 -0500
Subject: Re: [GIT PULL] Modules fix for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235709;
        bh=m6SkJTcA1pq9MpGhsuoTbbwoCSVG04Al3Xdqo4EcSyc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UttsixEEPkQc+Qjzfdk7/5XhsQ8tigQfl/oKr3QL+MEMCpW1Z35gPKP2ykJKj9NMU
         jOX8gPBGffYNhWQZ2a9BNxuh3Vc/9+kQQIzjnNosVjN5Pk7z9NHZG8Dv3CdjtJouaN
         d/qgw/j61EgI1SR544Ab6xa4lquUqG/I3VsjLp2A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108150541.GA27264@linux-8ccs>
References: <20191108150541.GA27264@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108150541.GA27264@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4-rc7
X-PR-Tracked-Commit-Id: 57baec7b1b0459ef885e816d8c28a9d9a62bb8de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6737e763495185999b073303bf58a49ca0b1e64d
Message-Id: <157323570982.12598.6715988357800717565.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:09 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 16:05:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6737e763495185999b073303bf58a49ca0b1e64d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
