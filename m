Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4891121744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfLEDBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:01:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:38152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbfLEDBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:01:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 19:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="219087597"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 19:01:33 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linus.walleij@linaro.org
Cc:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/1] pinctrl: pinctrl-v5.5-2: Fix linker error
Date:   Thu,  5 Dec 2019 11:01:30 +0800
Message-Id: <cover.1575514110.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix linker error seen with 5.5 linux-next tree caused by below commit
1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC").

Patch is based on 'pinctrl-v5.5-2' tag of linux-pinctrl.git tree.

Rahul Tanwar (1):
  pinctrl: Modify Kconfig to fix linker error

 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.11.0

