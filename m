Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500DC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DAD20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600464;
	bh=lJVXvgSVh1PubHkZQ2NeBKf24hax92kj9bnFmPHHqkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhvD+oxk0CG8Nkgkc4sUCQlu0JtFQ1byIAb4PKonm9v9jx9luu1EleoFAs8F/Tre9
	 +qPshh2zu2HU02y+b5rQ/Op/qckj6gMyQgfw3YutfdmDcA7VvzPEsNDaPpFKZGx2OZ
	 1+CkdfNoUlsYEp822r/EXRgssoJJmiwXx+Tkyt24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbfGHP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbfGHPYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:24:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E8E204EC;
        Mon,  8 Jul 2019 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599492;
        bh=lJVXvgSVh1PubHkZQ2NeBKf24hax92kj9bnFmPHHqkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwQ75MIGi90MhnuqX9LeM9DoIhnrIpljj9AP6Oqwk5fQ/B4VPRRcGF+x08kRjfyyv
         1ujA2lv5a77RFlBx2zsbTOfjw1XZtvgQEdCIT5muU23Bf/CR2kJoJ89wljcM4KLq1F
         k8Kv7dzfcW9RNXn6krJCWBEMvybclEARmbRadWdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.14 33/56] ARM: dts: armada-xp-98dx3236: Switch to armada-38x-uart serial node
Date:   Mon,  8 Jul 2019 17:13:25 +0200
Message-Id: <20190708150523.031613831@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
References: <20190708150514.376317156@linuxfoundation.org>
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
@@ -360,3 +360,11 @@
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


