Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2322C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7788E2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EXI6OBGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfG1TwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:52:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:50815 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1TwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564343543; x=1595879543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TQZHxFyuKFJqN7+q9YByiunsHnWg6Vq9Zg3jp/Zcago=;
  b=EXI6OBGccST6dMss/9saEKnOz7Pjiuvg3xBhKCETJsX/FFxd9Y9qTXxH
   xctKMEaNs9c7c+IcsYTd9NLkX50D5b5gMnCfQmIR2jOpnWCRg3nI67KEk
   ydrlVQEKWpMJny+3bMA44RnlEJh6FHDwCH0uXL1M2R7ytwb9dRB36WBeE
   8=;
X-IronPort-AV: E=Sophos;i="5.64,319,1559520000"; 
   d="scan'208";a="688577182"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Jul 2019 19:52:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id B6940A220D;
        Sun, 28 Jul 2019 19:52:07 +0000 (UTC)
Received: from EX13D05EUC002.ant.amazon.com (10.43.164.231) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:52:07 +0000
Received: from u18dbf258377358bea500.amazon.com (10.43.160.25) by
 EX13D05EUC002.ant.amazon.com (10.43.164.231) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:51:58 +0000
From:   Ronen Krupnik <ronenk@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <barakw@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <jonnyc@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, Ronen Krupnik <ronenk@amazon.com>
Subject: [PATCH 0/2] Amazon Annapurna Labs Alpine v3 device-tree
Date:   Sun, 28 Jul 2019 22:51:33 +0300
Message-ID: <20190728195135.12661-1-ronenk@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.25]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D05EUC002.ant.amazon.com (10.43.164.231)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the device tree for Amazon Annapurna Labs Alpine v3
SoC and Evaluation Board.

Ronen Krupnik (2):
  dt-bindings: amazon: add Amazon Annapurna Labs Alpine support
  arm64: dts: amazon: add Amazon Annapurna Labs Alpine v3 support

 .../devicetree/bindings/arm/amazon,alpine.txt |  23 ++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/amazon/Makefile           |   1 +
 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts  |  23 ++
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     | 371 ++++++++++++++++++
 5 files changed, 419 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amazon,alpine.txt
 create mode 100644 arch/arm64/boot/dts/amazon/Makefile
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi

-- 
2.21.0

