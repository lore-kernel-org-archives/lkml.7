Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfEOQfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:35:08 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:25920 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbfEOQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:35:07 -0400
X-IronPort-AV: E=Sophos;i="5.60,472,1549897200"; 
   d="scan'208";a="15828894"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 May 2019 01:35:05 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F349D40158D2;
        Thu, 16 May 2019 01:35:00 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>, xu_shunji@hoperun.com
Subject: [PATCH v2 2/2] dt-bindings: arm: renesas: Add HopeRun RZ/G2[M] boards
Date:   Wed, 15 May 2019 17:34:43 +0100
Message-Id: <1557938083-25423-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557938083-25423-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557938083-25423-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds board HiHope RZ/G2M (the main board, powered by
the R8A774A1) and board HiHope RZ/G2 EX (the expansion board
that sits on top of the HiHope RZ/G2M). Both boards are made
by Jiangsu HopeRun Software Co., Ltd. (a.k.a. HopeRun).

Useful links:
http://hihope.org/product/detail/rzg2
https://item.taobao.com/item.htm?spm=a2oq0.12575281.0.0.6bcf1debQpzkRS&ft=t&id=592177498472
http://www.hoperun.com/Cn/news/id/379

We already know that the HiHope RZ/G2 EX will also sit on the
HiHope RZ/G2N, even though the HiHope RZ/G2N doesn't exist just
yet.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

---
v1->v2:
* Fixed according to Rob's comments

 Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 19f3798..08c923f 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -106,6 +106,14 @@ properties:
 
       - description: RZ/G2M (R8A774A1)
         items:
+          - enum:
+              - hoperun,hihope-rzg2m # HopeRun HiHope RZ/G2M platform
+          - const: renesas,r8a774a1
+
+      - items:
+          - enum:
+              - hoperun,hihope-rzg2-ex # HopeRun expansion board for HiHope RZ/G2 platforms
+          - const: hoperun,hihope-rzg2m
           - const: renesas,r8a774a1
 
       - description: RZ/G2E (R8A774C0)
-- 
2.7.4

