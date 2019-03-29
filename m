Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2844C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B010A2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfC2VMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:12:09 -0400
Received: from namei.org ([65.99.196.166]:59266 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfC2VMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:12:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2TLC7IW009773;
        Fri, 29 Mar 2019 21:12:08 GMT
Date:   Sat, 30 Mar 2019 08:12:07 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL][UPDATED] security: yama and LSM config fixes
In-Reply-To: <alpine.LRH.2.21.1903300509370.689@namei.org>
Message-ID: <alpine.LRH.2.21.1903300811170.5953@namei.org>
References: <alpine.LRH.2.21.1903300509370.689@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these fixes for v5.1.

The following changes since commit 8c7ae38d1ce12a0eaeba655df8562552b3596c7f:

  afs: Fix StoreData op marshalling (2019-03-28 08:54:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1-a

for you to fetch changes up to 2623c4fbe2ad1341ff2d1e12410d0afdae2490ca:

  LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig" (2019-03-29 14:08:49 -0700)

----------------------------------------------------------------
Jann Horn (1):
      Yama: mark local symbols as static

Kees Cook (1):
      LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"

 security/Kconfig         | 38 ++++++++++++++++++++++++++++++++++++++
 security/yama/yama_lsm.c |  8 ++++----
 2 files changed, 42 insertions(+), 4 deletions(-)
