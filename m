Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548B82080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mh/lj1sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfFTJp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:45:56 -0400
Received: from mout.web.de ([212.227.17.12]:53955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfFTJpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561023944;
        bh=FfGf44qHU3BH2AwzhdjXWKQdu8i+SnZZ4/bXILyBf5Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mh/lj1sl1TvZzKv4U32A4ZOw9THZMtJmyCHQNlS4Xb1bnSbAn7aC69HXnvSlYXk1M
         v7KYJ39B56LHD2H8SONjshS/ZYQNjDtwIw3bSYFuyf1fYY3QS3FBTXm8JFm10hpENf
         WWrIfB9mtjg3CPz+kSTs5yAlAk3LSGCPbN1YjUwE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lo0ZA-1iFQFU1AQi-00fxuz; Thu, 20 Jun 2019 11:45:44 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 1/1] drivers/staging/rtl8129u: adjust block comments
Date:   Thu, 20 Jun 2019 11:45:34 +0200
Message-Id: <20190620094534.5658-2-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620094534.5658-1-muellerch-privat@web.de>
References: <20190620094534.5658-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Aun4IcBIEiZXEOeJrPLIWmsjP92Wgc8SynPzkQCeY0uw//XjUf
 7rnarpX8nue/WR/ps9gjRJ6/gynNGqmseiWOGTIFvftMX5qdd6vwlasOcxhGNYMv29Av4A3
 zFS5h01DlhFL8S5FFv+5NbEYLjiL+p4EkGPNIAJzdEKWI2XoSfxdrM4o2Fie+Dr6PKdfGBq
 qqYQAVvmkpAwBtoftxeQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r9IqM3e2VM8=:520iQFl3zMf7H2fDf5Ibte
 mxSM9stKNs+YtUbhAWHUNmOI+kS1bnCDhnFURD0xVeaBieR0LbGITzh1+AFoG0hTmL/VhCXkc
 2r/kf7KpqO7NXGC3bCuQ9ztWw9CJN3EERvrAgu4chIweDyGW21zJbn6Bj6j17MYWdA2mVfc4e
 EuA8V9LMpw7ZtjCHxYvr2ez1WsgDtKtuY5MAvyZvzLmMqobCHLg9zGtoHgyT5ICZX9/kNZg/A
 ay2tw9L6Q4jctAaVijyiYOIZtx+3PRpxVI1BhkFDNI28AyLNwTTnUjOifEMKYFvpdqtI0jDuz
 QWU3ecZPkOYFePEYJPKEA2Lov/yyImoIgL7cYpXq7NXsgzOBD3pe+TAXEX2GD/Oz4EdksJscp
 ykj5DyKO0JlDVKNzOsyEyO1upl/anFUh37K7GWsuUNDCkXZ59bG8xrLCg8ck5YMU8+PtJj0dK
 8bb/VAv4sf/EpKgQwekpsWU5M6owtzaXWdBo2uZRkwZ10/lfsyqgW/gry1mK61kfFlv0lzYpQ
 lARLr1AKlJioMjVsze/5dw6nYLjhHYfu17Xyx7eAWsgbOOR8Ddj2kZem1xnQ/9ki7lQ69MQqf
 ZXbouudMFsecZ5HvTUY4rIRuTZoAyim8qrZiTXwhXTXcwIYw29E2UE+sO26aDqtmg4rkFKSRq
 nvpi1kZH3pwZT9UM/YsYiwh0jetixX3oFS6j2QQ1Zs0yfUAjom81sXAsjB1oinlHs61LiY+RV
 Ak62Oavcy0gVN0dkoFpvOKgUaFluxiepdjS8tf2DDSZDDfWPIrl981FFJaONjsF8IbuLm3K2M
 GtJA7O6q6mQQuhrJvcGJZ3pT+Ar8EghFwZRQIxAEXql/jW4rsQMItn6V4dUbkoKAfJWXqEnQQ
 3jJqYy1aItz50ebzas7ahjz8yiq7mtd5+0l7Ccgz6r3mOhnY1FaXHtIp/u2mUMKYuzK/+9rMn
 beKNSRAufOddM3OFu3bBABNexpIVuy4UQEXNSMJh6zNHXQ1ZioQA1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in coding-styles.rst multiline comments should be structured in =
a way,
that the actual comment starts on the second line of the commented portion=
. E.g:

/*
 * Multiline comments
 * should look like
 * this.
 */

The comments in this file were of a format, that looked like this:

/* Multiline comments previous
 * to this patch
 * looked like this.
 */

There is an exception to files in /net and drivers/net,
where multiline comments are preferred to look like the second example abo=
ve,
but since this file resides in a different directory,
this patch changes the style to match the preferred style.

Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index 5f04afe53d69..a51ed10be431 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -363,7 +363,8 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 	u8		time =3D 0;
 	u32		tmp;

