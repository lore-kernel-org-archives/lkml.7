Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9BA21582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577467757;
	bh=2/AR+100ByIuaMU3kpLIuFMXpkvzl8NCXRQQ5iDGItk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I8Q0eVBW3cDIv8m6H/mN/Bb6X8UM6t6yhEymsP2W2pSQ4ycAH9UgcjQlwcpV6hSl8
	 njOGS3SOq1rCAkesZMrhuHjG+4n32pT0Lh33Rp738eM5dnqZL81vZpsmbmf16+TPYG
	 0dDdlm+4Eb1+r/38ItR6cHK51TCFsB+Nw3y2/ZMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfL0R3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0R3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:29:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73932173E;
        Fri, 27 Dec 2019 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577467754;
        bh=2/AR+100ByIuaMU3kpLIuFMXpkvzl8NCXRQQ5iDGItk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hc1wndU8awgaj0weMcAblVZcg6umTqjV64GQDWX4dCjuqFIJLDzYkIx54NxA1OPpv
         ToS6utxa5KTu8u165Dt5/pI/wLUfqc10+waRZONMHp/f1HxgDib4qAnPz0CWuXWVqD
         8PKFel+Im9ttPa17hd5pLGkU6KFH76u0TlBULGew=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 002/187] spi: pxa2xx: Add support for Intel Jasper Lake
Date:   Fri, 27 Dec 2019 12:26:06 -0500
Message-Id: <20191227172911.4430-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227172911.4430-1-sashal@kernel.org>
References: <20191227172911.4430-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 9c7315c9fca5de203538163cf42699bb10328902 ]

LPSS SPI on Intel Jasper Lake is compatible with Intel Ice Lake which
follows Intel Cannon Lake. Add PCI IDs of Jasper Lake.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20191125125159.15404-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bb6a14d1ab0f..3580a551c038 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1441,6 +1441,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b2a), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4b2b), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4b37), LPSS_BXT_SSP },
+	/* JSL */
+	{ PCI_VDEVICE(INTEL, 0x4daa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4dab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4dfb), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.20.1

