Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68496C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfB1O0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40533 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727861AbfB1O0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:13 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SEIAfk027219;
        Thu, 28 Feb 2019 15:25:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtxd4hu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 15:25:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7840638;
        Thu, 28 Feb 2019 14:25:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5463A5993;
        Thu, 28 Feb 2019 14:25:58 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb
 2019 15:25:58 +0100
Received: from localhost (10.201.23.19) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb 2019 15:25:56
 +0100
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/4] Enable stm32mp1 camera support
Date:   Thu, 28 Feb 2019 15:25:41 +0100
Message-ID: <1551363945-19497-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.19]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset serie enables camera of stm32mp157c evaluation board.
To do so, both stm32mp157c DCMI camera interface driver and OV5640 camera
module driver are enabled in devicetree.

DCMI camera interface driver is enabled by default in multi_v7 configuration
but OV5640 driver remains to be selected at kernel configuration time.

This patchset depends on STMicroelectronics Multi-Function eXpander
(STMFX) support [1].

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1944108.html

Hugues Fruchet (4):
  ARM: dts: stm32: add 2v8 fixed regulator for stm32mp157c-ed1 board
  ARM: dts: stm32: add DCMI camera interface support on stm32mp157c
  ARM: dts: stm32: add DCMI pins to stm32mp157c
  ARM: dts: stm32: enable OV5640 camera on stm32mp157c-ev1 board

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 41 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |  8 +++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 56 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 12 +++++++
 4 files changed, 117 insertions(+)

-- 
2.7.4

