Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C730C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339A2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHJUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:54:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbfHJUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:43:48 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDI-00052r-Li; Sat, 10 Aug 2019 21:43:44 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDI-0003Xf-Bc; Sat, 10 Aug 2019 21:43:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        "Leonard Pollak" <leonardp@tr-host.de>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Date:   Sat, 10 Aug 2019 21:40:07 +0100
Message-ID: <lsq.1565469607.393019235@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 003/157] Staging: iio: meter: fixed typo
In-Reply-To: <lsq.1565469607.188083258@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.72-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Pollak <leonardp@tr-host.de>

commit 0a8a29be499cbb67df79370aaf5109085509feb8 upstream.

This patch fixes an obvious typo, which will cause erroneously returning the Peak
Voltage instead of the Peak Current.

Signed-off-by: Leonard Pollak <leonardp@tr-host.de>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/iio/meter/ade7854.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IR
 static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
 		ade7854_read_32bit,
 		ade7854_write_32bit,
-		ADE7854_VPEAK);
+		ADE7854_IPEAK);
 static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
 		ade7854_read_16bit,
 		ade7854_write_16bit,

