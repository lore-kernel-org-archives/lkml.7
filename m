Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17728C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB81B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Ay5gYn1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCRPO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:14:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:28756 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfCRPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552922064;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=j7SYXFUSkqgfNHNWK++iiYXdouzoJ8CzH1JtDVotwvE=;
        b=Ay5gYn1Jxh7W3kONb4bJv+kWBJY7QORgYrtQcUnAm95GNhgQDaZQqnWaITrXsvhRfY
        Kq8i5NrKTiN2em5XR2VUbapvOxbDa55JZx2ybm09fDZNAwTUIeBV3ZHYXlp9KDMR4nlc
        nilWGkBQ4rHMfK5fHgolJLU45J0gCWZMaRDv2Oo3ZG+iBQj/5W98jifZiFOqBIq/rxPw
        FQdJPdFnnTDo9E+iB4tHrRcmsS4hd2ken+OZXUWaWn3cx0pWtBrW9kk99KbAfPLroME6
        BmHV8bDSkizb8fjXSCWQ6ef/ozXCNDLiEWghNA3gR1h2692N7FziTL8xJ/Kr/pVRD745
        3P/w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IFEGEji
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 16:14:16 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH 1/2] iio: gyro: bmg160: add device tree compatibility table
Date:   Mon, 18 Mar 2019 16:14:14 +0100
Message-Id: <090c92487ada60e81fca341ef24e5de33a11ec4b.1552922054.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552922054.git.hns@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of_match_table.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/gyro/bmg160_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 90126a5a7663..934a092134f0 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -54,10 +54,19 @@ static const struct i2c_device_id bmg160_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
 
+static const struct of_device_id bmg160_of_match[] = {
+	{ .compatible = "bosch,bmg160" },
+	{ .compatible = "bosch,bmi055_gyro" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, bmg160_of_match);
+
 static struct i2c_driver bmg160_i2c_driver = {
 	.driver = {
 		.name	= "bmg160_i2c",
 		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
+		.of_match_table = bmg160_of_match,
 		.pm	= &bmg160_pm_ops,
 	},
 	.probe		= bmg160_i2c_probe,
-- 
2.19.1

