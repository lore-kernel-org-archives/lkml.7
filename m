Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ECFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AA52133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCSOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:51:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:51:58 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6G5s-0007aQ-Hf; Tue, 19 Mar 2019 15:51:56 +0100
Date:   Tue, 19 Mar 2019 15:51:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Roman Kiryanov <rkir@google.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers: power: supply: goldfish_battery: Fix bogus SPDX
 identifier
Message-ID: <alpine.DEB.2.21.1903191529010.2537@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spdxcheck.py complains:

 drivers/power/supply/goldfish_battery.c: 1:28 Invalid License ID: GPL

which is correct because GPL is not a valid identifier. Of course this
could have been caught by checkpatch.pl _before_ submitting or merging the
patch.

 WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/...
 #19: FILE: drivers/power/supply/goldfish_battery.c:1:
 +// SPDX-License-Identifier: GPL

Which is absolutely hillarious as the commit introducing this wreckage says
in the changelog:

  There was a checkpatch complain:
    
    "Missing or malformed SPDX-License-Identifier tag".

Oh well. Replacing a checkpatch warning by a different checkpatch warning
is a really useful exercise.

Use the proper GPL-2.0 identifier which is what the boiler plate in the
file had originally.

Fixes: e75e3a125b40 ("drivers: power: supply: goldfish_battery: Put an SPDX tag")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index ad969d9fc981..c2644a9fe80f 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Power supply driver for the goldfish emulator
  *
