Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B2C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFED2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563878730;
	bh=0CxpEE6Px2Vo+8Rm/Kxf6isGcD4FPfDSxg90fTag+VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MM8weX/an9xkPjjZS1AwPcYMrv1wtym0Mg/ThCT5OyCJEGjuLhiyBqwWRelk+ypgt
	 dSsNMGMdLX8GCqbJQNU96WIgxtYtEEiZzSECQF+Hzfk0qb8ERkM2pRFtsc1jR5EC+1
	 rkdxqpEuY+E6MKZ5kNM2NkGaDkvsfY2hd4TQUyZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbfGWKp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:45:28 -0400
Received: from foss.arm.com ([217.140.110.172]:52602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389175AbfGWKo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39285337;
        Tue, 23 Jul 2019 03:44:56 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505F83F71A;
        Tue, 23 Jul 2019 03:44:55 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range support
Date:   Tue, 23 Jul 2019 11:44:36 +0100
Message-Id: <20190723104437.154403-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the GICv3 binding to allow interrupts in the EPPI range.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 98a3ecda8e07..1fe147daca4c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -44,12 +44,13 @@ properties:
       be at least 4.
 
       The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-      interrupts, 2 for interrupts in the Extended SPI range. Other values
-      are reserved for future use.
+      interrupts, 2 for interrupts in the Extended SPI range, 3 for the
+      Extended PPI range. Other values are reserved for future use.
 
       The 2nd cell contains the interrupt number for the interrupt type.
       SPI interrupts are in the range [0-987]. PPI interrupts are in the
       range [0-15]. Extented SPI interrupts are in the range [0-1023].
+      Extended PPI interrupts are in the range [0-127].
 
       The 3rd cell is the flags, encoded as follows:
       bits[3:0] trigger type and level flags.
-- 
2.20.1

