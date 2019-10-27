Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C19CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B4821850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfJ0O1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:27:07 -0400
Received: from mout.perfora.net ([74.208.4.194]:34647 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfJ0O1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:27:06 -0400
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LfRRn-1he65P42eX-00p7fq; Sun, 27 Oct 2019 15:26:23 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: add vendor prefix for logic technologies limited
Date:   Sun, 27 Oct 2019 15:26:07 +0100
Message-Id: <20191027142609.12754-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:heAvjHkMaQ14q2AF3Kh8VU+foLLPfuqVtVUsSN0DU7wAn6jdBCi
 kzN+cvsQP/1Rbh0r2hYunbuT+PtH2UVZEftITahIy90Eg+EKW3nTG6TomsUh8gzC4q6RpOu
 vVtT73rG6lWNmoPllJCa7CfYSLSMNl/EbqwdBGq5qCAV2EqsyvoC9ruOl9kgWr7xWW21APM
 sWpnZESnqXeNCDCqF7iHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJ6us2BmZo8=:QSjvIflxkNhYzy1fkhJabB
 ysxxNlXhSHyEIT3m9fLCDPzoBXhLGx1MMSulX7MIJrfkEfRmT/sy6ULWRpbLBC6j8gurXqE+c
 7rgnbzpYIGVA/AlhQEOl8ajUyBAhpOD2cz4ADpgCIXB8JOnBSWLr4rkOCaeG0oZtHxpXIDygV
 0MLcGDz7cis9KkmZPRPjVutsS4cppRiCYcz3hntgfUg9dTTEI0LTC3M77HTLlY6Iraf3Q0Vfu
 A63UT+in6O2RMFnKY8PrXj2PdJJjD5lPqRaHZcwmx2yO13rJ5D9aI1ad5BE4uIGrBwYTKVp54
 aRuE5B6hyFX/tBShOdiQbkxmhID/c/Gw6CDqAzrtgJFNJb3q3QxCxDk0+yll+AE2xAySr4RL0
 1x1cAvjA7WUF0XhAonELOTtBUK9oyY2+b/4k9aP3ROPRHI5/y33ihs/GNde7eYemjwTw91GYq
 1Zo1yf/u+8iqax89uXu50ZbWuuCcAowOkTryFDx8YznGvp4I0h0Wjsipw7XI+xRy76gzJWFe6
 eKERL/VrpOxkAJFSfQSH/0n28SL+dJNv2gswbAtf/60Bk4cpfSDTX4qr1zvnzm68Ob/HhQ3w3
 lWGbM9H2axUA6HRfrT8idPnYokUncUF+pX+xJmS+NtzDKwoauQjviUwTJi/yGfPI3PQGsEyv9
 FiWzlNzHvWStSix/mbP6YvcyPqbtRkUEQKnJUL3lyAdaiyQbZy8ZA1eub1kAZhrbovAwwhtuW
 92aVLUtZIEJI/1pNvc0ofvsXWGb+GpDULJefel2MQ0xexTJIJnroF27dReDNxZPxsxo2u3tYO
 rmcNn/iq4PwJMMqZBLZKNFNFjrOLSHz3OkxWw3+W7Zoqvo6+HkvYxqHy9TcBU0q5aDEulNGIc
 smJMrl22Lxz2TDJvknTx6kTnC4ozRkc6ZF+9PX24E=
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
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v2:
- Added Philippe's reviewed-by.
- Added Rob's acked-by.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9a8495e39c5b..94aea715d4e2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -543,6 +543,8 @@ patternProperties:
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

