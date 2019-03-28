Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AC72173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfC1Mls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:41:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:34145 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfC1Mgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="156023572"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2019 05:36:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CE1F2217; Thu, 28 Mar 2019 14:36:33 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 02/36] thunderbolt: Remove unused work field in struct tb_switch
Date:   Thu, 28 Mar 2019 15:35:59 +0300
Message-Id: <20190328123633.42882-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is not used anywhere so remove it.

Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 52584c4003e3..8058ea02d572 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -70,7 +70,6 @@ struct tb_switch_nvm {
  * @boot: Whether the switch was already authorized on boot or not
  * @rpm: The switch supports runtime PM
  * @authorized: Whether the switch is authorized by user or policy
- * @work: Work used to automatically authorize a switch
  * @security_level: Switch supported security level
  * @key: Contains the key used to challenge the device or %NULL if not
  *	 supported. Size of the key is %TB_SWITCH_KEY_SIZE.
@@ -105,7 +104,6 @@ struct tb_switch {
 	bool boot;
 	bool rpm;
 	unsigned int authorized;
-	struct work_struct work;
 	enum tb_security_level security_level;
 	u8 *key;
 	u8 connection_id;
-- 
2.20.1

