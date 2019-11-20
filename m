Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F8B208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="mHy2fsGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfKTSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:19:51 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:29032 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfKTSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574273988;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=6dWqLxdoQNqzAy0WaMslQR1kh9mHzQEQyVgDF/g0rPg=;
        b=mHy2fsGVpvRkpr7aHsmlKHXzyR4EYwtyncdYB9n2lHbE4YvZ4UHTdVKIAgWGjrToHA
        RfijoSGW1JhgEh9gFN4roFss6geirTg7kFytv4esZnbQJhVnjf33Ho8KMg7ha3HjzdW3
        AxCu6hm0WRoB5Qb87ha2GuRUYfcGCs4ELUGpOYbg8fCP+r1P49HVfklzTb3zsBAFUEr3
        /IaK6aqVjyITbUift/vQBK5q0zGU7vBtXuuqSV74G2EMPKCL2jvxJFvY/wov1u32wdHA
        Kg0ZXeNqaYe7w/S3fI1KPhuqDLy1PJfzygPVLJ8ro80Z+VbfxdSkxfHVD+nYD/N6H+kE
        +OIg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKIJlvAY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 19:19:47 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add yet another for ST-Ericsson
Date:   Wed, 20 Nov 2019 19:18:54 +0100
Message-Id: <20191120181857.97174-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately the vendor prefix for ST-Ericsson is used very
inconsistently. "ste," and "stericsson," are already documented,
but some things in the kernel use "st-ericsson," which is not
documented yet.

st-ericsson,u8500 is documented in bindings/arm/ux500/boards.txt,
and is used to match the machine code and the generic DT cpufreq
driver.

Add it to the list of vendor prefixes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2: none, added new patch to deprecate other vendor prefixes
v1: https://lore.kernel.org/linux-devicetree/20191120121720.72845-1-stephan@gerhold.net/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..c9b0bab8ed23 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -909,6 +909,8 @@ patternProperties:
     description: ST-Ericsson
   "^stericsson,.*":
     description: ST-Ericsson
+  "^st-ericsson,.*":
+    description: ST-Ericsson
   "^summit,.*":
     description: Summit microelectronics
   "^sunchip,.*":
-- 
2.24.0

