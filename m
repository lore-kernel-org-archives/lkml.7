Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06692C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA020718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNGmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:42:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:58046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNGmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:42:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 22:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="216645400"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2019 22:42:05 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/2] stm class/intel_th: Updates for v5.5
Date:   Thu, 14 Nov 2019 08:41:59 +0200
Message-Id: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is really small, but I'm including a signed tag anyway. These are
a bugfix and a documentation update. The fix is for a bug in v4.20, and
given that it's late -rc7, it makes more sense to me to queue it for the
merge window, but if you think otherwise, as Linus mentioned the
possibility of an -rc8, it's also good. Stable CC'd on the fix.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-for-greg-20191114

for you to fetch changes up to a5e809f25f41a84b31e17ac9422fb191e2495503:

  intel_th: Document software sinks (2019-11-14 08:20:17 +0200)

----------------------------------------------------------------
stm class/intel_th: Updates for v5.5

These are:
 * a bugfix in stm protocol handling
 * a documentation update for intel_th

----------------------------------------------------------------
Alexander Shishkin (2):
      stm class: Lose the protocol driver when dropping its reference
      intel_th: Document software sinks

 Documentation/trace/intel_th.rst | 28 +++++++++++++++++++++++++++-
 drivers/hwtracing/stm/policy.c   |  4 ++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.24.0

