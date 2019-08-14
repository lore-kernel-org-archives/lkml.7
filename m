Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81BF208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfHNIWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:22:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:61546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:22:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="170668862"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 01:22:38 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/2] dt-bindings: serial: lantiq: Convert to YAML & add support for new SoC
Date:   Wed, 14 Aug 2019 16:22:33 +0800
Message-Id: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 converts existing dt bindings txt file to YAML schema.

Patch 2 updates the dt bindings YAML contents to add support for newly supported
Intel Lightning Mountain(LGM) SoC.

These patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Rahul Tanwar (2):
  dt-bindings: serial: lantiq: Convert to YAML schema
  dt-bindings: lantiq: Update for new SoC

 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 --------
 .../devicetree/bindings/serial/lantiq_asc.yaml     | 87 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.yaml

-- 
2.11.0

