Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A297C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22365218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCPHdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 03:33:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:8739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfCPHdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 03:33:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 00:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,485,1544515200"; 
   d="scan'208";a="127477519"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2019 00:33:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h53pE-0000bh-Cl; Sat, 16 Mar 2019 15:33:48 +0800
Date:   Sat, 16 Mar 2019 15:33:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH spi] spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be
 static
Message-ID: <20190316073341.GA132987@lkp-hsx03>
References: <201903161509.ZfXt4Lx6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903161509.ZfXt4Lx6%lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2e541b64ee52 ("spi: spi-mem: stm32-qspi: add suspend/resume support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 spi-stm32-qspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3e8ca10..7879a52 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -517,7 +517,7 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+static SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
 
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
