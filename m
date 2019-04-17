Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D156C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535D2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfDQLCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:02:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:31037 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfDQLCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 04:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="338273998"
Received: from unknown (HELO xshen14-linux.bj.intel.com) ([10.238.155.105])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2019 04:02:16 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH v2 0/2] Initialize a new resource group with default MBA values
Date:   Wed, 17 Apr 2019 19:08:47 +0800
Message-Id: <1555499329-1170-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change log in v2:
- Boris: Add a preparatory patch to carve out per RDT domain initialization
  code into a separate function. 
- Minor changes in the comments of rdtgroup_init_xxx().
- Boris: s/cpu/CPU/g in the comments of update_domains().
- Boris: Format commit message by indenting the examples.

Xiaochen Shen (2):
  x86/resctrl: Move per RDT domain initialization to a separate function
  x86/resctrl: Initialize a new resource group with default MBA values

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 171 +++++++++++++++++-------------
 2 files changed, 100 insertions(+), 75 deletions(-)

-- 
1.8.3.1

