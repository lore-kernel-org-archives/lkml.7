Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F764C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393EA20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDAOm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:42:27 -0400
Received: from ns.iliad.fr ([212.27.33.1]:52078 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:42:26 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0263620C61;
        Mon,  1 Apr 2019 16:42:25 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id DB09C20A81;
        Mon,  1 Apr 2019 16:42:24 +0200 (CEST)
Subject: [PATCH v2 2/2] dt-bindings: phy-qcom-qmp: Tweak
 qcom,msm8998-qmp-ufs-phy
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190326170518.157317-1-evgreen@chromium.org>
 <71cde29a-aa10-0889-9581-8e961670bc45@free.fr>
 <CAE=gft710gv2+k86pwVhucJFxAcN-AUZhGnT9Hm2gLutV+PCpg@mail.gmail.com>
 <57ba143d-eea5-4f8c-10b8-9f45fc9a8001@free.fr>
Message-ID: <6e9718f1-ae8b-472a-cdfb-6fd64bb9889c@free.fr>
Date:   Mon, 1 Apr 2019 16:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <57ba143d-eea5-4f8c-10b8-9f45fc9a8001@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  1 16:42:25 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup MSM8998 UFS binding now that Evan's reset series has landed.
https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 5fca57b12534..085fbd676cfc 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -73,7 +73,8 @@ Required properties:
 			"phy", "common".
 		For "qcom,msm8998-qmp-usb3-phy" must contain
 			"phy", "common".
-		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
+		For "qcom,msm8998-qmp-ufs-phy": must contain:
+			"ufsphy".
 		For "qcom,msm8998-qmp-pcie-phy" must contain:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
-- 
2.17.1
