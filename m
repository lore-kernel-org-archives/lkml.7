Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E4DC606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D1821537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600187;
	bh=/FKc4kjIe82GxU9Sjc+/PTPdm3BLOpOWYvdj+AgWmkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSiIsbfs7XP7lrpCposWoQ9Bw1PfozCiXpWzR9OgNjKIlf4orZZu3gIPzUEqMPGx3
	 8dlad89jlTSgFcn37kPXRjIQ4Z0ki1QcvHIqn66rlMt+AOkqrrygt5C++9BNM42trX
	 +J0vlO6u+Rk+l0x+knm/G8VijoFaOKFOspit3DYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbfGHPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbfGHPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:33:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1AE21537;
        Mon,  8 Jul 2019 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600027;
        bh=/FKc4kjIe82GxU9Sjc+/PTPdm3BLOpOWYvdj+AgWmkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0FDfSDdzF4y1LiM1F8pLxDydfOoxoSPedo87IMbjJwppTN/vXXriyR8kRhD3UHEx
         erSvKB0YBIRldD+kD/Wk9WErESU+C6qyZtywaRarQkcgqRUE38vGlY9xuGpw1geYAX
         4rfj4tcKXAb3/k1mb63JhLhZzm0tSj7mrfLZksCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 5.1 70/96] ARM: dts: armada-xp-98dx3236: Switch to armada-38x-uart serial node
Date:   Mon,  8 Jul 2019 17:13:42 +0200
Message-Id: <20190708150530.239267964@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Scott <joshua.scott@alliedtelesis.co.nz>

commit 80031361747aec92163464f2ee08870fec33bcb0 upstream.

Switch to the "marvell,armada-38x-uart" driver variant to empty
the UART buffer before writing to the UART_LCR register.

Signed-off-by: Joshua Scott <joshua.scott@alliedtelesis.co.nz>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>.
Cc: stable@vger.kernel.org
Fixes: 43e28ba87708 ("ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -336,3 +336,11 @@
 	status = "disabled";
 };
 
+&uart0 {
+	compatible = "marvell,armada-38x-uart";
+};
+
+&uart1 {
+	compatible = "marvell,armada-38x-uart";
+};
+


