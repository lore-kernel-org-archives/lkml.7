Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEDC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7284A2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfFTLRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:17:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:57760 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfFTLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 04:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="311627870"
Received: from liujing-dell.bj.intel.com ([10.238.145.70])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 04:17:51 -0700
From:   Jing Liu <jing2.liu@linux.intel.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jing2.liu@intel.com,
        jing2.liu@linux.intel.com
Subject: [PATCH RFC] kvm: x86: AVX512_BF16 feature support
Date:   Thu, 20 Jun 2019 19:21:51 +0800
Message-Id: <1561029712-11848-1-git-send-email-jing2.liu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch focuses on a new instruction AVX512_BF16 support for kvm guest, defined
as CPUID.(EAX=7,ECX=1):EAX[bit 5], see spec[1].

The kvm implementation depends on kernel patch[2] which is in lkml discussion.

References:
[1] https://software.intel.com/sites/default/files/managed/c5/15/\
    architecture-instruction-set-extensions-programming-reference.pdf
[2] https://lkml.org/lkml/2019/6/19/912

Jing Liu (1):
  kvm: x86: Expose AVX512_BF16 feature to guest

 arch/x86/kvm/cpuid.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
1.8.3.1

