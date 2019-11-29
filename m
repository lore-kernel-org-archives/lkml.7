Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4FCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B4C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK2LkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:40:14 -0500
Received: from olimex.com ([184.105.72.32]:33569 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfK2LkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:40:06 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 03:39:54 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 0/3] arm64: dts: allwinner: a64: olinuxino: Update regulators
Date:   Fri, 29 Nov 2019 13:39:38 +0200
Message-Id: <20191129113941.20170-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie updates bank regulators for A64-OLinuXino and 
A64-OLinuXino-eMMC.

Also, eMMC supply is changed to ELDO1, which is the actual one. The same is
done for the SDIO card - ALDO2 is changed to DCDC1.

Changes for v2:
 - Restore the original eMMC vmmc-supply property
 - Add fixes and kernel tags

Stefan Mavrodiev (3):
  arm64: dts: allwinner: a64: olinuxino: Fix eMMC supply regulator
  arm64: dts: allwinner: a64: olinuxino: Add bank supply regulators
  arm64: dts: allwinner: a64: olinuxino: Fix SDIO supply regulator

 .../allwinner/sun50i-a64-olinuxino-emmc.dts    |  6 +++++-
 .../dts/allwinner/sun50i-a64-olinuxino.dts     | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.17.1
