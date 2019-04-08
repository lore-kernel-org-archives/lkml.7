Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD35920879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDHXHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:07:13 -0400
Received: from namei.org ([65.99.196.166]:60908 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfDHXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:07:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x38N7Aj4020957;
        Mon, 8 Apr 2019 23:07:10 GMT
Date:   Tue, 9 Apr 2019 09:07:10 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [GIT PULL] TPM fixes for v5.1
Message-ID: <alpine.LRH.2.21.1904090905570.20894@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these TPM fixes, from Jarkko:

"These are critical fixes for v5.1. Contains also couple of new selftests 
for v5.1 features (partial reads in /dev/tpm0)."

---

The following changes since commit fd008d1a7a204695f0e5e003af16448bb9c34b7b:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2019-04-07 19:51:09 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1

for you to fetch changes up to 6da70580af9612accf042b37564d73e787af39b4:

  selftests/tpm2: Open tpm dev in unbuffered mode (2019-04-08 15:58:55 -0700)

----------------------------------------------------------------
Jarkko Sakkinen (2):
      tpm: turn on TPM on suspend for TPM 1.x
      KEYS: trusted: allow trusted.ko to initialize w/o a TPM

Tadeusz Struk (3):
      tpm: fix an invalid condition in tpm_common_poll
      selftests/tpm2: Extend tests to cover partial reads
      selftests/tpm2: Open tpm dev in unbuffered mode

Yue Haibing (1):
      tpm: Fix the type of the return value in calc_tpm2_event_size()

ndesaulniers@google.com (1):
      KEYS: trusted: fix -Wvarags warning

 drivers/char/tpm/eventlog/tpm2.c           |  4 +-
 drivers/char/tpm/tpm-dev-common.c          |  9 ++++-
 drivers/char/tpm/tpm-interface.c           | 14 +++----
 include/keys/trusted.h                     |  2 +-
 security/keys/trusted.c                    | 32 +++++++++++----
 tools/testing/selftests/tpm2/tpm2.py       |  5 ++-
 tools/testing/selftests/tpm2/tpm2_tests.py | 63 ++++++++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 21 deletions(-)
