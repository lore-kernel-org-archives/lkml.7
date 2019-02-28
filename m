Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DD220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfB1N0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:26:25 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:1704 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730654AbfB1N0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:26:22 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544454000"; 
   d="scan'208";a="9122276"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2019 22:26:20 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DA7A944683A7;
        Thu, 28 Feb 2019 22:26:18 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: dw: Add support for an optional interface clock
Date:   Thu, 28 Feb 2019 13:25:40 +0000
Message-Id: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys SSI Controller has an interface clock that must be 
explicitly enabled in order to access the registers. This patch series
adds support for the interface clock and adds the associated bindings
documentation.

Phil Edworthy (2):
  dt: snps,dw-apb-ssi: Add clock bindings documentation
  spi: dw: Add support for an optional interface clock

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 drivers/spi/spi-dw-mmio.c                                 | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4

