Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3F820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757225;
	bh=JNiGbnRoLvRsq9PJIFX7E/NyPTrQmgVaBRTlHpR8nSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fPkrL3haorJSC/epUdFZ6SiZUEWKncwjC6hEU90gYdrE/5JN5iScxKlpTIDwP6px3
	 ztqursd87n2EU+zL55oS3+DU4d/hiSG2qylJwz32svlW7ZOkKbr7iqlsVUAUXVGb54
	 39GTQYCGtcqrRgf2dnxZqJXy9mdX+iRK2zPytsuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCEDkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfCEDkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:06 -0500
Subject: Re: [GIT PULL] regulator updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757205;
        bh=JNiGbnRoLvRsq9PJIFX7E/NyPTrQmgVaBRTlHpR8nSM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QEXqIIPQAM8xUUVZYyYYIpqPbzcCOn66H4PJSC0NCihRbtwJ0aT+ZhU7hsRfRm9i0
         Ra2/lFt4neYD/Y9RSIrT8ovX13ghRqqbCeSJXSaEb6CsVKhuvrG8YfLfu5Gv2Br2MF
         Jh7CBKBss8v0LAh8EkDST60Yn/7vgkXVIYwwReYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304163415.GB8877@sirena.org.uk>
References: <20190304163415.GB8877@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304163415.GB8877@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.1
X-PR-Tracked-Commit-Id: 88f268a5bcc3b0683e6fbaf9973702e5329fc1e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32c0ac3af49d0cfa05c5d9d77db94e240502b5ef
Message-Id: <155175720592.14960.9351009196269734750.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 16:34:15 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32c0ac3af49d0cfa05c5d9d77db94e240502b5ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
