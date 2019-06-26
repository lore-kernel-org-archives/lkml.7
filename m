Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6F6214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFZWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:39:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:38:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313574962"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:38:57 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 01/10] platform/x86: ISST: Update ioctl-number.txt for Intel Speed Select interface
Date:   Wed, 26 Jun 2019 15:38:42 -0700
Message-Id: <20190626223851.19138-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve ioctl numbers for intel Speed Select Technology interface
drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ioctl/ioctl-number.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index c9558146ac58..ab0b3f686454 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -348,3 +348,4 @@ Code  Seq#(hex)	Include File		Comments
 0xF6	all	LTTng			Linux Trace Toolkit Next Generation
 					<mailto:mathieu.desnoyers@efficios.com>
 0xFD	all	linux/dm-ioctl.h
+0xFE	all	linux/isst_if.h
-- 
2.17.2

