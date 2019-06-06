Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DA520684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b7m3H/Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfFFPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:37:13 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:41264 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729448AbfFFPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:37:10 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 96018C0B81;
        Thu,  6 Jun 2019 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559835440; bh=evCeM7m+wEZrH4vGhwpv02k3yRyahFmlmUvNVtGsfDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7m3H/XgkC/+WU1sEjD6eDOgADERYI7a3JYqP+b3Kb8pEDYNuWSR3NAw1yBJO+QTD
         Q7FbnUfzEt+yTVkMCi8lEUmMMNWwr5P1CCjTwuiZh4HuI7F38Nsi9NbdJcpJisdtbK
         J3lsWkoBGJzcdWJdr5E/0Py9nUUcMuUsQfMTTr8/jHaU+QFrBgzgiHh1hz0D5vPIEH
         E74qVrIv4M0BzOpLmGwwcLoiGK4J5SO4IQiGHp97hQEvHPqh8HfG+isK7KGTUXB905
         v9+DaYcK0h1Cs04DKPsc52NZzLp9Te8NJky5A8O9jbK6NlxOQYiMz4lLJp96JYnRhW
         1z7dD48lVkd1A==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 813B9A005C;
        Thu,  6 Jun 2019 15:37:07 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 65A4D3F204;
        Thu,  6 Jun 2019 17:37:07 +0200 (CEST)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset bindings
Date:   Thu,  6 Jun 2019 17:36:28 +0200
Message-Id: <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation of device tree bindings for the
DesignWare IP reset controller.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
Changelog
- Add active low configuration example
- Fix compatible string in the active high example

 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
new file mode 100644
index 0000000..85f3301
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
@@ -0,0 +1,30 @@
+Synopsys DesignWare Reset controller
+=======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+
+- compatible: should be one of the following.
+	"snps,dw-high-reset" - for active high configuration
+	"snps,dw-low-reset" - for active low configuration
+
+- reg: physical base address of the controller and length of memory mapped
+	region.
+
+- #reset-cells: must be 1.
+
+example:
+
+	dw_rst_1: reset-controller@0000 {
+		  compatible = "snps,dw-high-reset";
+	 	  reg = <0x0000 0x4>;
+		  #reset-cells = <1>;
+	};
+
+	dw_rst_2: reset-controller@1000 {i
+		  compatible = "snps,dw-low-reset";
+		  reg = <0x1000 0x8>;
+		  #reset-cells = <1>;
+	};
-- 
2.7.4

