Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D8AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D84122DD3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ExqotPmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfIEKAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:00:52 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:44176 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfIEKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:00:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 04CEFC0DD3;
        Thu,  5 Sep 2019 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567677651; bh=GosWZM2QU8S12Kgv9mW7HdYKBOJWFoe+3pD+Un3G66o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ExqotPmXtPyrttYl0egCKAjoHy9K3A8M6MiMfU7TFhvGai2DEmP5d1TOunCx7WhsA
         bX/GnJnv1VfJMFtbFDRdN4gssi2BYXCTPQlYC70C2+asnrlOjoLQ1ZNgyRxIWobJDe
         rVyL2GEi/k7VN0bRoa6+QT+6F2pPczzRRDSXH7RYBjAj1tl8SBeCIbHd3i+9ysOLZD
         hE4U3OjOjWVs+wqf70sAlHGL4p5llwvdm1A5ZodZ2N5eHp1LTag1JfbKvxhkeTLgrk
         8R+WoNjcQTefQyM8qzXAVM+kK/a860lcqFq4C1w8ozE4F6B6DXLJ7FaTjyO+zeHW0Q
         ab8UtiEl4ayVg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9989BA0061;
        Thu,  5 Sep 2019 10:00:49 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 826F43F3BC;
        Thu,  5 Sep 2019 12:00:49 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 4/5] dt-bindings: i3c: add a note for no guarantee of 'assigned-address' use
Date:   Thu,  5 Sep 2019 12:00:37 +0200
Message-Id: <f8a0cbc92605dbf5f41a28edd7691c3e90087554.1567608245.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567608245.git.vitor.soares@synopsys.com>
References: <cover.1567608245.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567608245.git.vitor.soares@synopsys.com>
References: <cover.1567608245.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the framework will try to assign the 'assigned-address' to the
device but if the address is already in use the device dynamic address
will be different.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Change in v3:
  - Add Rob rb-tag

 Documentation/devicetree/bindings/i3c/i3c.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
index c851e75..e777f09 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.txt
+++ b/Documentation/devicetree/bindings/i3c/i3c.txt
@@ -98,7 +98,9 @@ Required properties
 
 Optional properties
 -------------------
-- assigned-address: dynamic address to be assigned to this device.
+- assigned-address: dynamic address to be assigned to this device. The framework
+		    will try to assign this dynamic address but if something
+		    fails the device dynamic address will be different.
 
 
 Example:
-- 
2.7.4

