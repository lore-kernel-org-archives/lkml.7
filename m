Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D86C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2393F20880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ItEGiT10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfHFAXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:23:18 -0400
Received: from onstation.org ([52.200.56.107]:35920 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731154AbfHFAXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:23:00 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 839703E9AC;
        Tue,  6 Aug 2019 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1565050979;
        bh=gBeC38WgB3xWQLxVHl7uyELkZ+E+b+WfCATgX0olB60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItEGiT10F0jY1COc8vBCK4WBjb2ClScpN83SS4EbvX+ujMeLvnHuK780kakIeZSPF
         lvkebFt4y50XIIvIvDpco+aeFtkfIe3NiOzag9YIA4edu5yWiBgrP0hzh6DhVqgwuJ
         fD3AicZ3aUAVpOjbqcX+ixWBik/vAvFDe8I0th4s=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org, robdclark@gmail.com, sean@poorly.run,
        robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        jcrouse@codeaurora.org
Subject: [PATCH v5 7/7] ARM: qcom_defconfig: add ocmem support
Date:   Mon,  5 Aug 2019 20:22:29 -0400
Message-Id: <20190806002229.8304-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806002229.8304-1-masneyb@onstation.org>
References: <20190806002229.8304-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ocmem driver that's needed for some a3xx and a4xx based systems.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is a new patch that was introduced in v5.

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 34433bf5885d..595e1910ba78 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -225,6 +225,7 @@ CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
-- 
2.21.0

