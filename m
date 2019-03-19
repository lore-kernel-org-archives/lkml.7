Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E5421871
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSBqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:46:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:37929 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfCSBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:46:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 18:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="135186907"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2019 18:46:40 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h63pv-00048l-Ui; Tue, 19 Mar 2019 09:46:39 +0800
Date:   Tue, 19 Mar 2019 09:46:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Han Xu <han.xu@nxp.com>
Cc:     kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH spi] spi: lpspi: fsl_lpspi_runtime_resume() can be static
Message-ID: <20190319014633.GA8434@ivb42>
References: <201903190907.mIc3klXH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903190907.mIc3klXH%lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 spi-fsl-lpspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1860f06..4de8eb3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -780,7 +780,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-int fsl_lpspi_runtime_resume(struct device *dev)
+static int fsl_lpspi_runtime_resume(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 	int ret;
@@ -798,7 +798,7 @@ int fsl_lpspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-int fsl_lpspi_runtime_suspend(struct device *dev)
+static int fsl_lpspi_runtime_suspend(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 
