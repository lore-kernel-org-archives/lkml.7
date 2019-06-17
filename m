Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6824BC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3971B20673
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RBX6hDyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfFQVzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:55:07 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51471 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFQVzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:55:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23A5C891AA;
        Tue, 18 Jun 2019 09:55:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1560808501;
        bh=uWswnLC9JDOgKH6JaycxBw+ZEM0pqEpSuyJqdcj45FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RBX6hDyY0BJBt2/YjWO2qIcj5NVuw5dUovHdvMrpFSpy0fza6TvmiHKGJndwvZE5E
         9iLV7Qqh6AXDD7jUlFT8Y9e3sMb3dpeSkl0v9Q8Nq0PjZ1Fl4cAxg7LyJR78rm6sqq
         GJnkqE7svAMJ2m7ro2xcEampWrVMe9CMobKofntUgDTUfL7O2pfh+DwcY0R3JLje4n
         LbRD0mX30k7hxcPUrcTeJJxBRFU8iDdWzOxLD0k4yeSJj/P7icS9Wb7O7y30ITtzBm
         vc2hhjaVyc6+Qz7Ws4a3Ipf0HTzgD8BzauB5ed3stticeVY2t9D0441nDKr0CYOaCO
         0/GnPT8PFh3OQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d080c340008>; Tue, 18 Jun 2019 09:55:00 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 6723E13EEEE;
        Tue, 18 Jun 2019 09:55:01 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 415571E04F0; Tue, 18 Jun 2019 09:55:00 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/4] dt-bindings: clock: mvebu: Add compatible string for 98dx1135 core clock
Date:   Tue, 18 Jun 2019 09:54:56 +1200
Message-Id: <20190617215458.32688-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz>
References: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the core clock on the 98dx1135 switch with
integrated CPU.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Update description to make it clear the clock names are the same as Kir=
kwood

 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt=
 b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index 796c260c183d..d8f5c490f893 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -59,6 +59,7 @@ Required properties:
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
 	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
+	"marvell,mv98dx1135-core-clock" - for Kirkwood 98dx1135 SoC
 	"marvell,mv88f5181-core-clock" - for Orion MV88F5181 SoC
 	"marvell,mv88f5182-core-clock" - for Orion MV88F5182 SoC
 	"marvell,mv88f5281-core-clock" - for Orion MV88F5281 SoC
--=20
2.21.0

