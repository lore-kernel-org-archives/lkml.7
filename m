Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B258C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F42166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557856217;
	bh=ya3JMMh00IKEsS7oUCfYw1X6QIxxjZunEQhizoLuqJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GZqkx/3Vg6w0TzY3tLYbzz5DLiWakgSXPt32QZ5BR7SjkyAByA1o7lisl9PuRdVsm
	 ugmyyaDNIShnQ/edAtPves4WZa7AhKNgWfbDvkEPOXAnc7mfUlMlZJgoqrnMs+wXdz
	 OZS7KvNswb28GU/f48GmPM5xsQN5aSSFz9IOtbn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfENRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfENRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:50:15 -0400
Subject: Re: [GIT PULL] PCI changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557856215;
        bh=ya3JMMh00IKEsS7oUCfYw1X6QIxxjZunEQhizoLuqJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XHNK+blq7Slq6BhEzYuajQzV1kABvHICgc+z4GRZHvER7THbaKfEC1HZGqLxCfWpw
         tJjhpMg54jk3N18s0gSDuc8mv6whmpYNKR3ooXWquvtTeH5TtIkV9axWOINNUCZ0+D
         fQBnIVs5RQK5iLY5IA9RI/D1NON1clc/tlnbxfHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513235721.GA157967@google.com>
References: <20190513235721.GA157967@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513235721.GA157967@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.2-changes
X-PR-Tracked-Commit-Id: c7a1c2bbb65e25551d585fba0fd36a01e0a22690
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 414147d99b928c574ed76e9374a5d2cb77866a29
Message-Id: <155785621504.23900.1392426879614602636.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:50:15 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 18:57:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.2-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/414147d99b928c574ed76e9374a5d2cb77866a29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
