Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F352420700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JeFmbIAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfJVWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:20:03 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55882 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfJVWUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:20:03 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 07525806A8;
        Wed, 23 Oct 2019 11:20:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571782802;
        bh=LtvxEKkSPHNyKRPgRkt0mLmoWuIQEMyTQMTbpJmYd90=;
        h=From:To:Cc:Subject:Date;
        b=JeFmbIAlCo9DhZjJ1FxwXIAL7L/7mQe2qKyW7ybOI51joj1Pmh57AuxCaFCFViCMQ
         a4ZuNy+bFVzXvi42zpzrL0FTE9hx5tDHNWoJzfQcyYVAvIQi05h4Ws7D8k2pwHYE1G
         ctXud6XnoELJLn1W14Ibis9/kttSzOBekfaMKKnDc7ja22R45ZMHvNXhi7eVUgKvcA
         3lxBpwJ7HYWJupmkT0hVxoBDLomIJ7K+ZT6K5IcEmndwiJlcpZyLZ1k1V13DU7v7km
         R67TZ3r7cPK/SQI71jO6agO4A5F/LtwGAMNsbIt4qCE83MXTh5BAKbqHRoQeA8VT/s
         S08MyFszQZBUQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5daf80900000>; Wed, 23 Oct 2019 11:20:02 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id EAF1713EED4;
        Wed, 23 Oct 2019 11:20:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BF38C280059; Wed, 23 Oct 2019 11:19:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH] ARM: dts: bcm: HR2: add label to sp805 watchdog
Date:   Wed, 23 Oct 2019 11:19:56 +1300
Message-Id: <20191022221956.10746-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows boards the option of adding properties or disabling the
watchdog entirely.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.d=
tsi
index e4d49731287f..6142c672811e 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -268,7 +268,7 @@
 			clock-frequency =3D <100000>;
 		};
=20
-		watchdog@39000 {
+		watchdog: watchdog@39000 {
 			compatible =3D "arm,sp805", "arm,primecell";
 			reg =3D <0x39000 0x1000>;
 			interrupts =3D <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
--=20
2.23.0

