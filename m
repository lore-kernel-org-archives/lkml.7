Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A14C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43720657
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="N8sblq5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfEVFGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:06:32 -0400
Received: from knopi.disroot.org ([178.21.23.139]:56596 "EHLO
        knopi.disroot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfEVFGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:06:31 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 01:06:30 EDT
Received: from localhost (localhost [127.0.0.1])
        by disroot.org (Postfix) with ESMTP id 7EF9131B3E;
        Wed, 22 May 2019 06:56:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
        by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wdt2zU0bTsSf; Wed, 22 May 2019 06:56:28 +0200 (CEST)
From:   Danct12 <danct12@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
        t=1558500988; bh=cUyYO5S5sXr4QZV6EMFJnvjOOFs7PlhMXBPFHuuXFXI=;
        h=From:To:Cc:Subject:Date;
        b=N8sblq5odSB28YVBuhxZSc1YI5GeEf1w+YhsCnR+W28uNwz3JaG69YkhrSpUXxDh7
         uURWqqXX5Xrk1GfBc0gs03Nly8Dat71ynS572ntNd5O+8tZxBIToswPmeJ7mp5qW5B
         2vKTN3FYLx7kM6Y+64EPuf7CUnJv5SMJX2RMgIGuWloUGT1zady3rk3PMkKYVSMRXn
         8CbHeyLjG7Sw9t3xB3saG/upsSUSQyEVqPeH00WY7DSVnfUTJm8OzcwvGqLaxcruJk
         tCtLw2aK9uSYD8ALabmheixk6S9TH8vIe6ywM2nPYzAO2yrAY5VuXhmrO9VhTzlJkU
         QwH+fbIhtHp5g==
To:     hdegoede@redhat.com
Cc:     Danct12 <danct12@disroot.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] input: silead: Add MSSL0017 to acpi_device_id.
Date:   Wed, 22 May 2019 11:54:55 +0700
Message-Id: <20190522045455.15769-1-danct12@disroot.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Chuwi Hi10 Plus, the Silead device id is MSSL0017.

Signed-off-by: Danct12 <danct12@disroot.org>
---
 drivers/input/touchscreen/silead.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 09241d4cdebc..06f0eb04a8fd 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -617,6 +617,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
 	{ "MSSL1680", 0 },
 	{ "MSSL0001", 0 },
 	{ "MSSL0002", 0 },
+	{ "MSSL0017", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
-- 
2.21.0

