Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D3C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D6C2245D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hdscKC8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfKTLFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:05:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38698 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfKTLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oppy+F+0JaaCkFHzOboj6zfi/ynUAor3Lsm2TZQUzXo=; b=hdscKC8k4aCUGOpSCrLWZ0qr7
        J3RITMqSzQHKbgTmpQsSBFX1bIQUH6+KL37wWns3CXS1iYD6XGYBQRZCxdVnw1y6prKiHgAPR/Lgi
        tW+Mvjn5VMx/yBULUzsl248AqbMZSpQ0al1oAhBti++euAuhib3JGExA8PQZw+Uw3aikPijHrNwTa
        Q5ByKuGU7eGQyNuFOeoLimStdQnTF8gNm6Y70p4dH7YKdJ7W5Rp/htWbOyL136AGQFYKJYLu6sNgA
        vyJLqM17lOGXj4ljaMmC0EEnCnkT7msXUMmml5BbIH4BwoTpnNEIFaCg8x88meQyu3G6FjMz2qKSJ
        pjEf6GeGA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58734)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXNnf-0007tE-8F; Wed, 20 Nov 2019 11:05:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXNne-0001gL-Jr; Wed, 20 Nov 2019 11:05:30 +0000
Date:   Wed, 20 Nov 2019 11:05:30 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove Joern Engel's address in MAINTAINERS
Message-ID: <20191120110530.GO25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joern's email address seems to be non-functional for 22 days, failing
with "No route to host".  So, it's pointless having the entry in
MAINTAINERS.  Remove the address and mark the items as orphans.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Tracerouting the IP (213.229.74.203) gives:

 8  kvm10uk.cheapvps.co.uk (213.229.125.119)  23.298 ms  18.688 ms 19.051 ms
 9  kvm10uk.cheapvps.co.uk (213.229.125.119)  2384.829 ms !H  2384.941 ms !H  2385.424 ms !H

The domain is due to expire in two days, so will be interesting to
see what happens.

If anyone has an updated address, please correct maintainers!

 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc39f7f5dc34..5950cd457b24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2998,9 +2998,8 @@ F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
 BLOCK2MTD DRIVER
-M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-S:	Maintained
+S:	Orphan
 F:	drivers/mtd/devices/block2mtd.c
 
 BLUETOOTH DRIVERS
@@ -12671,9 +12670,8 @@ F:	include/uapi/linux/phonet.h
 F:	net/phonet/
 
 PHRAM MTD DRIVER
-M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-S:	Maintained
+S:	Orphan
 F:	drivers/mtd/devices/phram.c
 
 PICOLCD HID DRIVER
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
