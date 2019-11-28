Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217021771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfK1IIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:08:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:29597 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1IIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:08:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 00:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="217548709"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2019 00:08:36 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linus.walleij@linaro.org
Cc:     torvalds@linux-foundation.org, sfr@canb.auug.org.au,
        andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-next@vger.kernel.org,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/1] pinctrl: pinctrl-v5.5-1: Fix build warning
Date:   Thu, 28 Nov 2019 16:08:31 +0800
Message-Id: <20191128080832.13529-1-rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus Walleij,

This patch fixes a build time warning seen with my below commit
1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
after "Bulk pin control changes for v5.5" were pulled in.

Request to please push this patch to Linus.

Patch is based on 'pinctrl-v5.5-1' tag of linux-pinctrl.git tree.

Rahul Tanwar (1):
  pinctrl: Fix warning by adding missing MODULE_LICENSE

 drivers/pinctrl/pinctrl-equilibrium.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.11.0

