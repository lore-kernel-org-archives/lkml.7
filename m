Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC4C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E636E216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="LC45CRS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGIHfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:35:05 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61844 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGIHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656769; x=1565248769;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UoyMOrIVOLmkAP68dGafSoo6TcUNycT9H09rWKScbJk=;
        b=LC45CRS2kT9zZoGYmUjtpBjqWJ7YAwaFAmCEjajsx5+we9i6mdcnHI+ziFDz+/cj
        10No8bn7QUEGrQCbnr/uzZFqq9r3+MqSGwp69nzf1C1jagzZUCK/FC9aXnr+sCIQ
        fSJBr9q4BgJOYeHUchIG+sRkzceOA9OZcRZcZvR72fo=;
X-AuditID: c39127d2-193ff70000001aee-0a-5d2440014793
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id ED.B0.06894.100442D5; Tue,  9 Jul 2019 09:19:29 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192949-309712 ;
          Tue, 9 Jul 2019 09:19:29 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 09/10] ARM: dts: imx6ul: segin: Move machine include to dts files
Date:   Tue, 9 Jul 2019 09:19:26 +0200
Message-Id: <1562656767-273566-10-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize complete at 09.07.2019 09:19:29
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWyRoCBS5fRQSXWoLHLwmL+kXOsFg+v+lus
        mrqTxWLT42usFl2/VjJbXN41h81i6fWLTBYPLnaxWLTuPcJu8Xf7JhaLF1vEHbg91sxbw+ix
        4+4SRo+ds+6ye2xa1cnmsXlJvcfGdzuYPPr/Gnh83iQXwBHFZZOSmpNZllqkb5fAlfH8eW7B
        bq6KU+fWMzYwTufsYuTkkBAwkTj95zNLFyMXh5DADkaJFTs2MkM4Fxglru1bxQ5SxSZgJLFg
        WiMTiC0iECnxbvtvdpAiZoE9jBLTrl9nBEkICwRKnJ18G6yIRUBF4sKpD0CTODh4BTwlFj0z
        htgmJ3HzXCcziM0JFD568ReYLSTgIXF5wTSwKyQEGpkkrr3ewgjRICRxevFZ5gmMfAsYGVYx
        CuVmJmenFmVm6xVkVJakJuulpG5iBIbp4Ynql3Yw9s3xOMTIxMF4iFGCg1lJhHefu3KsEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd4NvCVhQgLpiSWp2ampBalFMFkmDk6pBsapBjnqLsx5N/3t
        GhJUNpfNLzq2UF/x6AOXpKv3SkM0udzuKQbP2l/FtO1m1NTadw4dzWnbf9590Pft162be2K7
        ny8zU2XLuCewuuyT2/8DOiltL/hj1E2qK7jPeC/m02U6rTxP83EVU33irYrLS8wTzq364X1t
        mfztg0HxE7v870vo8nx6d0+JpTgj0VCLuag4EQBOF+Y5QQIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the imx6ul.dtsi include to the dts files so it is easier to reuse
the SOM dtsi for e.g. an i.MX 6ULL SOM.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi      | 1 -
 arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 09a313daedb8..92bf91674056 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
-#include "imx6ul.dtsi"
 
 / {
 	model = "PHYTEC phyCORE-i.MX6 UltraLite";
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index 32d90c67a6f2..699dfcbf9a60 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include "imx6ul.dtsi"
 #include "imx6ul-phytec-phycore-som.dtsi"
 #include "imx6ul-phytec-segin.dtsi"
 #include "imx6ul-phytec-segin-peb-eval-01.dtsi"
-- 
2.7.4

