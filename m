Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5949F2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDITLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:11:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfDITLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:11:52 -0400
Received: from localhost ([2.171.41.193]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MV6G0-1hM4nu3Y86-00S7xH; Tue, 09 Apr 2019 21:11:29 +0200
Date:   Tue, 9 Apr 2019 21:11:28 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        songqiang1304521@gmail.com, robh@kernel.org, m.othacehe@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] Kconfig: change configuration of srf04 ultrasonic iio
 sensor
Message-ID: <20190409191126.lkjujjnvjyxua3fn@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:tQ+PdOMlJh44Sw5kkguM4eGYVVeX0cKfISKrqG3IW5nQW7ntndl
 5InQkROY01TnimtECvpWmMBeargImLBQyBZGjwpi65Bx6Kq6692ozKJpr8zj6CUiPOVQiCF
 yel49EncHLXXFOPvv7K7Li99qKtB86nMamZuI8yeaxxxwBuIS56NpHVrwemY/oDJErYJc1m
 co/T2mMBGZtBQeVkDh86A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wylmMkoAoU=:mvlTplnkKZB98DuZw2GK7k
 YbzLWnw5S7KMD3ZDKOKRKFNQ4GSVR3/OTHl6D3lZNTdQw7qVkWBfuPxwoedbZD3jvLp3SoceA
 47ct3PICLmNodVHyW6SKq9WRToDHr/vz+1+ee819WrQbzUvMEpzLZcRm45mY82fqROUzuwaGb
 7j0CqPLtildl8xmaqM20enAuC5aNJVrQxadlaeEEyavr3+n1PNC1PeEieJsSctAbBoN3+Le4d
 at44BQoHiSYuOTAC44DYTUC3DxYSmItGJVzpz+EidhFQWLAiw9RyaBkXc/aNVvwyQVUTV8eo8
 xxpQklT/5u8yIqbm1Kdcz3Lj/Y9vqz0cNuKP8Ia8hK/0QA5aokn2R22vOi6F6EU/rQNMP9iJy
 +ps8OQltblpjcX03L5yVQRa5EN9Elt7TLRUzbXuLjEP/kcuFW6DJJCXJanp3rNFrC0i5dJyrj
 2AnrsTZSDyx1BJ8lPl3YX9ONXwFZNuN3jra5IKAqVMavknORYp18C4i9iXdMJgCfDk2kkieaW
 bY+XRB5BRQLc6480YQj8wCBkdwlwggfrEfYUSolMBFFP+/UI2FLdBQwet48JUXsB52dIe9/Of
 9NwZ0BQAofPHqFkznEJpf141GC/8okEX/uOuU6O4IoLKmZHvbW6nIs9Mf5bFHG7hVbwszGzXI
 cA3pRJ7vcQdeM8xKtZ7KyhORjIWE+F0t3A9dK9QHiq5qbKFOJ2OTghh5Et+VOiRvTsCvOox0F
 pM1Y9jyN00m9CZ+k3Jq0q/VJ9U7RGzRPyTN/vw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reword configuration option for SRF04

list supported types in help text

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 12a3d3d40a91..e9f254ae3892 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -68,12 +68,19 @@ config RFD77402
 	  module will be called rfd77402.
 
 config SRF04
-	tristate "Devantech SRF04 ultrasonic ranger sensor"
+	tristate "GPIO bitbanged ultrasonic ranger sensor (SRF04, MB1000)"
 	depends on GPIOLIB
 	help
-	  Say Y here to build a driver for Devantech SRF04 ultrasonic
+	  Say Y here to build a driver for GPIO bitbanged ultrasonic
 	  ranger sensor. This driver can be used to measure the distance
 	  of objects. It is using two GPIOs.
+	  Actually Supported types are:
+	  - Devantech SRF04
+	  - Maxbotix mb1000
+	  - Maxbotix mb1010
+	  - Maxbotix mb1020
+	  - Maxbotix mb1030
+	  - Maxbotix mb1040
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf04.
-- 
2.11.0
