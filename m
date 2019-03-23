Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD60C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC56720880
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553364012;
	bh=7f+FtiUOEJMkCbs9GSV+y+QCCmiMEd1nybg1uSsbwB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ovMjDHuwLHhnx4P51OB4oPGGFKR22ELhopqgPh4XlHhQKDlZX38I3N8nuzqUwZxFO
	 aM2P7Q77pN4SdYcvAvaf5qFmDO4akLKu12o0JLqtCZNvm6iTyDpiaKY1YJKNrgM9Hr
	 G2b42S+55pjAd7ZzgGXPGT+iKW0bG69VkO5dTI3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfCWSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfCWSAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 14:00:11 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553364010;
        bh=7f+FtiUOEJMkCbs9GSV+y+QCCmiMEd1nybg1uSsbwB4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kmJ+JfpDdAcmtE2RbvzDTct2Qhj+O38AP49GfvTlZ/ZpmaXD9hmqfdwIsUdY8KAtl
         Le4PfMiPlGtPk8UJnRhljFHI7gZdSeY+9QrK+IKrIi3PpCnxFtBfi3JQEWEsyqnqX+
         TxqJlgGsT2SSEB5FuadQAsl2TNrzMoV8M7730cX8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190322161947.15053-1-idryomov@gmail.com>
References: <20190322161947.15053-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190322161947.15053-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.1-rc2
X-PR-Tracked-Commit-Id: 9d4a227f6ef189cf37eb22641f6ee788b7dc41bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a1050ad83e2a5db84436b11e10facd7d4a5ab26
Message-Id: <155336401069.30785.14034131973826438504.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Mar 2019 18:00:10 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 17:19:47 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a1050ad83e2a5db84436b11e10facd7d4a5ab26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
