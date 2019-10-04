Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2437C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D46222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570202072;
	bh=T+96WbhywkN9TZ3RgQsCxJM8eZpY0gKukrAqlx2v0jM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSOMs87Zgq5+M3zGg11xToeSN1VJGBXOtMmVd4GYp5cQhIVFgVmb7mdGgMwTQtl2U
	 qvAiwSAfJB3gmiAvKryNc7cVMYHGRjGOzyv7RE4QXn5HJvhIOci8wnmyQjTSaEEgco
	 xrEkQz1dBZRSmx/2SLaCQZhlsbLbG8LWaLZsyiiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbfJDPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389596AbfJDPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:14:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3AC222C2;
        Fri,  4 Oct 2019 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570202070;
        bh=T+96WbhywkN9TZ3RgQsCxJM8eZpY0gKukrAqlx2v0jM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XbNy0vjvtdDr7yclvUmZXuFX91a7a2NmRHOkhWFrYJdsLiTWwiw/PY+VE2zOSgaJc
         JFCE8U5N2omSGBkLx5Jk0Qwqr+2WfhjbCDPbIZ3uKUHxw7weadLSquNzRFbcUSBly3
         QGtdp9XUgZgmaydqz8uauSYOun9jHAwHXMzTCQrE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Fix indentation
Date:   Fri,  4 Oct 2019 17:14:13 +0200
Message-Id: <20191004151414.8458-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004151414.8458-1-krzk@kernel.org>
References: <20191004151414.8458-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array elements under 'items' should be indented.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index 45ce562435fa..f4dfa6fc724c 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -27,7 +27,7 @@ properties:
 
   clock-names:
     items:
-    - const: rotator
+      - const: rotator
 
 required:
   - compatible
-- 
2.17.1

