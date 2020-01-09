Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DFFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680C2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgAILkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:40:45 -0500
Received: from mail.manjaro.org ([176.9.38.148]:37770 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgAILko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:40:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 654F136E4E5F;
        Thu,  9 Jan 2020 12:40:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IuGOKE8CgWh1; Thu,  9 Jan 2020 12:40:41 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RESEND 0/2] power: supply: add support for CW2015 fuel gauge
Date:   Thu,  9 Jan 2020 12:39:53 +0100
Message-Id: <20200109113955.2882-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the CW2015 Fuel Gauge.
The CW2015 fuel gauge is used in Pinebook Pro and some Raspberry Pi UPS HATs.

Most of the code has been written by Rockchip. I've added devicetree support
for power supplies as well as the alert level and done some general code
cleanup.
I'm submitting it now as part of an effort to get full mainline Linux support
for the Pinebook Pro.

This is just a resend to the relevant maintainers due to lack of feedback.

Tobias Schramm (2):
  power: supply: add CW2015 Fuel Gauge driver
  dt-bindings: power: supply: cw2015_battery: add device tree binding
    documentation

 .../bindings/power/supply/cw2015_battery.txt  |  37 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2015_battery.c         | 962 ++++++++++++++++++
 include/linux/power/cw2015_battery.h          | 122 +++
 5 files changed, 1129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
 create mode 100644 drivers/power/supply/cw2015_battery.c
 create mode 100644 include/linux/power/cw2015_battery.h

-- 
2.24.1

