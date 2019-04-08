Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742752;
	bh=gEVs0luHgaKgDIB6rGGrV4eeCFe+sJCoOyIWVOVfJ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HbK5nqRdpPm+/m+vTNbVD19tl7bjKm5PPM/7fbtixPQZ1BTCcoU5PhosdBP5KX1h3
	 Jv+wBG36lt2PaOfIvIA1jhdJkBXZ2uT5uWrUz5xnBjeU/cYaCaRnydsNyX7xjQeyG3
	 jIh8Dg9oGNM1OJsAMyQy89MBR2x7wWqcVGxdaU3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfDHQ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbfDHQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LjqWFQd9f4udM9lpSAPOlXKEaiWBGg47uilrc82cBF4=; b=O2RCJU+Izw2lwl6lhULD/KHn9y
        6RUDOoHkgeMSwadrCjIK3VULH1jSqCPdesx9y1VcH9IpDsdIi4GpLj/xqZ9CT0h8CXQqM7Mo8rTSy
        VZHsCHPA6ubRr+co5ToHx7oeJjbmG200nj7CqIcxOy/yXlcEFr0ikwDotwVNQpYskmzY1JAgRWqOk
        S9B0roahluVU262orvJtXpCk4YS2wCeMCaPlZzTf89Vy8WTl9E72D5EMC4k7di8mqh20JorlXkoHw
        H32JYDzDAR7U+BC3hLe8VJZ0YN8/BD13xH5bHsKQRkx2ORtfv5BWu8ZQx/8DIb+Br7f2q4TmnS1er
        OuYZjX8Q==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005So-7V; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nD-8L; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/10] docs: ntb.txt: use Sphinx notation for the two ascii figures
Date:   Mon,  8 Apr 2019 13:58:20 -0300
Message-Id: <a4e40245a483aafeb3d820a05b44166cea11f189.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it to build with Sphinx, we need to fix the
notation for two ascii artwork.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ntb.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index a043854d28df..344a075f81f5 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -41,9 +41,10 @@ mainly used to perform the proper memory window initialization. Typically
 there are two types of memory window interfaces supported by the NTB API:
 inbound translation configured on the local ntb port and outbound translation
 configured by the peer, on the peer ntb port. The first type is
-depicted on the next figure
+depicted on the next figure::
+
+ Inbound translation:
 
-Inbound translation:
  Memory:              Local NTB Port:      Peer NTB Port:      Peer MMIO:
   ____________
  | dma-mapped |-ntb_mw_set_trans(addr)  |
@@ -58,9 +59,10 @@ maps corresponding outbound memory window so to have access to the shared
 memory region.
 
 The second type of interface, that implies the shared windows being
-initialized by a peer device, is depicted on the figure:
+initialized by a peer device, is depicted on the figure::
+
+ Outbound translation:
 
-Outbound translation:
  Memory:        Local NTB Port:    Peer NTB Port:      Peer MMIO:
   ____________                      ______________
  | dma-mapped |                |   | MW base addr |<== memory-mapped IO
-- 
2.20.1