-	/* Firmware RF Write control.
+	/*
+	 * Firmware RF Write control.
 	 * We can not execute the scheme in the initial step.
 	 * Otherwise, RF-R/W will waste much time.
 	 * This is only for site survey.
@@ -379,7 +380,8 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 	/* 6. We can not execute read operation if bit 31 is 1. */
 	read_nic_dword(dev, QPNR, &tmp);
 	while (tmp & 0x80000000) {
-		/* If FW can not finish RF-R/W for more than ?? times.
+		/*
+		 * If FW can not finish RF-R/W for more than ?? times.
 		 * We must reset FW.
 		 */
 		if (time++ < 100) {
@@ -394,7 +396,8 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 	/* 8. Check if firmware send back RF content. */
 	read_nic_dword(dev, QPNR, &tmp);
 	while (tmp & 0x80000000) {
-		/* If FW can not finish RF-R/W for more than ?? times.
+		/*
+		 * If FW can not finish RF-R/W for more than ?? times.
 		 * We must reset FW.
 		 */
 		if (time++ < 100) {
@@ -426,7 +429,8 @@ static void phy_FwRFSerialWrite(struct net_device *dev=
,
 	u8	time =3D 0;
 	u32	tmp;

-	/* Firmware RF Write control.
+	/*
+	 * Firmware RF Write control.
 	 * We can not execute the scheme in the initial step.
 	 * Otherwise, RF-R/W will waste much time.
 	 * This is only for site survey.
@@ -445,7 +449,8 @@ static void phy_FwRFSerialWrite(struct net_device *dev=
,
 	/* 6. Write operation. We can not write if bit 31 is 1. */
 	read_nic_dword(dev, QPNR, &tmp);
 	while (tmp & 0x80000000) {
-		/* If FW can not finish RF-R/W for more than ?? times.
+		/*
+		 * If FW can not finish RF-R/W for more than ?? times.
 		 * We must reset FW.
 		 */
 		if (time++ < 100) {
@@ -455,11 +460,13 @@ static void phy_FwRFSerialWrite(struct net_device *d=
ev,
 			break;
 		}
 	}
-	/* 7. No matter check bit. We always force the write.
+	/*
+	 * 7. No matter check bit. We always force the write.
 	 * Because FW will not accept the command.
 	 */
 	write_nic_dword(dev, QPNR, data);
-	/* According to test, we must delay 20us to wait firmware
+	/*
+	 * According to test, we must delay 20us to wait firmware
 	 * to finish RF write operation.
 	 */
 	/* We support delay in firmware side now. */
@@ -828,7 +835,8 @@ static void rtl8192_BB_Config_ParaFile(struct net_devi=
ce *dev)
 				 reg_u32);
 	}

-	/* Check if the CCK HighPower is turned ON.
+	/*
+	 * Check if the CCK HighPower is turned ON.
 	 * This is used to calculate PWDB.
 	 */
 	priv->bCckHighPower =3D (u8)rtl8192_QueryBBReg(dev,
@@ -847,7 +855,8 @@ static void rtl8192_BB_Config_ParaFile(struct net_devi=
ce *dev)
 void rtl8192_BBConfig(struct net_device *dev)
 {
 	rtl8192_InitBBRFRegDef(dev);
-	/* config BB&RF. As hardCode based initialization has not been well
+	/*
+	 * config BB&RF. As hardCode based initialization has not been well
 	 * implemented, so use file first.
 	 * FIXME: should implement it for hardcode?
 	 */
@@ -1168,7 +1177,8 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 		case RF_8256:
 			switch (pHalData->eRFPowerState) {
 			case eRfOff:
-				/* If Rf off reason is from IPS,
+				/*
+				 * If Rf off reason is from IPS,
 				 * LED should blink with no link
 				 */
 				if (pMgntInfo->RfOffReason =3D=3D RF_CHANGE_BY_IPS)
@@ -1179,7 +1189,8 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 				break;

 			case eRfOn:
-				/* Turn on RF we are still linked, which might
+				/*
+				 * Turn on RF we are still linked, which might
 				 * happen when we quickly turn off and on HW RF.
 				 */
 				if (pMgntInfo->bMediaConnect)
@@ -1274,7 +1285,8 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_de=
vice *dev, u8 channel,
 		 __func__, *stage, *step, channel);
 	if (!is_legal_channel(priv->ieee80211, channel)) {
 		RT_TRACE(COMP_ERR, "set to illegal channel: %d\n", channel);
-		/* return true to tell upper caller function this channel
+		/*
+		 * return true to tell upper caller function this channel
 		 * setting is finished! Or it will in while loop.
 		 */
 		return true;
@@ -1621,7 +1633,8 @@ void rtl8192_SetBWModeWorkItem(struct net_device *de=
v)
 		break;

 	}
-	/* Skip over setting of J-mode in BB register here.
+	/*
+	 * Skip over setting of J-mode in BB register here.
 	 * Default value is "None J mode".
 	 */

=2D-
2.17.1

