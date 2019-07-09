Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A31C48BE9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D930220844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGILck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:32:40 -0400
Received: from namei.org ([65.99.196.166]:34316 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfGILck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:32:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x69BWdlJ014294;
        Tue, 9 Jul 2019 11:32:39 GMT
Date:   Tue, 9 Jul 2019 04:32:39 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] LSM: capabilities updates for v5.3
Message-ID: <alpine.LRH.2.21.1907090427070.13953@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these minor fixes for capabilities:

  o Update the commoncap.c code to utilize XATTR_SECURITY_PREFIX_LEN, 
    from Carmeli tamir.

  o Make the capability hooks static, from Yue Haibing.

---
The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lsm

for you to fetch changes up to c5eaab1d131d0a6272df7d55a971a67400d63f56:

  security/commoncap: Use xattr security prefix len (2019-07-07 14:55:54 +1200)

----------------------------------------------------------------
Carmeli Tamir (1):
      security/commoncap: Use xattr security prefix len

YueHaibing (1):
      security: Make capability_hooks static

 security/commoncap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
