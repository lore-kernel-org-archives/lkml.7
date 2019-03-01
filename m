Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBF6218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfCAIsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:48:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbfCAIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:48:16 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x218lEKL021264;
        Fri, 1 Mar 2019 09:48:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6dajfe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 01 Mar 2019 09:48:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A4CD38;
        Fri,  1 Mar 2019 08:48:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 053382B17;
        Fri,  1 Mar 2019 08:48:00 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:47:59 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:47:59 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  0/7] ARM: dts: stm32: add support of sdmmc1 on stm32
Date:   Fri, 1 Mar 2019 09:47:41 +0100
Message-ID: <1551430068-9456-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds support of sdmmc1 on:
-stm32h743i (boards: eval, disco)
-stm32mp1 (boards: ed1, dk1)

Ludovic Barre (7):
  ARM: stm32: add AMBA support for stm32 family
  ARM: dts: stm32: add sdmmc1 support on stm32h743
  ARM: dts: stm32: add sdmmc1 support on stm32h743i eval board
  ARM: dts: stm32: add sdmmc1 support on stm32h743i disco board
  ARM: dts: stm32: add sdmmc1 support on stm32mp157c
  ARM: dts: stm32: add sdmmc1 support on stm32mp157c ed1 board
  ARM: dts: stm32: add sdmmc1 support on stm32mp157a dk1 board

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi  | 68 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi          | 14 +++++++
 arch/arm/boot/dts/stm32h743i-disco.dts    | 20 +++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts     | 23 ++++++++++-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 68 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts     | 20 +++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     | 37 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 14 +++++++
 arch/arm/mach-stm32/Kconfig               |  5 +--
 9 files changed, 264 insertions(+), 5 deletions(-)

-- 
2.7.4

