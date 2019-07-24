Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA38229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Cgylcunb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfGXMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:07:05 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:47270 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbfGXMHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:07:05 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C01C3C1CC4;
        Wed, 24 Jul 2019 12:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563970024; bh=bjVetJO1YRRBd9PD5tDYdRS01g5brAO3VU5DPB/N8N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cgylcunbj2r3JuNUMkcnWBJkh5He+myws3C1WAO8XwnjP3lz7wjFwxr01OKonk/r0
         wWThco2iIA1JNw8QCoQBiIHy/isKZ+Z+LxyVoY9W8FLZH0qtB4YQFTR0K258nTfVcR
         0FtyttswqAO01Ji2XMP7mG5JJkVTek7relYqMEuUu+3pNyZ97235t4DpvZ/x9mZ6IR
         Erdv6CqDz/YgVLQjL2yY9KCqL/pekfTN6kJU7oY6nYzmlHCwJai0Rhyo79DKl+FgqO
         wenFKqICc81+Zx+2ILMDCHjUTz4sFGm3C+S2i6vkjlnoMkpEplMtWutxCTf54wlzCe
         4sH0vgNOxO4jA==
Received: from de02arcdev1.internal.synopsys.com (de02arcdev1.internal.synopsys.com [10.225.22.192])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8D8A1A005C;
        Wed, 24 Jul 2019 12:07:03 +0000 (UTC)
From:   Mischa Jonker <Mischa.Jonker@synopsys.com>
To:     Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: [PATCH v2 2/3] dt-bindings: IDU-intc: Clean up documentation
Date:   Wed, 24 Jul 2019 14:04:35 +0200
Message-Id: <20190724120436.8537-2-mischa.jonker@synopsys.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190724120436.8537-1-mischa.jonker@synopsys.com>
References: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
 <20190724120436.8537-1-mischa.jonker@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Some lines exceeded 80 characters.
* Clarified statement about AUX register interface

Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
---
 .../bindings/interrupt-controller/snps,archs-idu-intc.txt        | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
index 09fc02b..c5a1c7b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
@@ -1,7 +1,8 @@
 * ARC-HS Interrupt Distribution Unit
 
-  This optional 2nd level interrupt controller can be used in SMP configurations for
-  dynamic IRQ routing, load balancing of common/external IRQs towards core intc.
+  This optional 2nd level interrupt controller can be used in SMP configurations
+  for dynamic IRQ routing, load balancing of common/external IRQs towards core
+  intc.
 
 Properties:
 
@@ -13,8 +14,8 @@ Properties:
   of the particular interrupt line of IDU corresponds to the line N+24 of the
   core interrupt controller.
 
-  intc accessed via the special ARC AUX register interface, hence "reg" property
-  is not specified.
+  The interrupt controller is accessed via the special ARC AUX register
+  interface, hence "reg" property is not specified.
 
 Example:
 	core_intc: core-interrupt-controller {
-- 
2.8.3

