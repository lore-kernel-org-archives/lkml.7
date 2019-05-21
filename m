Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BEDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439FE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfEUGfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:35:16 -0400
Received: from olimex.com ([184.105.72.32]:59132 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfEUGfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:35:16 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 02:35:15 EDT
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:25:11 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 0/2] mfd: rk808: Fix pointers and poweroff
Date:   Tue, 21 May 2019 09:24:47 +0300
Message-Id: <20190521062449.29410-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is actually follow-up to:
  [PATCH 1/1] mfd: rk808: Prepare rk8085 for poweroff

The patchset fixes poweroff function for boards with RK8085 PMU.
During the preparation of v2 possible wrong pointer access was
spot (pm_power_off), so one more patch was introduced in the series.

Stefan Mavrodiev (2):
  mfd: rk808: Check pm_power_off pointer
  mfd: rk808: Prepare rk805 for poweroff

 drivers/mfd/rk808.c       | 42 +++++++++++++++++++++++++++++++++------
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.17.1

