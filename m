Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340CFC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019CD2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JLt9/6aX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfFFPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:37:07 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:41242 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728871AbfFFPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:37:06 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7618FC0ABC;
        Thu,  6 Jun 2019 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559835437; bh=+h2vDYvKU/Eqz/lBSbkDj8osIUzT6k7dY1OtU9w00zg=;
        h=From:To:Cc:Subject:Date:From;
        b=JLt9/6aX90m8lNFknwiXU4wrpB0GtIpIrg3Mk6NI1/5bXQBnjV8/x3O74h+CZmn38
         9WvJE5Cw6f46gGm4bgp0yejC1gVtqrGw/vyuXWnRlslf0yvqhPCJzvaMOlRDghMTzr
         aoXWXWdV4aqPe30tPcoKBEa4pETc85sW0fa05UKy6LJkQaDle+8VShsXMyJE7R2FcR
         MZWwgBjeYErApdbZVFU7fIuXyT7MY6Kyw9qOxG5zFrHOKP1ToCcQy2C6MBkiSPKwI1
         PcelzQ7K1gL1hwgu5nXnDajk+tK/RH0BEtm4c6Ca8omOW/CZq1ZvRpd/eBB2Qdcsgd
         kJT7NPR7Wlt8w==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 807D9A0234;
        Thu,  6 Jun 2019 15:37:03 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 613653F1FB;
        Thu,  6 Jun 2019 17:37:03 +0200 (CEST)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH V2 0/2] Add DesignWare IP support to simple reset
Date:   Thu,  6 Jun 2019 17:36:26 +0200
Message-Id: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a reset-simple compatible string for DesignWare
IPs allowing active high and low resets inputs.

Also adds the corresponding documentation.

Gustavo Pimentel (1):
  reset: Add DesignWare IP support to simple reset

Luis Oliveira (1):
  dt-bindings: Document the DesignWare IP reset bindings

 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 drivers/reset/Kconfig                              |  2 +-
 drivers/reset/reset-simple.c                       |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

-- 
2.7.4

