Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2184C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79CE2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCSOas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:30:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:56716 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfCSOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:30:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 07:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="123947027"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 07:30:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2131011F; Tue, 19 Mar 2019 16:30:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] extcon: Introduce support of Basin Cove PMIC
Date:   Tue, 19 Mar 2019 16:30:40 +0200
Message-Id: <20190319143042.66606-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Merrifield platforms the Basin Cove PMIC responsible for USB DR
detection among other things.

Here is the extcon driver to support USB DR and charger detection.

Since v2:
- rebase on top of extcon-next
- update copyright year
- address most of Chanwoo's comments
  (rest is left in similarity with other Intel extcon drivers)

Andy Shevchenko (2):
  extcon: intel: Split out some definitions to a common header
  extcon: mrfld: Introduce extcon driver for Basin Cove PMIC

 drivers/extcon/Kconfig               |   7 +
 drivers/extcon/Makefile              |   1 +
 drivers/extcon/extcon-intel-cht-wc.c |  21 +-
 drivers/extcon/extcon-intel-mrfld.c  | 284 +++++++++++++++++++++++++++
 drivers/extcon/extcon-intel.h        |  20 ++
 5 files changed, 319 insertions(+), 14 deletions(-)
 create mode 100644 drivers/extcon/extcon-intel-mrfld.c
 create mode 100644 drivers/extcon/extcon-intel.h

-- 
2.20.1

