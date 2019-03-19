Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50445C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2755E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCSF5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:57:18 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:51416 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:57:17 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h67kN-00064s-Vn from Jiada_Wang@mentor.com ; Mon, 18 Mar 2019 22:57:12 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 18 Mar 2019 22:57:08 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <geert@linux-m68k.org>, <jiada_wang@mentor.com>
Subject: [PATCH v3 0/3] rsnd: dts: change to use extended audio dmac register
Date:   Tue, 19 Mar 2019 14:57:02 +0900
Message-ID: <20190319055705.24115-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
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
v3: update H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965) to point
    point to extended audio dmac register set in DT

v2: update rsnd driver to use extended register set when available
    rename R-CAR E3 audio dmac regisetr

v1: initial version

Jiada Wang (3):
  arm64: dts: renesas: r8a7795: use extended audio dmac register
  arm64: dts: renesas: r8a7796: use extended audio dmac register
  arm64: dts: renesas: r8a77965: use extended audio dmac register

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.2

