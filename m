Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65862171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432214;
	bh=rJu7BJrG5V5pBx4Ikx52YPoZuwjoYsobrLiaONiRXNc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=db2Y6YHsSSx3zAQms5PvU4mwn5fmN3CzZmE2JxfT6RWUDaC+kQI+8A8aVyHzqjOj4
	 XNqg4JYFhR3iP96afoFsCbLr9Kh3n6jwD9kX5L65S3OS3+q653m/JUJWvQAAcRHF8Y
	 R0Y0P48PgXekEmMMOn6U4IAFwEiLo51VDwsMBjuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfDECnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfDECn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YsmSJtNCxKg43zce1gbaVnEzvg0ut/5r48aLgcV/8r0=; b=Jho69nc2vyHP
        3Jydpw0Jojl44Umfoq+SYMRV5qg41QGi+AYC9iKS+pMOGwDZyIpiq6DL3Piy7FmozhbO8lI/p0TDp
        Bd3EU7z9JwGvsFsod/wu7Wpfu1RLGasIloL0oAPqnQT3liDA8zprDyYi+agRk8sw98zQGm/jFBzsj
        JgQrw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEpA-0005Ey-Sm; Fri, 05 Apr 2019 02:43:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 05F3C441D3C; Fri,  5 Apr 2019 09:43:22 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add g12a compatibles" to the asoc tree
In-Reply-To:  <20190404111733.28705-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405024322.05F3C441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:21 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add g12a compatibles

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 679f4e6cfd45bcc14bb563576e419ac9e43fad7c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:28 +0200
Subject: [PATCH] ASoC: meson: add g12a compatibles

Add new compatible strings for the g12a devices.
Audio wise, the g12a is fairly to close to the axg, yet some differences
need to be handled.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt  | 4 +++-
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt   | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifin.txt         | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifout.txt        | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt  | 4 +++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 3dfc2515e5c6..4330fc9dca6d 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-toddr' or
-	      'amlogic,axg-frddr'
+	      'amlogic,axg-toddr' or
+	      'amlogic,g12a-frddr' or
+	      'amlogic,g12a-toddr'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - interrupts: interrupt specifier for the fifo.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
index 5672d0bc5b16..73f473a9365f 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio PDM input
 
 Required properties:
-- compatible: 'amlogic,axg-pdm'
+- compatible: 'amlogic,axg-pdm' or
+	      'amlogic,g12a-pdm'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
index 2e6cb7d9b202..0b82504fa419 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Input
 
 Required properties:
-- compatible: 'amlogic,axg-spdifin'
+- compatible: 'amlogic,axg-spdifin' or
+	      'amlogic,g12a-spdifin'
 - interrupts: interrupt specifier for the spdif input.
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
index 521c38ad89e7..826152730508 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Output
 
 Required properties:
-- compatible: 'amlogic,axg-spdifout'
+- compatible: 'amlogic,axg-spdifout' or
+	      'amlogic,g12a-spdifout'
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
   * "pclk" : peripheral clock.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 1c1b7490554e..3b94a715a0b9 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-tdmin' or
-	      'amlogic,axg-tdmout'
+	      'amlogic,axg-tdmout' or
+	      'amlogic,g12a-tdmin' or
+	      'amlogic,g12a-tdmout'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
-- 
2.20.1

