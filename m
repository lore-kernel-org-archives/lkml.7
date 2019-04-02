Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A5EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D1821473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfDBNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:47:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43058 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731406AbfDBNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:04 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0002ol-4n; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004uN-KC; Tue, 02 Apr 2019 14:40:00 +0100
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
Message-ID: <lsq.1554212307.704848865@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 49/99] pinctrl: sh-pfc: sh73a0: Add missing TO pin to
 tpu4_to3 group
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

commit 124cde98f856b6206b804acbdec3b7c80f8c3427 upstream.

The tpu4_to3_mux[] array contains the TPU4TO3 pin mark, but the
tpu4_to3_pins[] array lacks the corresponding pin number.

Add the missing pin number, for non-GPIO pin F26.

Fixes: 5da4eb049de803c7 ("sh-pfc: sh73a0: Add TPU pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2676,6 +2676,7 @@ static const unsigned int tpu4_to2_mux[]
 };
 static const unsigned int tpu4_to3_pins[] = {
 	/* TO */
+	PIN_NUMBER(6, 26),
 };
 static const unsigned int tpu4_to3_mux[] = {
 	TPU4TO3_MARK,

