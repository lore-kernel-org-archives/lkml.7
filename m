Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6967ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9989B20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ztBt+TDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:34:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15408 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbfJGOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:34:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97EVeYl021701;
        Mon, 7 Oct 2019 16:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Z6JwJ7BA4jHWAT0HHOYTMuKD4KHqxvNFYvDntJKt8Cs=;
 b=ztBt+TDuhXSbnwSv2ZtYNw8umrUsXzzT28B7eT7txWClmlqFX8U9d13MZfm3mADgPVI0
 pyIWyQfGi3xA/E9bQamRyIpj+MhZ6ogzVFyq7eIe4RyYPwNGy4NiuxiZsTCWBeapien2
 /R8CE2yAekiUaTD1zBX/NRoSC+APC3aZ1wes83NZ3fVUAwN1tH19PMqWWMriO07gbD+P
 0y15Myl2QNpR0Lk70a7kvnJe6Xa5aJ//eSlcsV28P2RDUl6UnJ3qx/47b9H7Re15t0Hr
 4WZ8Xq7UZI1TdYPoDf/x5KmSmc/Kv55It80+dWBVtlvp5OSQNlPwhkpfIAJoL0MJWeMx 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0jw3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 16:34:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20FAB10002A;
        Mon,  7 Oct 2019 16:34:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E51362B4929;
        Mon,  7 Oct 2019 16:34:04 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 16:34:04
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ARM: dts: stm32: Add fixes to be compliant with DT validation tool
Date:   Mon, 7 Oct 2019 16:33:58 +0200
Message-ID: <20191007143402.13266-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates STM32 DT files in order to clean some issues seen during
STM32 device trees validation ("make dtbs_check"). 

Regards
Alex


Alexandre Torgue (4):
  ARM: dts: stm32: fix memory nodes to match with DT validation tool
  ARM: dts: stm32: fix joystick node on stm32f746 and stm32mp157c eval
    boards
  ARM: dts: stm32: remove usb phy-names entries on stm32mp157c-ev1
  ARM: dts: stm32: fix regulator-sd_switch node on stm32mp157c-ed1 board

 arch/arm/boot/dts/stm32429i-eval.dts   | 2 +-
 arch/arm/boot/dts/stm32746g-eval.dts   | 3 +--
 arch/arm/boot/dts/stm32f429-disco.dts  | 2 +-
 arch/arm/boot/dts/stm32f469-disco.dts  | 2 +-
 arch/arm/boot/dts/stm32f746-disco.dts  | 2 +-
 arch/arm/boot/dts/stm32f769-disco.dts  | 2 +-
 arch/arm/boot/dts/stm32h743i-disco.dts | 2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts  | 2 +-
 arch/arm/boot/dts/stm32mp157a-dk1.dts  | 1 +
 arch/arm/boot/dts/stm32mp157c-ed1.dts  | 3 ++-
 arch/arm/boot/dts/stm32mp157c-ev1.dts  | 3 ---
 11 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.17.1

