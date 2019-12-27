Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14DBC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957F1206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469565;
	bh=2/AR+100ByIuaMU3kpLIuFMXpkvzl8NCXRQQ5iDGItk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQQ131ZYspjhTdSW7mvL+3FmeI7rdlCXTdoioCOrK2nV0nZqDW4gqIHVMTkydW+9c
	 0fgo3Fz+wQeGKokpt3ttVRgG38lxN7OoKdNLw8bB3sYm6ZpzQDx6nHsPiE2ZxwwfpA
	 AM8iaFaP9b0u28JfwgACYkAKQBeLsT9YndPKb8Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfL0RlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0RlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:41:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E845A2173E;
        Fri, 27 Dec 2019 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468459;
        bh=2/AR+100ByIuaMU3kpLIuFMXpkvzl8NCXRQQ5iDGItk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFvKpnEHjK08oIEwsO5tVLkbYio/x3j/cRcpooDy2xWpKUSgfWGQguPacWw76qs+8
         qjGnSVtOJKa/6YX28LkKP4NCnFS9ZvPP1FwLhJlrxf2wjAQtXKx14TOlz6ldqfPwYs
         LKxy2u3h+Gi6MTqDRJrLJkh8Appw/2Xl11QJRdX8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 002/187] spi: pxa2xx: Add support for Intel Jasper Lake
Date:   Fri, 27 Dec 2019 12:37:50 -0500
Message-Id: <20191227174055.4923-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
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

