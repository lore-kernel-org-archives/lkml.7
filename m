Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CCC17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EFF2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573612115;
	bh=91aPh7xe+OemNnEsFGvvLgDTsY/relcPOztRIhK4tIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHElhwJtO2XGkiQqam8ZHrVRoi0CzrwtBQPtD1t0IgTKkUadwRKaMdjUQ/4Ch11WD
	 LBYLEk2kGJyUu9u8x4H0BkHeqo3EKHHBs4GVbFwruF1eXeHWanSjYZyfOFqq2rnG3k
	 TYJJxmZAw6dQDoiRUtutGaMUGilP4TOMhf1E35rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKMBuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfKMBub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:50:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E5C2245A;
        Wed, 13 Nov 2019 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609830;
        bh=91aPh7xe+OemNnEsFGvvLgDTsY/relcPOztRIhK4tIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVH9RHxcDZDlbPmawm/SFSTjTygkrzWhw033amhFEZQB42NjlnyyE6kbZjbMsuQDc
         T+Nw4gwXV5A9+4FIH2EK4taoBQvO3eEQ+ul5i7jWfhOmzG+UO0uPDITw23xDMmGB/k
         69OyAjm+jhhagAuqFiTkoMTiNcasMVHUTebdC+TM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 004/209] ARM: dts: omap5: enable OTG role for DWC3 controller
Date:   Tue, 12 Nov 2019 20:47:00 -0500
Message-Id: <20191113015025.9685-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 656c1a65ab555ee5c7cd0d6aee8ab82ca3c1795f ]

Since SMPS10 and OTG cable detection extcon are described here, and
work to enable OTG power when an OTG cable is plugged in, we can
define OTG mode in the controller (which is disabled by default in
omap5.dtsi).

Tested on OMAP5EVM and Pyra.

Suggested-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 8b8db9d8e9126..c2dc4199b4ec2 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -703,6 +703,10 @@
 	vbus-supply = <&smps10_out1_reg>;
 };
 
+&dwc3 {
+	dr_mode = "otg";
+};
+
 &mcspi1 {
 
 };
-- 
2.20.1

