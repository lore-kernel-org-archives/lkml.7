Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815AAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E05C222C1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfCXK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:28:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:60422 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfCXK2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:28:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 03:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136945739"
Received: from hwang32-mobl.ccr.corp.intel.com ([10.255.30.50])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2019 03:28:04 -0700
Message-ID: <1553423283.14989.6.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.1-rc2
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Date:   Sun, 24 Mar 2019 18:28:03 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal management updates for v5.1-rc2 with
top-most commit 2d7c4e17811f766321b9c054609551fa40f0b445:

  Merge branches 'fixes' and 'thermal-intel' into next (2019-03-18
22:37:44 +0800)

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

Specifics:

- Fix a wrong __percpu structure declaration in intel_powerclamp
driver. (Luc Van Oostenryck)

- Fix truncated name of the idle injection kthreads created by
intel_powerclamp driver. (Zhang Rui)

- Fix the missing UUID supports in int3400 thermal driver. (Matthew
Garrett)

- Fix a crash when accessing the debugfs of bcm2835 SoC thermal driver.
(Phil Elwell)

- A couple of trivial fixes/cleanups in some SoC thermal drivers.

thanks,
rui

----------------------------------------------------------------
Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      thermal: mtk: Allocate enough space for mtk_thermal.

Shaokun Zhang (1):
      thermal: cpu_cooling: Remove unused cur_freq variable

Zhang Rui (2):
      thermal/intel_powerclamp: fix truncated kthread name
      Merge branches 'fixes' and 'thermal-intel' into next

 drivers/thermal/broadcom/bcm2835_thermal.c          |  9 ++++-----
 drivers/thermal/cpu_cooling.c                       |  3 +--
 .../thermal/intel/int340x_thermal/int3400_thermal.c | 21
+++++++++++++++++----
 drivers/thermal/intel/intel_powerclamp.c            |  4 ++--
 drivers/thermal/mtk_thermal.c                       |  7 +++++--
 drivers/thermal/samsung/exynos_tmu.c                |  2 +-
 6 files changed, 30 insertions(+), 16 deletions(-)
