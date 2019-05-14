Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D728FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A609220873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865513;
	bh=NJCVrEGhRtkVbEPWKfeunnKoZOPbNR7D1pgnMVpmTJk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FuXvaOfYnggmAMmkbAL3LxqB2Ser7rXNINo5IBCOZj5+FOyL0BO8JPdw208vefdqf
	 fl431w39lJ5nDMEQTkWuTOgNRoyuy+ATbIbD+y2MeIyovYSKIJlzfoD1D9oNxuGKqm
	 Fgxka+Gehwbbir3FN2Zr2ghF6viN8VGEC324btv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfENUZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfENUZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:25:05 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884DB2166E;
        Tue, 14 May 2019 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557865504;
        bh=NJCVrEGhRtkVbEPWKfeunnKoZOPbNR7D1pgnMVpmTJk=;
        h=From:To:Cc:Subject:Date:From;
        b=XtfKPjB5RRK820tIaOu65waeznxxdSZ8xw+WU1hsK0yANhaMI+k/eWfV8PeBc9VSn
         VVzIFOdII3Cc6oUhY8Xpw9PsqNtqnWmpQxb0ZXqrWFArfJceuE6rIuEmtcOTiMmT0W
         WckyK17uRa9YIAutnG6LtFCJTE0jqpUFLVNlrYvM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] x86/speculation/mds: Minor fixes
Date:   Tue, 14 May 2019 13:24:38 -0700
Message-Id: <cover.1557865329.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first I heard of MDS was today.  Let's fix the problems I noticed
right away.

Andy Lutomirski (2):
  x86/speculation/mds: Revert CPU buffer clear on double fault exit
  x86/speculation/mds: Improve CPU buffer clear documentation

 Documentation/x86/mds.rst | 44 ++++++---------------------------------
 arch/x86/kernel/traps.c   |  8 -------
 2 files changed, 6 insertions(+), 46 deletions(-)

-- 
2.21.0

