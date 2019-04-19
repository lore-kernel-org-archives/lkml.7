Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F020663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mbW5/gAv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kHqD8uhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfDST4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:56:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfDST4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:56:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64406619C9; Fri, 19 Apr 2019 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703793;
        bh=BjS42e3I9ok/gvgPu6nWUM4K1wfnbKj9xR2pCYkZOYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mbW5/gAvzNpeQun20n+btb/a0vCWTx3KEtQKi3OfPbFw8yDceSTbjlJ8MHvz/I6L1
         eUN59xb7P0WzsdE4QZkX2LNxKWiZmwskFZ19ci5OZDGPylk8iYCaaMQOWcITbYl/1v
         2Bfb3rUOvLjp/ZlyhzsCzL/yj/tIFNlgBWh1WjoA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 016AE61926;
        Fri, 19 Apr 2019 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703791;
        bh=BjS42e3I9ok/gvgPu6nWUM4K1wfnbKj9xR2pCYkZOYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kHqD8uhO3H4VUxQfCa4tDNZsLGuMZC8lhRdbqu93odvYmu13Qi08WdotS1NLf+Ust
         CiAkr0lxRqwp5mS9GVDA1eBwpxDZ3hcHuHwYUmFwKBwnOFRFgM6VHkJjEYTG8SS+6z
         c2JSerYhZxWSMGF7mSajCwPGMiq5ezOstlRCgBAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 016AE61926
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4] dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
Date:   Fri, 19 Apr 2019 13:56:27 -0600
Message-Id: <1555703787-10897-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect and interconnect-names bindings
for the GPU node as detailed by bindings/interconnect/interconnect.txt.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v4: Fix spelling nits per Georgi

 Documentation/devicetree/bindings/display/msm/gpu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index aad1aef..c04614c 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -22,6 +22,8 @@ Required properties:
    - qcom,adreno-630.2
 - iommus: optional phandle to an adreno iommu instance
 - operating-points-v2: optional phandle to the OPP operating points
+- interconnects: optional phandle to an interconnect provider.  See
+  ../interconnect/interconnect.txt for details.
 - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
   control the power for the GPU. Applicable targets:
     - qcom,adreno-630.2
@@ -70,6 +72,8 @@ Example a6xx (with GMU):
 
 		operating-points-v2 = <&gpu_opp_table>;
 
+		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
+
 		qcom,gmu = <&gmu>;
 	};
 };
-- 
2.7.4

