Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7468C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98720679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="i2nf+3sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfFSCcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:32:17 -0400
Received: from onstation.org ([52.200.56.107]:35126 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfFSCcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:32:14 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4B7F03EA09;
        Wed, 19 Jun 2019 02:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1560911533;
        bh=vjdYkOGb7QqwyS3qQ2Y0nfwXzLWO7f7pViDR8epWJjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2nf+3slNAwb24oyGu+ALO1v0e43fLyWhBTFI1M5B9UlAOdujTO3fWHbOBKL7+q/d
         WMUEcmg9wuALtvYv4ZeMTrdRsWvuYOAHGDilVYi9hksMRHLAb11SpTNa22pzeV6Q6S
         MV8Orni6KF/pW1v2XJkNFmGhL9qjVjPgZt4hPLvw=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robdclark@gmail.com, sean@poorly.run,
        robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: display: msm: gmu: add optional ocmem property
Date:   Tue, 18 Jun 2019 22:32:05 -0400
Message-Id: <20190619023209.10036-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619023209.10036-1-masneyb@onstation.org>
References: <20190619023209.10036-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some A3xx and A4xx Adreno GPUs do not have GMEM inside the GPU core and
must use the On Chip MEMory (OCMEM) in order to be functional. Add the
optional ocmem property to the Adreno Graphics Management Unit bindings.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- None

 Documentation/devicetree/bindings/display/msm/gmu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
index 90af5b0a56a9..c746b95e95d4 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -31,6 +31,10 @@ Required properties:
 - iommus: phandle to the adreno iommu
 - operating-points-v2: phandle to the OPP operating points
 
+Optional properties:
+- ocmem: phandle to the On Chip Memory (OCMEM) that's present on some Snapdragon
+         SoCs. See Documentation/devicetree/bindings/soc/qcom/qcom,ocmem.yaml.
+
 Example:
 
 / {
-- 
2.20.1

