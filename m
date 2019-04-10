Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63114C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50F2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfDJLVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:21:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:29685 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbfDJLVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:21:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 04:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="133051398"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.146])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2019 04:21:10 -0700
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        jpoimboe@redhat.com, keescook@chromium.org, jannh@google.com,
        enrico.perla@intel.com, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org,
        gregkh@linuxfoundation.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/1] v2, randomize stack offset upon syscall
Date:   Wed, 10 Apr 2019 14:21:02 +0300
Message-Id: <20190410112103.15170-1-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patch since the first attempt never made
it to lkml.

changes in v2:
 - alloca() is changed to __builtin_alloca() in order
   to be compatible with 32 bit versions

Elena Reshetova (1):
  x86/entry/64: randomize kernel stack offset upon syscall

 arch/Kconfig            | 15 +++++++++++++++
 arch/x86/Kconfig        |  1 +
 arch/x86/entry/common.c | 13 +++++++++++++
 3 files changed, 29 insertions(+)

-- 
2.17.1

