Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA7DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3E20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfDBNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:46:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43130 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731422AbfDBNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:04 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0002os-Bd; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004uc-NL; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Simon Horman" <horms+renesas@verge.net.au>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.864702870@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 52/99] pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 9540cbdfcd861caf67a6f0e4bb7f46d41c4aad86 upstream.

The Port C I/O Register 0 contains 7 reserved bits, but the descriptor
contains only dummy configuration values for 6 reserved bits, thus
breaking the configuration of all subsequent fields in the register.

Fix this by adding the two missing configuration values.

Fixes: f5e811f2a43117b2 ("sh-pfc: Add sh7269 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/sh-pfc/pfc-sh7269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -2119,7 +2119,7 @@ static const struct pinmux_cfg_reg pinmu
 	},
 
 	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1) {
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PC8_IN, PC8_OUT,
 		PC7_IN, PC7_OUT,
 		PC6_IN, PC6_OUT,

