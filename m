Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ADAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D721743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368530;
	bh=V8oXQxfmqp7qCQuqH/9/wYJ5mskVhb6yYv8o1W+SQco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pKY+8TtJJlDSJxp2iEzO7EXr3nAk3dnqbSPpwKmObS2R9V/NGPtxBkpcQeh0lCcek
	 sRfRMptYdgmnraYPdTKQmAccSc+1hAEF52G5CRohUAxO3bB8OoXzYsmS6ja+jaEBAW
	 OwQrQojY3XOIcOcH2LLqJfDSbIS/N5yRODEosDyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437416AbfHIQfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437336AbfHIQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:11 -0400
Subject: Re: [GIT PULL] pwm: Fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368510;
        bh=V8oXQxfmqp7qCQuqH/9/wYJ5mskVhb6yYv8o1W+SQco=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qQrpvHaQlvPuGW0ScxrhwIjGnrEetCe0/kf6/TXUxWSXEtF6iXATcVa5oSUUqy4Tt
         jWYqTmIVfQMxAGlhsxiM3P1eU/fsBks+of24+Yh9VIaeX+XKGxA0kOZw2XRIbLPzU3
         re1QC3RcpShlnJYiu+2u92pG7UoVQh27s/RQGEOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809134848.18297-1-thierry.reding@gmail.com>
References: <20190809134848.18297-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809134848.18297-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.3-rc4
X-PR-Tracked-Commit-Id: 6cf9481b440da6d6d86bd8e4c99a8b553b9d1271
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c808f2ad8fcddb856ce42901cd5b4f06f9da9184
Message-Id: <156536851085.6429.6086666407903295936.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:10 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Aug 2019 15:48:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c808f2ad8fcddb856ce42901cd5b4f06f9da9184

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
