Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4F20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Icp2XnEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfCaTQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:16:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:52477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfCaTQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554059772;
        bh=p9wgkmRrbvQfiwC4g29RdB5ZJ0YLvOzvFjdWvRW+QII=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Icp2XnEQDn2vh+tW+H4yQGhOmtUbb+UqnCqXLzL7dxa+DizQyEAxbirjkNgKyZ2nN
         RnaGEAzhH4iAll4nBX8vO47LY3UNxlLgnY8yhnMyjsFfWMybmgbOBs4pKDZD//rmFV
         21UsWYFZAwKOGGXlc5E3VgMnRL16mAwAsIGigMwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGj8j-1h615p00HJ-00Db1d; Sun, 31
 Mar 2019 21:16:12 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>,
        Thierry Reding <treding@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ARM: Initial devicetree for Kobo Aura
Date:   Sun, 31 Mar 2019 21:15:59 +0200
Message-Id: <20190331191602.3921-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BzcnSAa4HizJ/dMGh/M4YfgXMiIiaetfAAFgDV+NdhZ3xu2UTC0
 Ss+jjfAL+OYBKkZ4x48MvB1p5kQck/sZVIqLRv1GP3eBJxV8caysn8/ZlZLPIn5/PkTibVo
 51xTZ8Zg5pVqh1Gh+J7ZTTQCc7jJitsZhsLZWiPAAqaVkTkS6GneRlJrtqiLkaFzZoSbYCs
 ibXuMU4R9UWGOC0x2OEyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vrqoGtJwA2w=:t9QZPA09poRLJzIb2x1AJ/
 jh1y9oT5dbG2ytR4edeyaoZd5PwrwOVH2YK2AZpLeEoNo8b1/NtWHMfsldeN9HwKIZDoIi4hf
 Xju86LwIByKq6t9QjGMOuPvdiBtbVgkhVJ+CLXyF6QiutiPrAdMmxFiVehgT8KxgLIUw3WKpz
 YjR7VIgEAzsxEH1bX4NBn3CkOMs1JLAVZ5ue7a4AtN22SA6mzIY4I/4ZqQZGiRxqLdzMZcRyP
 M66U80fGIDa9vAMUhalpyKbojvl0YfmDoqUKG5Ur4lhJS6fj2B+L2i6EEICaZ2+PO0nPJBCI5
 CWGzIxdGrlC48cwWazwR1ecfxBq/usl7VR2yOrtndWk+Yq08PCAHLVS6Ld+QT3clK0ngP1c0I
 ew9gevXAD3cNb0Irmb9kGoN9kUnTSVrosgTWO5C5iXd+qeDRRSrahNPICfHzoM5XTV7faa3TU
 fnGlsWGIg0INGTEq42OSrVVxbpGrhfMb77OoN3nif0z0hCM3/YxfGxr6dNrx4FODch6/VOUZ1
 vsTUD+NGsYMXJ1k3Lta0njZtyhrxMh7+iEGgCAASSWV4VdTDJNtGPsJ2vQI/q2Jc9I6Pg7HkC
 d4dn6jqaHKC8DXBRcCGVWHyBoKLSE3fTUy+y4JtnWJ/GJRkSWDD0EuIeMvBkawdZxjzXf6RW9
 7ZsFjzgfbrQU+AmbkyCKoyo/ZfbEwaxtbiX8YYu7Y/q2iA75IAY6hnJ4m3Ii8hHz4HKl2mTmu
 7MwlTxP1uhfoOleRYkR8lp3D0uUzBzzYeLF40KTb6FhstcGqD90dJXJvIfF8X8wEGgDFcWudc
 GYBEwIBXTtuYwDIV6iUz2gCjj16mDCcbRAuJyaG0i090ZeEyOyrLyh5GDgmZXX4wnfk2uEZuq
 HxZbfuhB73NntHrRWh7V5ojJc84KSyi6WgirPe2U25hLaBhMBzq+FUakAxrV0a9V1mdBKpuzx
 Xw/glsPHNMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a devicetree for the i.MX507-based Kobo Aura e-book
reader, and fixes a few things in imx50.dtsi along the way.

v1: https://lore.kernel.org/lkml/20190319152421.16179-1-j.neuschaefer@gmx.=
net/

Changes in v2:
- Various cleanups, as suggested by Shawn Guo
- Patch "dt-bindings: arm: fsl: Add i.MX50 based boards" is new
- Squashed patch "ARM: dts: imx50-kobo-aura: Enable USB support" into
	patch 3 ("ARM: dts: imx50: Add Kobo Aura DTS")
- Dropped patch "ARM: dts: imx50: Add PHY node for usbotg and adjust
	clocks" because it was already merged into the imx tree
- Dropped patch "ARM: dts: imx50: Fix the numbering of the I2C
	controllers", because a similar one was merged into the imx tree
- Added Rob Herring's Reviewed-by tag to patch 1 ("dt-bindings: Add
	vendor prefix for Rakuten Kobo, Inc.")

A lot of functionality is still missing:
- poweroff/reboot, RTC, and battery monitoring support, as well as a PWM
  channel for the display backlight are provided by a custom embedded
  controller, which will be supported by a future patchset.
  The EC driver will also tell the EC to keep the board powered on;
  otherwise the EC will power the board off after about ten seconds
  (presumably to avoid battery drain if the OS is missing or corrupted)
- The touchscreen controller, eKTF2132, currently doesn't have a
  mainline driver.
- The e-paper display controller (EPDC) embedded in the i.MX50 SoC will
  need a whole new DRM driver, devicetree bindings, etc.
- The TPS65185 PMIC, which generates the voltages necessary for driving
  the E Ink panel, also needs a driver
- The backlight doesn't quite fit the existing pwm-backlight DT binding,
  because it uses an additional GPIO to boost the brightness. This
  requires some devicetree work
- Linux doesn't currently support suspend-to-ram on i.MX50

In order to keep the system running when CONFIG_PM is enabled, the
following fix is also required:
https://lore.kernel.org/lkml/20190326182258.21945-1-j.neuschaefer@gmx.net/

My own notes about this machine can be found here:
https://github.com/neuschaefer/linux/wiki/Kobo-Aura

Jonathan Neusch=C3=A4fer (3):
  dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.
  dt-bindings: arm: fsl: Add i.MX50 based boards
  ARM: dts: imx50: Add Kobo Aura DTS

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imx50-kobo-aura.dts         | 258 ++++++++++++++++++
 4 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx50-kobo-aura.dts

=2D-
2.20.1

