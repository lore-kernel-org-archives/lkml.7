Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B81C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55328204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963393;
	bh=OAaFAuNkgC2l4stkjajlEQZj4l9F0xF6hkj5KC0paQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mCj0pF/raZQ/36KmB02/Qa44mxnmHqr2FsNe1aFZLB/zLwN3vwE69mKtNASX40aeB
	 6yncdEnUHnjPbhmzBVlkrvRNxu2TxfOAm8oXwwA3YtVa+s1z65RduYSjDNrFkUZAGo
	 zmnfB2vJEfIOKBRFS0xMZB/rfEChZO0oeTKpsFNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfDVUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfDVTqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEAA221901;
        Mon, 22 Apr 2019 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962368;
        bh=OAaFAuNkgC2l4stkjajlEQZj4l9F0xF6hkj5KC0paQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQxRaesY7UcokPwVPral7QRulCRrSF/WmPI/dHZ/PWu57e57Y1QE52gtzZC03T7ME
         8vQqxhgfteDEAvISO4o7TmbCmj5yOtiZTAoEgRMzPbbx/XppLsAxK4A49PEow5V7rG
         xPB319kVLBLaruBznpTgTJFXq+YuL22C7Rt422KQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/68] i2c: i801: Add support for Intel Comet Lake
Date:   Mon, 22 Apr 2019 15:44:34 -0400
Message-Id: <20190422194516.11634-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 5cd1c56c42beb6d228cc8d4373fdc5f5ec78a5ad ]

Add PCI ID for Intel Comet Lake PCH.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index d1ee484a787d..ee9984f35868 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -36,6 +36,7 @@ Supported adapters:
   * Intel Cannon Lake (PCH)
   * Intel Cedar Fork (PCH)
   * Intel Ice Lake (PCH)
+  * Intel Comet Lake (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index ac4b09642f63..8f803812ea24 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -131,6 +131,7 @@ config I2C_I801
 	    Cannon Lake (PCH)
 	    Cedar Fork (PCH)
 	    Ice Lake (PCH)
+	    Comet Lake (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c91e145ef5a5..679c6c41f64b 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -71,6 +71,7 @@
  * Cannon Lake-LP (PCH)		0x9da3	32	hard	yes	yes	yes
  * Cedar Fork (PCH)		0x18df	32	hard	yes	yes	yes
  * Ice Lake-LP (PCH)		0x34a3	32	hard	yes	yes	yes
+ * Comet Lake (PCH)		0x02a3	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -240,6 +241,7 @@
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
 #define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
 #define PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS		0xa323
+#define PCI_DEVICE_ID_INTEL_COMETLAKE_SMBUS		0x02a3
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -1038,6 +1040,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CANNONLAKE_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICELAKE_LP_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COMETLAKE_SMBUS) },
 	{ 0, }
 };
 
@@ -1534,6 +1537,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 	case PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS:
 	case PCI_DEVICE_ID_INTEL_ICELAKE_LP_SMBUS:
+	case PCI_DEVICE_ID_INTEL_COMETLAKE_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
 		priv->features |= FEATURE_SMBUS_PEC;
-- 
2.19.1

