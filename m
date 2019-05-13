Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8594C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981C721473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dcoEaAty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfEMPlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:41:36 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:41258 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbfEMPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:41:34 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31F1CC01E8;
        Mon, 13 May 2019 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557762098; bh=V4Ds8wpGcxDDnQ94OqrHoU9qqROXRW6ISAWZpliDISU=;
        h=From:To:Cc:Subject:Date:From;
        b=dcoEaAtyPhIy436IcB78mvMQiPJQtHRtZJC3t0uZrqnDlq4NgCB0hC9LMHQSSKvLi
         4PDwPdT2jZVRqo32sqUfDt33o1LkblG8os0wrlRf5JtSdpP7SoRBNKZ1xMrUgN86sC
         ocn3IIZE8LacifosHsfF7Tfib9s0U7L0lNwD14SKlXcUPJSK77WqPfST0nvhvGvQWg
         /3p05AyClCMouwppkRrM+quu56s+PLdEHgCGSqlfiNXVzYZ5f6BloAefrkuz8lb86k
         lKTzvFjAXn1ZfGJ1fyc/v2XEHxoV2K/vwmKzSznbelpfBcFYGNyIVuKosTNGQUoMv4
         wOAS4u+xSjk3g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id AED65A009C;
        Mon, 13 May 2019 15:41:32 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D15693F91F;
        Mon, 13 May 2019 17:41:31 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 0/2] Add DesignWare IP support to simple reset
Date:   Mon, 13 May 2019 17:41:26 +0200
Message-Id: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a reset-simple compatible string for DesignWare
IPs allowing active high and low resets inputs.

Also adds the corresponding documentation.

Gustavo Pimentel (2):
  reset: Add DesignWare IP support to simple reset
  dt-bindings: Document the DesignWare IP reset bindings

 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 drivers/reset/Kconfig                              |  2 +-
 drivers/reset/reset-simple.c                       |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

-- 
2.7.4

