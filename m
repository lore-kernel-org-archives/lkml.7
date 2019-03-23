Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F90CC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86B2192B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCWObS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:18 -0400
Received: from asrmicro.com ([210.13.118.86]:25522 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWObS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:18 -0400
X-Greylist: delayed 1469 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Mar 2019 10:31:17 EDT
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5Bwm030919;
        Sat, 23 Mar 2019 22:05:11 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxqoa029570;
        Sat, 23 Mar 2019 21:59:52 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:01:28
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     qiaozhou <qiaozhou@asrmicro.com>
Subject: [PATCH 0/7] Add dts files for ASR8751C SoC
Date:   Sat, 23 Mar 2019 22:01:21 +0800
Message-ID: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxqoa029570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dtsi file for ASR8751C SoC and dts file for ASR8751C AquilaC development
board. Also add necessary dt-bindings document, header files.

Will add more driver of ASR8751C SoC in later patches. 

Qiao Zhou (7):
  dt-bindings: arm: asr: add ASR8751C bindings
  dt-bindings: bus: add ASR8751C APB/AXI bindings
  dt-bindings: clocks: add ASR8751C bindings
  dt-bindings: serial: add ASR8751C serial bindings
  dt-bindings: Add header file of ASR8751C clock driver
  dt-bindings: add header file of ASR8751C pinctrl driver
  arm64: dts: add dts files for asr Aquilac SoC

 .../devicetree/bindings/arm/asr/asr-8751c.txt      |   9 +
 Documentation/devicetree/bindings/bus/asr,bus.txt  |  42 ++
 .../devicetree/bindings/clock/asr,clock.txt        |  31 ++
 .../devicetree/bindings/serial/asr-serial.txt      |  23 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/asr/Makefile                   |   2 +
 arch/arm64/boot/dts/asr/asr8751c-aquilac.dts       |  58 +++
 arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi      | 400 ++++++++++++++++++
 arch/arm64/boot/dts/asr/asr8751c.dtsi              | 460 +++++++++++++++++++++
 include/dt-bindings/clock/asr8751c-clk.h           | 252 +++++++++++
 include/dt-bindings/pinctrl/asr8751c-pinfunc.h     | 341 +++++++++++++++
 12 files changed, 1620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
 create mode 100644 Documentation/devicetree/bindings/bus/asr,bus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/asr,clock.txt
 create mode 100644 Documentation/devicetree/bindings/serial/asr-serial.txt
 create mode 100644 arch/arm64/boot/dts/asr/Makefile
 create mode 100644 arch/arm64/boot/dts/asr/asr8751c-aquilac.dts
 create mode 100644 arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/asr/asr8751c.dtsi
 create mode 100644 include/dt-bindings/clock/asr8751c-clk.h
 create mode 100644 include/dt-bindings/pinctrl/asr8751c-pinfunc.h

-- 
2.7.4

