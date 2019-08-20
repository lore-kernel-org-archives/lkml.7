Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C382FC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F52F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566321110;
	bh=JfpzGq+mIC9snGbAkLzPujeVcBtk87AoRjWBe76WxtA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rgQLEgM1/dwveoKI4EzNVb/Db8LxGsSnQwjbWeDQ2kXGZtRD/R2g0QWymRXDgw5Y9
	 JEeTLXdvEXRaoyT3DT3hWnQVhwf1LgxtgaIkDuIUnG2lnlYpXfgaaScm0vs6anc4dl
	 0JleE2ywwz+TEAirhzGCf1nWJ4XisD/OlXHaYUdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfHTRLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:11:48 -0400
Received: from localhost.localdomain (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31094214DA;
        Tue, 20 Aug 2019 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321107;
        bh=JfpzGq+mIC9snGbAkLzPujeVcBtk87AoRjWBe76WxtA=;
        h=From:To:Cc:Subject:Date:From;
        b=iQ/nfSfHdVit4wuCuUBXyvPZN13hl7wBO5y8bEOb/ccISluB39YYV9FZHPpGvGmv6
         mfH1rNSy2p66xGTZghbPACxq6Z0AZNCnzc0s1G4PmFVnB2ELs+xBUm6/64Kij1eeW5
         e3gnHyUgu8wKXJKRasvbU8ieVKrO+bG7jtl0I/Uw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Add kryo485 compatible
Date:   Tue, 20 Aug 2019 22:40:20 +0530
Message-Id: <20190820171020.22673-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kryo485 is found in SM8150, so add it it list of cpu compatibles

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index aa40b074b864..032f759612af 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -155,6 +155,7 @@ properties:
       - qcom,krait
       - qcom,kryo
       - qcom,kryo385
+      - qcom,kryo485
       - qcom,scorpion
 
   enable-method:
-- 
2.20.1

