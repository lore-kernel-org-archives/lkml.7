Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEB920857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCSPyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:54:25 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:7412 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbfCSPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:54:25 -0400
X-IronPort-AV: E=Sophos;i="5.58,498,1544454000"; 
   d="scan'208";a="10591152"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2019 00:54:23 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 356CB400F023;
        Wed, 20 Mar 2019 00:54:21 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] spi: dw: Add support for an optional interface clock
Date:   Tue, 19 Mar 2019 15:52:04 +0000
Message-Id: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - Separated mandatory clock documentation and spelling correction from 
   optional clock property documentation.
 - Subject line for dt-bindings patches changed to match subsystem 
   convention.
 - Dependancy information added to driver patch notes.
 - Optional clock comment in code expanded for clarity.

Gareth Williams (1):
  dt-bindings: snps,dw-apb-ssi: Add optional clock bindings
    documentation

Phil Edworthy (2):
  dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings
    documentation
  spi: dw: Add support for an optional interface clock

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 drivers/spi/spi-dw-mmio.c                                 | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4

