Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D62C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2707C279C6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Lzo8h5Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfFCPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:31:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfFCPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559575888; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=uqw+loJDBYbFYQqYGaC7AgrbhaPx2dBiWAbskkMwnAE=;
        b=Lzo8h5Mhjx10SXMdCLjNrUNcc053z1k0maYS8iIXoJ3seRnpmhRxUY+5iSW4wJPV8bXZ/2
        BZ/OpzCFgMW4pwfuxESUaIl5AmyP8W0EAsVSQs1603t4x2VxvazF5PA7l5EprtsCay3TRg
        rQPL1KRXNNr8qwV+IprGND0syoFjZmU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: display: Add Sharp LS020B1DD01D panel documentation
Date:   Mon,  3 Jun 2019 17:31:18 +0200
Message-Id: <20190603153120.23947-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS020B1DD01D is a 2.0" 240x160 16-bit TFT LCD panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2: New patch
    
    v3: Add Rob's Reviewed-by
    
    v4: Rebase on drm-misc-next (b232d4ed92ea)

 .../bindings/display/panel/sharp,ls020b1dd01d.txt    | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
new file mode 100644
index 000000000000..e45edbc565a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
@@ -0,0 +1,12 @@
+Sharp 2.0" (240x160 pixels) 16-bit TFT LCD panel
+
+Required properties:
+- compatible: should be "sharp,ls020b1dd01d"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.21.0.593.g511ec345e18

