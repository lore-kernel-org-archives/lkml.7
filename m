Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE76C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F062184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfC2Lzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:55:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:57366 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfC2Lzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:55:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 04:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="159556097"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.156])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2019 04:55:43 -0700
Date:   Fri, 29 Mar 2019 13:55:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [GIT PULL] tpmdd fixes for Linux v5.1
Message-ID: <20190329115544.GA27351@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

These are critical fixes for v5.1. Contains also couple of new selftests for
v5.1 features (partial reads in /dev/tpm0). I hope these could still reach
the release. Thanks.

/Jarkko

The following changes since commit 8d93e952fba216cd0811247f6360d97e0465d5fc:

  LSM: lsm_hooks.h: fix documentation format (2019-03-26 16:46:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190329

for you to fetch changes up to ada14f61ed5e111523ace5553d152ca89883c0a4:

  tpm: turn on TPM on suspend for TPM 1.x (2019-03-29 13:48:40 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux v5.1

----------------------------------------------------------------
Jarkko Sakkinen (2):
      KEYS: trusted: allow trusted.ko to initialize w/o a TPM
      tpm: turn on TPM on suspend for TPM 1.x

Tadeusz Struk (3):
      selftests/tpm2: Open tpm dev in unbuffered mode
      selftests/tpm2: Extend tests to cover partial reads
      tpm: fix an invalid condition in tpm_common_poll

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
