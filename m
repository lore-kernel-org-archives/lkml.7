Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FD8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F30205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfCZJ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:58:38 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:38968 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfCZJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:58:37 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h8iqk-0000ip-L8 from Jiada_Wang@mentor.com ; Tue, 26 Mar 2019 02:58:30 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 26 Mar 2019 02:58:27 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiada_wang@mentor.com>
Subject: [PATCH v4 0/1] rsnd: dts: change to use extended audio dmac register
Date:   Tue, 26 Mar 2019 18:58:25 +0900
Message-ID: <20190326095826.4987-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to user reference manual for R-CAR H3, M3-W and M3-N SoCs,
in order to access busif4 ~ busif7, extended audio dmac registers
(PDMASAREn, PDMADAREn, PDMACHCREn)
need to be used, rather than basic audio dmac registers
(PDMASARn, PDMADARn, PDMACHCRn)

Now DT bindings has stated that extended Audio dmac register set need
to be used when available with patch
https://patchwork.kernel.org/patch/10856905/

This patch set updates H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965)
to use extended audio dmac register set.

---
v4: use a single patch to update

v3: update H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965) to point
    point to extended audio dmac register set in DT

v2: update rsnd driver to use extended register set when available
    rename R-CAR E3 audio dmac regisetr

v1: initial version

Jiada Wang (1):
  arm64: dts: renesas: use extended audio dmac register

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.2

