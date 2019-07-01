Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C5C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B20E206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfGAPGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfGAPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95587AFFC;
        Mon,  1 Jul 2019 15:06:40 +0000 (UTC)
Date:   Mon, 1 Jul 2019 17:06:38 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: kpc2000: drop useless softdep statement
Message-ID: <20190701170638.68bd414d@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-dev module is for access to I2C buses from user-space.
Kernel drivers do not care about its presence.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-5.2-rc7.orig/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c	2019-06-30 05:25:36.000000000 +0200
+++ linux-5.2-rc7/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c	2019-07-01 11:33:17.336697545 +0200
@@ -26,7 +26,6 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
-MODULE_SOFTDEP("pre: i2c-dev");
 
 struct i2c_device {
     unsigned long           smba;


-- 
Jean Delvare
SUSE L3 Support
