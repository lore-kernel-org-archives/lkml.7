Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B80C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202C12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Xp+OXJ6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfCRUjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:39:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:17153 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfCRUjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552941582;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QPIeEIgDRSxNIo4wn8msfWv7mzRHbhu6YqbA8itgAH0=;
        b=Xp+OXJ6IGQYPN0kX/RfLUGbT6hGw5hX4+rtHKQXFOqeia9A82tPowPzrnUiOrO2A+p
        CNKOFVv78cDmW+yF0Fo2ByOJtSFU6MZIAsB3IZsIG0w7gfiwsXvdW7BF6TsESgpo2oKT
        8ZVzy88mBsoKd4GF+XEaUvXYdupJ6eJpzWBB2Ct88dx+vEHyKj5CuFYPfiqMxN9WLJq2
        ODZBih6JewzYF53FB+RTldOoXyadaRcSqjL5kdgUAybWFTXqiqy+xg/nN7+2Yamz6RP1
        +QOSWVJr4ILvM78XB0BCSIpA3u+OLkxvfAiOP4DrQlixC1PTp1shL8YkSwIJB6GDrD7s
        6vFw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IKdZFyk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 21:39:35 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 2/4] iio: input-bridge: add iio-input-bridge to Makefile
Date:   Mon, 18 Mar 2019 21:39:32 +0100
Message-Id: <dcef8d8f075600432fbe737c0f2faa4e60322e49.1552941573.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552941573.git.hns@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the iio-input-bridge to the Makefile.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb5993251381..d695e5a27da5 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_IIO_INPUT_BRIDGE) += industrialio-inputbridge.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
-- 
2.19.1

