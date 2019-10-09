Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5293ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01BA2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641750;
	bh=L+vaemT5IciX304h5JnLNTKQTD7IwxPdQqSfYRG/nEw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vzHaJoLJkNxFEOdnTYQQZpzmMyEkq4Qwg+iQjnaquW0Dz4mggbLeGdTyKNpwXQ/yE
	 KMeIJQXZqmXFLIu8B3BAm3AjdXqO6/N6SF6UaaWxh4g3rk3oI7mnmlg4EseViwwi2y
	 /qsPocOn3Q3+RLj2wpdGzvEjqigrH0juNDUb1zqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfJIRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:22:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IxAhdgaQrq0J/VgaJk4Li88x6ZuphvJhRzy9YVZATI4=; b=W3atcQgxz0VK
        qgwUx5C1pL778u1fRvJ9j/go4rghn/bptabdJwPMJmvuyM7Vzkp62SQGGbye3VAobT7d9+r8qije7
        /XUiFec4C+pAbueudkV6i9q9LykahBuQXmZZLBP4RuQ4lCQkFItbejvf4fyl0LLbXJrg+vnmw2Npk
        UQpuw=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFer-0005Jq-Jg; Wed, 09 Oct 2019 17:21:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 59243D03ED4; Wed,  9 Oct 2019 18:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, perex@perex.cz,
        tiwai@suse.com
Subject: Applied "ASoc: Add Texas Instruments TAS2562 amplifier binding" to the asoc tree
In-Reply-To: <20191008181517.5332-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172148.59243D03ED4@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:21:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoc: Add Texas Instruments TAS2562 amplifier binding

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From ac84b8b21b8e305b82d2b204999ee3140990d1b5 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 8 Oct 2019 13:15:16 -0500
Subject: [PATCH] ASoc: Add Texas Instruments TAS2562 amplifier binding

Add the DT binding for the TAS2562 amplifier.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20191008181517.5332-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tas2562.txt     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
new file mode 100644
index 000000000000..658e1fb18a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -0,0 +1,34 @@
+Texas Instruments TAS2562 Smart PA
+
+The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - compatible:	   - Should contain "ti,tas2562".
+ - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+
+Optional properties:
+- interrupt-parent: phandle to the interrupt controller which provides
+                    the interrupt.
+- interrupts: (GPIO) interrupt to which the chip is connected.
+- shut-down: GPIO used to control the state of the device.
+
+Examples:
+tas2562@4c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,tas2562";
+        reg = <0x4c>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <14>;
+
+	shut-down = <&gpio1 15 0>;
+        ti,imon-slot-no = <0>;
+};
+
-- 
2.20.1

