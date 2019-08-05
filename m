Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A990208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UCaKGme6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfHETtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:49:46 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.147]:11724 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfHETtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:49:46 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7E330400CD79F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2019 14:49:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uizJhBG9KdnCeuizJhdGzB; Mon, 05 Aug 2019 14:49:45 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xZvmNQWkP13y7swlL9SJ9LeGDDnwPw+077qyfdnX8C8=; b=UCaKGme6a3j8oUc9WIaUXSrCly
        JZX162Ll3dhwRCAOTRgB7lerALEG26AhLN4e3RdhZ1Ou/sbhj61OY1UwlctHymSL3NWR/tIZ6+kWB
        WczsXGMvJSXy+iKxAsGc1+2MJZEQEq+IjSXXnkJ8T2wZRvKP9Pt7D6UfVmTRyXIbTmMw+q3mYReV/
        y9PZ8U5JLaRT1p1PX9zlYz1vMFTlFKKRNp+y6MoDyAGVa12VTeJXhrCLvl5+q8ecyYkNT2MmhZ7+Y
        hfabhw6QyBmFHzpiQn6a5RS4w1+04cfajackZP08Xzh345lrP4u6GWdmNIgnlIaF9AM7Z7CngyqzY
        uZ9fqNAw==;
Received: from [187.192.11.120] (port=38228 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huizI-003RAT-IQ; Mon, 05 Aug 2019 14:49:44 -0500
Date:   Mon, 5 Aug 2019 14:49:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] pcmcia: db1xxx_ss: Mark expected switch fall-throughs
Message-ID: <20190805194942.GA15816@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1huizI-003RAT-IQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:38228
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: db1xxx_defconfig mips):

drivers/pcmcia/db1xxx_ss.c:257:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/pcmcia/db1xxx_ss.c:269:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pcmcia/db1xxx_ss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index eb6168e6ac43..590e594092f2 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -255,8 +255,10 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
 	switch (state->Vcc) {
 	case 50:
 		++v;
+		/* fall through */
 	case 33:
 		++v;
+		/* fall through */
 	case 0:
 		break;
 	default:
@@ -267,9 +269,11 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
 	switch (state->Vpp) {
 	case 12:
 		++p;
+		/* fall through */
 	case 33:
 	case 50:
 		++p;
+		/* fall through */
 	case 0:
 		break;
 	default:
-- 
2.22.0

