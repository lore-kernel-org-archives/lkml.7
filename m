Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147D9208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="ngyTpd0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfIVUMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 16:12:10 -0400
Received: from srv1.deutnet.info ([116.203.153.70]:44648 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfIVUMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-ID:Subject:Cc:To:From:Date:in-reply-to;
         bh=WYqSRmShYv+mCIhkeewSXz5HQYlLY74vddON30mJFy4=; b=ngyTpd0YvvPwAFlucN5VSrmzo
        JO1tM9rfJ1uQt3JjXuyT7gqGWkKy1KUYTFl+8AlTl+3/u9CBanlWHFnoYuRwVPtakjMXC+oJ1k3ns
        zjFCqr97nnTEY7Fl0QLH/z4kSP2Npdse6FpzC2aPkkyJ8cEYa89nQeVW4yRx/WX/h/eLwSLeiFBzI
        vbNzv8dN7o+d2GX0ZQZxY+grxoC8TFzwx6pSCyTJSGwekDbITGpcvkO4WHc7XnTbKSkGqgfzgjEwp
        rL+JTO9shWh+65ZKJXXF2Him73ACHwUMRJE57ZwLOfu6frcTgtDvP0ZdzVf+gr4XalF/nY05hMEcy
        Ln0txHl5w==;
Received: from [2001:bc8:3dc9::1] (helo=localhost)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iC8DF-0007sd-SW; Sun, 22 Sep 2019 22:12:05 +0200
Received: from agriveaux by localhost with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iC8DF-007vde-BS; Sun, 22 Sep 2019 22:12:05 +0200
Date:   Sun, 22 Sep 2019 22:12:05 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, agriveaux@deutnet.info
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] MIPS: CI20: DTS: Add nodes to Creator CI20 board
Message-ID: <cover.1569181001.git.agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attemping to make my CI20 more usefull than a paperweight, I add nodes to Devicetree, at this time:

- The IW8103 need some work to stay alive because power seem to turn off.
- The leds patch lack of correct option in ci20_defconfig.
- The Cpu patch isn't usefull without SMP support of jz4780.

Alexandre GRIVEAUX (4):
  MIPS: CI20: DTS: Add I2C nodes
  MIPS: CI20: DTS: Add IW8103 Wifi + bluetooth
  MIPS: CI20: DTS: Add Leds
  MIPS: JZ4780: DTS: Add CPU nodes

 arch/mips/boot/dts/ingenic/ci20.dts    | 214 +++++++++++++++++++++++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi |  17 ++
 2 files changed, 231 insertions(+)


base-commit: 4c37310a2e605357cf47b3d357696309f1181b5c
-- 
2.20.1

