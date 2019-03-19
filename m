Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A4820811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fyaALP0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCSPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:24:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:44039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfCSPYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009075;
        bh=idC0Frf0MQ+X1IZan2qPvfUKs86PwQeHY6WHbPRgshU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fyaALP0e+uvc4W9lchEIJlGU1+FsldnyGUlt88QvGeRd+GPR5AyclyTymASkpxcpI
         UdVxHM0bMAfcy9EFSmm5rhUCeadnn2tFYkMShAeh8lcIvLJR6PTeq5snwpWWThDBbD
         YRRrInZGQe3hqaDffKt3gq6xEIkpnwet7iYT/zCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKqOW-1h6GbT0f9k-0000rG; Tue, 19
 Mar 2019 16:24:35 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/5] ARM: Initial devicetree for Kobo Aura
Date:   Tue, 19 Mar 2019 16:24:15 +0100
Message-Id: <20190319152421.16179-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ANUokbXIXrt+WdEwWYfdguz8F3r6YT4KtuiY43BC8L1c3wxnpPi
 zuQJpXPSLhIAw/76Zh/dUtG5dwfI6UnicX4mLUu6nbD7y1Be8UYYo2of6Sm7kkhujbxMeAO
 6TYLL7FckSnJnS9LLVJQAM2WE4zGZ3Qg7Nxcz/hQBMEeWw4V/gVF3hWRvrrB7PNzOAzhcT5
 Ix8MroDNXLv3tcdKhRXvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2yBFLwoLqa8=:q8UDSmPfVCyOf6OJjrDHkU
 Bd9mppP5mJApt/4nS1PK/z/DCZ9n8XRo/S5DwbE4P4Ytc8M8dmGKEEIr6Yib09f4vKdKkkkIA
 LMPOmU0MU7oOKTblBbzcDHhaMkWPWJdbupwODwszMdWDgRnI44R5wlR37TKzNq4qgYwGcMk/f
 qjRVpLDw1y6SVJGlPLTwW7iSTtxwos4Ofy2RHS6DR49vyPuALDnEi/ZYL+UY5kC+sRbcdbmif
 k0G7dnMrck3Mmt1ln8J1w2YMdJ9SWg7kT9PbZKtmxi9/6JERGL7uz4PG/P/kQC5DPNSDcTBfF
 3XGgfsHC2SXpmxkJx1v7DCPKrpaD6JtCwxW+hgM3x3UXd0C1YPyUIESMU+YM192yk7HbBHIFH
 2nCc9C4ypSWf7/SNk8FZlm5eKeGo+SR/us5m1Z9c750FtXJwZvYWTQQ3+w3t/DeR3EwBomt5N
 WRNpYDTJFPqgxAX47KoYh47l4vh02whJ1elmy5OEuhZ19IMbMfuvgjPSCNlgpMl3fLpDZgmxx
 B4o87RGHw8mrk+GsFrwB1PBPnQKMi9Ntqa3sv1nnKOlVO5GbGZuIaVUxrsVS3SWYeJ2JbvMLg
 M5sxaKScQXygFKWOsD7YUmMfIx6KXUX9nEI5Lkj6HWRdriGgLe+ev8fzjaej0FAoiFOct12EQ
 ok3Wl11wSmWG6MyP16ktyrPvRXSi4RWQRAimwNK6bu4b6VsiPJvuxjvU/o7ZWYZMfRqSemHlt
 yXekbiSbDCsrWkXu7EIfHCnOJgxRfBhRdjKPqHq+/BpWLoKuD+S6CVncPw14XG7XQO2oqqzhI
 JfFEaOyKueABMMF3BDpqbG+9yTG2j/fkwXbQAUoEOhHq+67BM1mUt+/sAWSH5JmG4LfotQUWd
 d3MuBZFHlM/d4sNGY88KcuaidobGfLmauWKT4as1icrX8nXoy12eXX/T2fU9+mRdGX6Cq0Y8L
 W16y5EYiO2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a devicetree for the i.MX507-based Kobo Aura e-book
reader, and fixes a few things in imx50.dtsi along the way.

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
https://lore.kernel.org/lkml/20190318231737.8459-1-j.neuschaefer@gmx.net/

My own notes about this machine can be found here:
https://github.com/neuschaefer/linux/wiki/Kobo-Aura

Jonathan Neusch=C3=A4fer (5):
  dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.
  ARM: dts: imx50: Add Kobo Aura DTS
  ARM: dts: imx50: Add PHY node for usbotg and adjust clocks
  ARM: dts: imx50-kobo-aura: Enable USB support
  ARM: dts: imx50: Fix the numbering of the I2C controllers

 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imx50-kobo-aura.dts         | 263 ++++++++++++++++++
 arch/arm/boot/dts/imx50.dtsi                  |  14 +-
 4 files changed, 279 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx50-kobo-aura.dts

=2D-
2.20.1

