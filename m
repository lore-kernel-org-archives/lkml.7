Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA3C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F592214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLMXsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:48:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:56595 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfLMXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:48:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 15:48:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="388836434"
Received: from spandruv-mobl.jf.intel.com ([10.255.89.247])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2019 15:48:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, corbet@lwn.net, lenb@kernel.org,
        rui.zhang@intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] ACPI / Fan: Performance states
Date:   Fri, 13 Dec 2019 15:48:38 -0800
Message-Id: <20191213234840.9791-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Modified the presentation of performance state attributes
- Change the documentation to RST format

Srinivas Pandruvada (2):
  Documentation: ACPI: Documentation for Fan performance states
  ACPI / fan: Display fan performance state information

 .../acpi/fan_performance_states.rst           | 65 +++++++++++++
 Documentation/admin-guide/acpi/index.rst      |  1 +
 drivers/acpi/fan.c                            | 96 +++++++++++++++++--
 3 files changed, 154 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/acpi/fan_performance_states.rst

-- 
2.17.2

