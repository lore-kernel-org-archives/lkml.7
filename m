Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42BF20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757208;
	bh=2D2xuqS7v4hWRcI4mDQs+x1kzOOHrzlztuqGVBkTLBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sACpAJ+Zr17qgq6wKYadm9Va3nztf5gdPSJyfHeKYxdmNGAu69nAE5797DSWwrlC5
	 Tk0ks90nKWGdQVxf8SXArRyaf1Yyjd5xLRt47hLcTR+VyTXd5KEuKMmFH7TM3YuX2e
	 zPkwzmuX4WwHHjUk1BS5Enhq3QLOIbh+IJ1KSwU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCEDkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfCEDkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:06 -0500
Subject: Re: [GIT PULL] regmap updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757205;
        bh=2D2xuqS7v4hWRcI4mDQs+x1kzOOHrzlztuqGVBkTLBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SIPR4fqYlRDznwZc4xcJMLpytzSuMTGtCcBsgw3ZpDKzeISpELsfjQg/+8VPutuV9
         oYt1PQXMih7RTH15A7P3CkbnWAHRBM6li1fAJu0ukdfEBHdwht8f/k8zz6RHR74Jc2
         Wb+hq7AOCVRjy+bDRxJfVnDprNLZWO2cNLc8cqO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304161855.GA8877@sirena.org.uk>
References: <20190304161855.GA8877@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304161855.GA8877@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.1
X-PR-Tracked-Commit-Id: 66fb181d6f824f7695417e8c19560c5b57dc8c2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e48b044e4ff3788828e5a40e9c36d12e12fbfcf1
Message-Id: <155175720559.14960.6934639175406335010.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 16:18:55 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e48b044e4ff3788828e5a40e9c36d12e12fbfcf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
