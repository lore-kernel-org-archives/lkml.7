Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B76820842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748893;
	bh=hwoe9K6zNXadhDX/Sk9lr3C+DDaxgXsfHjJbaiV1PpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dS7rk7z9ehqpAkzSIwg5RTRuuEjqAsnZ+Eer4DTC5QpMmHN3C0vzTR19f3Z1++lbz
	 /+8XlSbFTGMnhi4jLyC6HbuprFZFOvmDwXUPw95M2ENNSWREJcnc9IeUHrf4+Hhcwr
	 eim8wIreXPPQHmc2OL+bG/FOsge0X7UbG+Bido+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfHNCOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfHNCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:14:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B5A20843;
        Wed, 14 Aug 2019 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748881;
        bh=hwoe9K6zNXadhDX/Sk9lr3C+DDaxgXsfHjJbaiV1PpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gW2e9jqIknW7DW8n9+RDhUzr5RirDLc1Yablk1iJoRQWi9VOrUIAB7wKGItPQW7NQ
         5t21BXx1RKPE8dZtrUuwPQNNlRn9qt8TQrrLX+nBrkAbsh3LyjZOVh2w62G5Xj7Q2E
         /8ryCyE8tjqQVD8DCmkcUAcm0dB76FVIl0SbQR/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 120/123] dt-bindings: riscv: fix the schema compatible string for the HiFive Unleashed board
Date:   Tue, 13 Aug 2019 22:10:44 -0400
Message-Id: <20190814021047.14828-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Walmsley <paul.walmsley@sifive.com>

[ Upstream commit b390e0bfd2996f1215231395f4e25a4c011eeaf9 ]

The YAML binding document for SiFive boards has an incorrect
compatible string for the HiFive Unleashed board.  Change it to match
the name of the board on the SiFive web site:

   https://www.sifive.com/boards/hifive-unleashed

which also matches the contents of the board DT data file:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts#n13

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/riscv/sifive.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
index 9d17dc2f3f843..3ab532713dc12 100644
--- a/Documentation/devicetree/bindings/riscv/sifive.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
@@ -19,7 +19,7 @@ properties:
   compatible:
     items:
       - enum:
-          - sifive,freedom-unleashed-a00
+          - sifive,hifive-unleashed-a00
       - const: sifive,fu540-c000
       - const: sifive,fu540
 ...
-- 
2.20.1

