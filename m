Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D734FA3739
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE46120854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502623AbfJQMs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:48:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729344AbfJQMs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:48:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47C9634C1F89D02A68CC;
        Thu, 17 Oct 2019 20:48:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 20:48:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <afaerber@suse.de>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <baruch@tkos.co.il>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@axis.com>, <linux-oxnas@groups.io>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <vz@mleia.com>, <narmstrong@baylibre.com>,
        <geert+renesas@glider.be>, <daniel@zonque.org>,
        <haojian.zhuang@gmail.com>, <wens@csie.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <agross@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 00/30] pinctrl: use devm_platform_ioremap_resource() to simplify code
Date:   Thu, 17 Oct 2019 20:26:10 +0800
Message-ID: <20191017122640.22976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

YueHaibing (30):
  pinctrl: pxa25x: use devm_platform_ioremap_resource() to simplify code
  pinctrl: pxa27x: use devm_platform_ioremap_resource() to simplify code
  pinctrl: cygnus-mux: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: pic32: use devm_platform_ioremap_resource() to simplify code
  pinctrl: nsp-gpio: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: nsp: use devm_platform_ioremap_resource() to simplify code
  pinctrl: ns2: use devm_platform_ioremap_resource() to simplify code
  pinctrl: bcm281xx: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: sunxi: use devm_platform_ioremap_resource() to simplify code
  pinctrl: tegra: use devm_platform_ioremap_resource() to simplify code
  pinctrl: msm: use devm_platform_ioremap_resource() to simplify code
  pinctrl: spear: use devm_platform_ioremap_resource() to simplify code
  pinctrl: zte: use devm_platform_ioremap_resource() to simplify code
  pinctrl: at91: use devm_platform_ioremap_resource() to simplify code
  pinctrl: oxnas: use devm_platform_ioremap_resource() to simplify code
  pinctrl: pistachio: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: lpc18xx: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: da850-pupd: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: tb10x: use devm_platform_ioremap_resource() to simplify code
  pinctrl: u300: use devm_platform_ioremap_resource() to simplify code
  pinctrl: vt8500: use devm_platform_ioremap_resource() to simplify code
  pinctrl: xway: use devm_platform_ioremap_resource() to simplify code
  pinctrl: rza2: use devm_platform_ioremap_resource() to simplify code
  pinctrl: digicolor: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: coh901: use devm_platform_ioremap_resource() to simplify code
  pinctrl: bm1880: use devm_platform_ioremap_resource() to simplify code
  pinctrl: artpec6: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: actions: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: at91-pio4: use devm_platform_ioremap_resource() to simplify
    code
  pinctrl: iproc: use devm_platform_ioremap_resource() to simplify code

 drivers/pinctrl/actions/pinctrl-owl.c      |  4 +---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c     |  4 +---
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c   |  7 ++-----
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c   |  3 +--
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c      |  6 ++----
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c     |  7 ++-----
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c      |  6 ++----
 drivers/pinctrl/pinctrl-artpec6.c          |  4 +---
 drivers/pinctrl/pinctrl-at91-pio4.c        |  3 +--
 drivers/pinctrl/pinctrl-at91.c             |  4 +---
 drivers/pinctrl/pinctrl-bm1880.c           |  4 +---
 drivers/pinctrl/pinctrl-coh901.c           |  4 +---
 drivers/pinctrl/pinctrl-da850-pupd.c       |  4 +---
 drivers/pinctrl/pinctrl-digicolor.c        |  4 +---
 drivers/pinctrl/pinctrl-lpc18xx.c          |  4 +---
 drivers/pinctrl/pinctrl-oxnas.c            |  4 +---
 drivers/pinctrl/pinctrl-pic32.c            |  4 +---
 drivers/pinctrl/pinctrl-pistachio.c        |  4 +---
 drivers/pinctrl/pinctrl-rza2.c             |  4 +---
 drivers/pinctrl/pinctrl-tb10x.c            |  4 +---
 drivers/pinctrl/pinctrl-u300.c             |  4 +---
 drivers/pinctrl/pinctrl-xway.c             |  4 +---
 drivers/pinctrl/pxa/pinctrl-pxa25x.c       | 13 ++++---------
 drivers/pinctrl/pxa/pinctrl-pxa27x.c       | 13 ++++---------
 drivers/pinctrl/qcom/pinctrl-msm.c         |  3 +--
 drivers/pinctrl/spear/pinctrl-plgpio.c     |  4 +---
 drivers/pinctrl/spear/pinctrl-spear.c      |  4 +---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c      |  4 +---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c |  4 +---
 drivers/pinctrl/tegra/pinctrl-tegra.c      |  3 +--
 drivers/pinctrl/vt8500/pinctrl-wmt.c       |  4 +---
 drivers/pinctrl/zte/pinctrl-zx.c           |  4 +---
 32 files changed, 42 insertions(+), 110 deletions(-)

-- 
2.7.4


