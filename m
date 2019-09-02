Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA721670
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfIBObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:31:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:47430 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfIBObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:31:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 07:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="183321293"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2019 07:31:22 -0700
Date:   Mon, 2 Sep 2019 17:31:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org
Subject: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A new driver for fTPM living inside ARM TEE was added this round. In
addition to that, there is three bug fixes and one clean up.

/Jarkko

The following changes since commit 8fb8e9e46261e0117cb3cffb6dd8bb7e08f8649b:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-08-30 09:23:45 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190902

for you to fetch changes up to e8bd417aab0c72bfb54465596b16085702ba0405:

  tpm/tpm_ftpm_tee: Document fTPM TEE driver (2019-09-02 17:08:35 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.4

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Remove a deprecated comments about implicit sysfs locking

Lukas Bulwahn (1):
      MAINTAINERS: fix style in KEYS-TRUSTED entry

Sasha Levin (2):
      tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE
      tpm/tpm_ftpm_tee: Document fTPM TEE driver

Stefan Berger (2):
      tpm_tis_core: Turn on the TPM before probing IRQ's
      tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts

 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/security/tpm/index.rst               |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst        |  27 ++
 MAINTAINERS                                        |   2 +-
 drivers/char/tpm/Kconfig                           |   5 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm-chip.c                        |   7 +-
 drivers/char/tpm/tpm-sysfs.c                       |   7 -
 drivers/char/tpm/tpm_ftpm_tee.c                    | 350 +++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h                    |  40 +++
 drivers/char/tpm/tpm_tis_core.c                    |   3 +
 11 files changed, 432 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
