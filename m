Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2274C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB16214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfIMMM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:12:29 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:35203 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfIMMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:12:28 -0400
X-IronPort-AV: E=Sophos;i="5.64,501,1559487600"; 
   d="scan'208";a="26313255"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2019 21:12:26 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AE9F24007F43;
        Fri, 13 Sep 2019 21:12:24 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: dw: Add basic runtime PM support
Date:   Fri, 13 Sep 2019 13:11:57 +0100
Message-Id: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI. This
series enables power mode in the driver so the clock domain will enable
the bus clock, adds the compatible string and updates the associated bindings
documentation.

Phil Edworthy (3):
  dt: spi: Add Renesas RZ/N1 binding documentation
  spi: dw: Add basic runtime PM support
  spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.c                                       |  4 ++++
 3 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

-- 
2.7.4

