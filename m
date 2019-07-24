Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC772C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DAB20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997363;
	bh=ZoxoJX3JIBSKtw7+QATylHzz1N3zv5WldLucO3PBzVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dOR8XfJecv1bRiRtig2gyCdmMXwk5EgjgIt9RXBHG2Kme8YKopG+q0ETaHpmhTkYR
	 AJulRsiYAB9rq4j6ZFUZKH19/W18dSPK7OIzWeQgI9UJANFcVt4w4CTeWlti9hHI2u
	 w4P8S+gpOYDCBk6m06ltdCv8AvcvOjhPpyDD0j54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbfGXTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388827AbfGXTmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3962F2083B;
        Wed, 24 Jul 2019 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997358;
        bh=ZoxoJX3JIBSKtw7+QATylHzz1N3zv5WldLucO3PBzVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epj/AAjwYaCRWKTHPVPOfhzjNL9bQ2fXPzqzyUQ3NusTgSJ3p1CSJDjnRBRQUKC65
         w/1gwqiMOBBLy1JD/yc/u0b9OsI/BMn817yfHiNpVYfx+OFy1tEUxNHobRbxRXa0zZ
         L6r8q4dE7QzQ93Vep2U35LUF28BaCY8tZC6wOSjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Josua Mayer <josua@solid-run.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 409/413] dt-bindings: allow up to four clocks for orion-mdio
Date:   Wed, 24 Jul 2019 21:21:40 +0200
Message-Id: <20190724191803.813439280@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josua Mayer <josua@solid-run.com>

commit 80785f5a22e9073e2ded5958feb7f220e066d17b upstream.

Armada 8040 needs four clocks to be enabled for MDIO accesses to work.
Update the binding to allow the extra clock to be specified.

Cc: stable@vger.kernel.org
Fixes: 6d6a331f44a1 ("dt-bindings: allow up to three clocks for orion-mdio")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/net/marvell-orion-mdio.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
+++ b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional properties:
 - interrupts: interrupt line number for the SMI error/done interrupt
-- clocks: phandle for up to three required clocks for the MDIO instance
+- clocks: phandle for up to four required clocks for the MDIO instance
 
 The child nodes of the MDIO driver are the individual PHY devices
 connected to this MDIO bus. They must have a "reg" property given the


