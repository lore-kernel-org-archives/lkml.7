Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C25C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B61F217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962131;
	bh=lWn0czEfd40jIyplHTrGOa2P8p4OjiPVDOEXUNwN/t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XhLffrUa+AklaRwy+LUYr/GWQOtJ88KbEO4nQAVceKA7agwGBP61C/es3+dsarsjB
	 2dt1B5V1EPPA07DxH/FK/J9nsTDh8f1fB1qYBCJPJ487UcxnvLWhaKh0A4ML9NhZXs
	 mwUWmR9GV2luMlEmh8hDnog7U+xBQbiq+V2mVlXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfDVTmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfDVTmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1BB217D4;
        Mon, 22 Apr 2019 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962128;
        bh=lWn0czEfd40jIyplHTrGOa2P8p4OjiPVDOEXUNwN/t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5PnpcY4fJxusx2mlEMhyF8yqxsrpPDtmcr4hrzCKr3XHWj2SIHjGS62+N5bZrQcw
         MaeiTDeWpDv5rD4Hc5aej2rcAk5wGuinSdmQBDwU5x0XRnt9OUJNfk4AWwDMgIP7wv
         1AJhDQUkRXAmvqOgf13Cg9O2Lpd3leiCwGHvY7OM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 02/98] ARM: dts: bcm283x: Fix hdmi hpd gpio pull
Date:   Mon, 22 Apr 2019 15:40:29 -0400
Message-Id: <20190422194205.10404-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 544e784188f1dd7c797c70b213385e67d92005b6 ]

Raspberry pi board model B revison 2 have the hot plug detector gpio
active high (and not low as it was in the dts).

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Fixes: 49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree.")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 5641d162dfdb..28e7513ce617 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -93,7 +93,7 @@
 };
 
 &hdmi {
-	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
 };
 
 &pwm {
-- 
2.19.1

