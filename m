Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED8C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608072133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725138;
	bh=OFnhJea0gyEPp+cJHwhXSXRaWGDRaJqhUSnzM29pFHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbirj6IJGiKJpMMSIAR0WUauWH52aWNcdzBZ621CkNcTHdT3VdtH/5Kb8jVx/oo18
	 l9JXRZJ3miTRmnlmxKNhI1vCVI4MKTQdHuhYnPlvNe50VYAfFTvpMpnxPfXDAWciCj
	 tB7kOX2qcE90ZFVLiHts/11L4akFWJr5mGY63nyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfF1McM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:32:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfF1Man (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9x6MnELpm41+8+il8SzONc8VzOlbzKYgL1wPINAhEuU=; b=JTRIUwajdrDihDEkBt/zx/3w+b
        U67j76+Puudo7N4rJUEJ6sU9zLuGZKUBOdsRnW/R5JsgtnxgT9M+8wIzVvoEgLsh3v1DskXsW+EyK
        zidvAYPNYnWaBDtfUuOIfXodjjOxrrrrNiuX2l5sIat4zAZDzqv7hUZ4kMh0q87WNPHohB6hqU1DI
        VeUPT4BzyvKLUwPnd2OMY0e28x+bPcN3uuQGYK8sgcNMdue3MsnhKya/GcoQGN7VhoPLPJnL+3EWZ
        LiKjtuxM7kRBNSWjTlMYoFm3E0RzHPJOTIeiJskH5ZAjZXPBGXpB9tHZZ3M5W+6K0fcnlGJmvTI2r
        qO36jZtg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055r-Od; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005TY-QB; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 33/39] docs: phy: place documentation under driver-api
Date:   Fri, 28 Jun 2019 09:30:26 -0300
Message-Id: <df0337d37a924dcfa1f528734ffd3bae430d93c4.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This subsystem-specific documentation belongs to the
driver-api.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../devicetree/bindings/phy/phy-bindings.txt     |  2 +-
 .../devicetree/bindings/phy/phy-pxa-usb.txt      |  2 +-
 Documentation/driver-api/index.rst               |  1 +
 Documentation/driver-api/phy/index.rst           | 16 ++++++++++++++++
 .../{phy.txt => driver-api/phy/phy.rst}          |  0
 .../{ => driver-api}/phy/samsung-usb2.rst        |  0
 Documentation/index.rst                          |  1 -
 MAINTAINERS                                      |  2 +-
 8 files changed, 20 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/driver-api/phy/index.rst
 rename Documentation/{phy.txt => driver-api/phy/phy.rst} (100%)
 rename Documentation/{ => driver-api}/phy/samsung-usb2.rst (100%)

diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt b/Documentation/devicetree/bindings/phy/phy-bindings.txt
index a403b81d0679..c4eb38902533 100644
--- a/Documentation/devicetree/bindings/phy/phy-bindings.txt
+++ b/Documentation/devicetree/bindings/phy/phy-bindings.txt
@@ -1,5 +1,5 @@
 This document explains only the device tree data binding. For general
-information about PHY subsystem refer to Documentation/phy.txt
+information about PHY subsystem refer to Documentation/driver-api/phy/phy.rst
 
 PHY device node
 ===============
diff --git a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
index 93fc09c12954..d80e36a77ec5 100644
--- a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
@@ -15,4 +15,4 @@ Example:
 	};
 
 This document explains the device tree binding. For general
-information about PHY subsystem refer to Documentation/phy.txt
+information about PHY subsystem refer to Documentation/driver-api/phy/phy.rst
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d6f532c8d824..12d68c3ab792 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -85,6 +85,7 @@ available subsections can be seen below.
    parport-lowlevel
    pps
    ptp
+   phy/index
    pti_intel_mid
    pwm
    rfkill
diff --git a/Documentation/driver-api/phy/index.rst b/Documentation/driver-api/phy/index.rst
new file mode 100644
index 000000000000..fce9ffae2812
--- /dev/null
+++ b/Documentation/driver-api/phy/index.rst
@@ -0,0 +1,16 @@
+=====================
+Generic PHY Framework
+=====================
+
+.. toctree::
+
+   phy
+   samsung-usb2
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/phy.txt b/Documentation/driver-api/phy/phy.rst
similarity index 100%
rename from Documentation/phy.txt
rename to Documentation/driver-api/phy/phy.rst
diff --git a/Documentation/phy/samsung-usb2.rst b/Documentation/driver-api/phy/samsung-usb2.rst
similarity index 100%
rename from Documentation/phy/samsung-usb2.rst
rename to Documentation/driver-api/phy/samsung-usb2.rst
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 28e6b5ef17b4..ea33cbbccd9d 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -112,7 +112,6 @@ needed).
    usb/index
    misc-devices/index
    mic/index
-   phy/samsung-usb2
    scheduler/index
 
 Architecture-specific documentation
diff --git a/MAINTAINERS b/MAINTAINERS
index 856db8015edd..cda68bbd9d1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14031,7 +14031,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
-F:	Documentation/phy/samsung-usb2.rst
+F:	Documentation/driver-api/phy/samsung-usb2.rst
 F:	drivers/phy/samsung/phy-exynos4210-usb2.c
 F:	drivers/phy/samsung/phy-exynos4x12-usb2.c
 F:	drivers/phy/samsung/phy-exynos5250-usb2.c
-- 
2.21.0

