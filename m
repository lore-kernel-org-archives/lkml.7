Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87548C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603C8222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437649AbfITHzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:55:03 -0400
Received: from mout.perfora.net ([74.208.4.197]:39083 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437613AbfITHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:55:02 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.138.184]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MGPxO-1iOTHF1O7c-00DD9w; Fri, 20 Sep 2019 09:54:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: add vendor prefix for logic technologies limited
Date:   Fri, 20 Sep 2019 09:54:10 +0200
Message-Id: <20190920075411.15735-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aQ4xStQWFccokTsnwpMEsTr19zszagYxLLJLxeRBk1kzhDNkFOH
 OrZ9Z8sDaQaaZb6xOeD/vWutzISjM1DTSh6UJYijeN+XiP8EdCOrEZKWF4hkg3spLLizROy
 +UkbkPMgL/DS0gbg2ANuzNFBui2iNVF5anESWW8FarmZZ4NeB+dZ2ZvBrrkJWq4sLiJJGAl
 7MVJ0O27AFsX/SdKp+C2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PwRLMrILxo4=:PGyhiCBnO2wa5RDaAzVr3D
 X73wKMW9ke5Dk/nwMKjw89XtApvNKHMmMqWcTxv1fICC4wiCoZH7FsEeDy77pEWtKR4Neq4lD
 rS4styjUA87UXWbHVl6pjHuHQzdCpUDE0vkQYSYgy2xjbqSfibf+XTi6mOaKnO2hSTe0jwH7h
 fC3QuknNBvnUPwYZ3N/32JXAkJgsQAq6S3pt/TVK3NNSIgI2I1ptheSYL+vrvw1OX40wznRGh
 yriEpDCjBPM45qowDdzQrU/VnnYKbVEf99WQb1HYVQrcqKutrLHE5xzPZ97BIEWC0El3LU+uh
 Yl+zT2/Hp7Nz4XdrJ4ZWQ7Mj2+6+Dni1uCnaV+FOSQsoO+AdzVNuS6kqsDifoVy/Moeww/0lK
 QE28vmRQsQ5pk/Gk5vcQ6z8xvgSs+k2DwawGRKbCcsqX68J/12xIfGKw8i3AqLgnevtRv5yvo
 ttY8qimSw3nZ2RZ7OzcNuEer3MqD8W5tUlNkZhvmMhChfboEfuWZtn1b6tzw6I4YMyT4OVtHS
 PqPFbQGX7YlgYJgRakdNFgFtueHOGf7+h7flMYQ0PCaESgQWxz3T2+7pwCsjvNQ8cDtQIyDep
 6Cb91WcfVDN0ZGJczFtXo2m7M1ctl/ds39f5TESiKcgEufncwNkSeKxlRytJVhpABmL4AuKCV
 lrZD/Oc6ZT3q/ZRFF3bMajtfkTVrUa/xEQOjhdy+UbVrHCopY77Vi5qNF/A5fl9V0GsXTRZd1
 NCZWSFUCKuGypZab2x3tcAJc1YAr7fHcJB2XIbsUfYwEof/KLOCiPE/hwItHMS6wrEY1ElbDH
 ReFNUWIqGWaJOtsrx++YUVbSCXN1T6zz/Pr3rNVtvRIMWgzsOrtxMrwUIEin9w95w0mF5T/Z5
 1o4nFqCpM7GCpMaHV/+z/FxXqHdA4qSMKZ/nAjPYg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add vendor prefix for Logic Technologies Limited [1] which is a Chinese
display manufacturer e.g. distributed by German Endrich Bauelemente
Vertriebs GmbH [2].

[1] https://logictechno.com/contact-us/
[2] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..1441146f394f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -541,6 +541,8 @@ patternProperties:
     description: Linear Technology Corporation
   "^logicpd,.*":
     description: Logic PD, Inc.
+  "^logictechno,.*":
+    description: Logic Technologies Limited
   "^longcheer,.*":
     description: Longcheer Technology (Shanghai) Co., Ltd.
   "^lsi,.*":
-- 
2.21.0

