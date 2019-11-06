Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2CFC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBC3218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573079135;
	bh=38YTlOFF2LwXTtqqi0l0MmFmAxPVKs8CCcWEJ81Bo30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mF500tIOXSmSyfICpzhhRH7kZlp+yg8B7X9zgXq0Bs8mEPH1V8rBDBgP3ch26lrUS
	 qQezZCefGjUNCWt8X8tfYdSDM/iH4juJyjwJfTTQV/OHMKli78zWcWyckumKYkM/ob
	 JkbvC4reedBnHvy2PWPGmVHhE1TFAIRTe4qG/oOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfKFWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfKFWZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C81521848;
        Wed,  6 Nov 2019 22:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079133;
        bh=38YTlOFF2LwXTtqqi0l0MmFmAxPVKs8CCcWEJ81Bo30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnBo0iM5B0woiOYVuklG9j/bVyoCK5feTzs5egucalAaCQ4o3ko0w+hPXwxti67Na
         eFDKNuWsJB3hbXvJp6BH4WprvhImPLtmerjHsNrn8n0Mb3zsL0sTWVljS3BxWR2ltg
         Cea9dR1KLyeV93EugjhoTJTA/QZrmFOtT1rXG8mo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Yong <jonathan.yong@intel.com>
Subject: [PATCH 2/5] PCI/PTM: Remove dependency on PCIEPORTBUS
Date:   Wed,  6 Nov 2019 16:24:18 -0600
Message-Id: <20191106222420.10216-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
References: <20191106222420.10216-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The PTM support does not depend on the portdrv, so remove the Kconfig
dependency.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Yong <jonathan.yong@intel.com>
---
 drivers/pci/pcie/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 362eb8cfa53b..b0d781d72d1b 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -135,7 +135,6 @@ config PCIE_DPC
 
 config PCIE_PTM
 	bool "PCI Express Precision Time Measurement support"
-	depends on PCIEPORTBUS
 	help
 	  This enables PCI Express Precision Time Measurement (PTM)
 	  support.
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

