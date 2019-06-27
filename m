Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFCC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74389204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0GNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:13:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF0GNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:13:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="313685026"
Received: from pg-eswbuild-angstrom-alpha.altera.com ([10.142.34.148])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 23:13:41 -0700
From:   "Ong, Hean Loong" <hean.loong.ong@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hean.loong.ong@intel.com, chin.liang.see@intel.com,
        Ong@vger.kernel.org
Subject: [PATCHv1] ARM64: defconfig: Adding LEDS_TRIGGERS_TIMER
Date:   Thu, 27 Jun 2019 22:07:08 +0800
Message-Id: <20190627140709.707-1-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to add LEDS_TRIGGERS_TIMER for blinking LED controls 
upon simple boot upon ARM devices

Ong, Hean Loong (1):
  ARM64: defconfig: Add LEDS_TRIGGERS_TIMER for blinking leds

 arch/arm64/configs/defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

