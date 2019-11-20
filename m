Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4291C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF62218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574236816;
	bh=QttJKRtC10VXWG+9qQ5nVIL+rG+zre/MBZV9fsi2lbY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=H5D/l6QVDRhySYa2lHnHNIbOHm2AY6VFFwiEiU3afxMyP42pAFyOxeXbezrF42KI+
	 HErcHWiMUOv9oMc15bcAp2b0myS7h8LfClI2wWoYPlIBRizdtevnA8REz/Y8Ej+8h7
	 73Qrq4gBKp6QTx4g24uVSr+oVTuVHJheCzOimxBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfKTIAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfKTIAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:00:15 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C26322461;
        Wed, 20 Nov 2019 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574236814;
        bh=QttJKRtC10VXWG+9qQ5nVIL+rG+zre/MBZV9fsi2lbY=;
        h=From:To:Cc:Subject:Date:From;
        b=IQzkyAJnQZwLxO4NwQEIleoqKwlSnpr5yhXCd+TkIe+wpeE722E00RgBgheuq9zzv
         awssC7EhfOAn6nFB7G2ZONpj1Eu7iM+p0kXkA7mtgDD99C8XnJQAYXMl7g1NWye4Hy
         XR+TSNysM3U4NVMmENeBfrUxzuxa6x+gjzuKpKm8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] dt-bindings: power: Rename back power_domain.txt bindings to fix references
Date:   Wed, 20 Nov 2019 08:59:56 +0100
Message-Id: <1574236796-25016-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With split of power domain controller bindings to power-domain.yaml,
the consumer part was renamed to power-domain.txt breaking the
references.  Undo the renaming.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes since v2:
1. Simplify pattern in Maintainers as Geert suggested,
2. Add Reviewed-by.

Changes since v1:
1. Undo the renaming.
---
 .../devicetree/bindings/power/{power-domain.txt => power_domain.txt}    | 0
 MAINTAINERS                                                             | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/power/{power-domain.txt => power_domain.txt} (100%)

diff --git a/Documentation/devicetree/bindings/power/power-domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/power-domain.txt
rename to Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 7126d3e079a4..0aff4bebed78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6953,7 +6953,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
-F:	Documentation/devicetree/bindings/power/power-domain*
+F:	Documentation/devicetree/bindings/power/power?domain*
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
-- 
2.7.4

