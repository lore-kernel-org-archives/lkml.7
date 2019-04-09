Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EAEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7520880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDIMtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:49:02 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45988 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfDIMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:49:01 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 7BC3F21754;
        Tue,  9 Apr 2019 14:49:00 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 618202171E;
        Tue,  9 Apr 2019 14:49:00 +0200 (CEST)
Subject: [PATCH v4 2/2] dt-bindings: phy-qcom-qmp: Add
 qcom,msm8998-qmp-pcie-phy
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Kishon Vijay Abraham <kishon@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <41108be9-f682-f8a9-fa4a-f1c3cef58cfd@free.fr>
Message-ID: <6ff08648-d266-6091-2484-026b217a5d6d@free.fr>
Date:   Tue, 9 Apr 2019 14:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <41108be9-f682-f8a9-fa4a-f1c3cef58cfd@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr  9 14:49:00 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for QMP PCIe phy on msm8998.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 4a78ba8b85bc..5fca57b12534 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -11,6 +11,7 @@ Required properties:
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
 	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
 	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
+	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
 	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
@@ -48,6 +49,8 @@ Required properties:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8998-qmp-ufs-phy" must contain:
 			"ref", "ref_aux".
+		For "qcom,msm8998-qmp-pcie-phy" must contain:
+			"aux", "cfg_ahb", "ref".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
@@ -71,6 +74,8 @@ Required properties:
 		For "qcom,msm8998-qmp-usb3-phy" must contain
 			"phy", "common".
 		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
+		For "qcom,msm8998-qmp-pcie-phy" must contain:
+			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
-- 
2.17.1
