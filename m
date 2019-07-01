Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BAEC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6682208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CduDnLqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfGAI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:27:23 -0400
Received: from mout.web.de ([212.227.17.12]:45579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfGAI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561969632;
        bh=4q9oOR9/AU3ColCAYnMEwzYonJG6eD0UBJFIpk/CK8U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CduDnLqLef25mIv3LpMUeZNzAflUYCVVtY4RMk/bpuI1lGWlGzawsJkMspf4qVk0e
         jix8mDRcw5Q8ZtpOaeH4sGSn0AyewWhoDHKze2Gl9+WbgAyhlYHn1tQdOMhclFaXGh
         MaaJ7q2aIe2CJXjSzTKtnjxlFWbsWoj3d1V9IkkM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LkPrz-1iF0Lj0JgJ-00cTbI; Mon, 01 Jul 2019 10:27:12 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>,
        Felix Trommer <felix.trommer@hotmail.de>
Subject: [PATCH v3 1/2] drivers/staging/rtl8192u: drop first comment line
Date:   Mon,  1 Jul 2019 10:27:06 +0200
Message-Id: <20190701082707.25198-1-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627164530.GD9692@kroah.com>
References: <20190627164530.GD9692@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:etkuBxERo980H2Z+EI+uJWSdDxT1xyx4Hdy6d0T9HJN3AKe1ChZ
 T7q+MPB2UUOIICJntX9DZaTLh0zMpLbpF7At7RzKpwqESdy6nszcLfFpa5Rq+8PfATpQIXl
 yZp3CObI9QoM4EbhxsBaHuQGBkHUiJVTuvggH3iU/NaBT38PETOeWZKTVy+PdCmy3RvrcFp
 gKqrIQbqXa0ns8AMQeu3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SOGw7XiKFPY=:fKVbL/hFwqWXeRSqnIAe7d
 ede2ENUXJaOWmScojAow8Z4tTvFYdGkxPXGPSVqsysEKF2VjMsL5+sr26jvdfmDliRbQtU2k7
 IgSIkQXWyp2sZK8y1tJ7QG+L9MGcNLlwg2X5Wh+/EdFHfHke9w1wdq0kcakdVSNNsod6URh1R
 BeplDoweZykGpbtjemN4SDfMXh5l2tiOxLShHx5bfexNPWqIACIVfwxS+TkPL3x6q4nimy4nL
 GCp9Pa2Df+mTiQu5v8fSUnUNs7a2DOTFIG95ovvfkkbdUmXm+pw6eMCrhg8DWhXsiljB0RBfJ
 nTXiWh+sp7EGlbjpDh5/LcJXZvcWJ7w8IklzcMwBqGpsarPEJgLd62X4UOesORcnyHV9VwN5Y
 K9Ea6rxsP/U6Cvflg+h9R3KsfHxKy55KqtRpJVNgDS7Lt4LYBJ+o9f2FnHq7r/GDLpenk86d5
 jc/t+PDV6wVVypffExRgsW/+Yqbzxq8XZvrVOvSeOzxbo8kAOzTCl/2VUXHYgG7v4sGK3gvUw
 5XjDQCEiGlIQ8tQGnGnJtLM3R0Leq/y1loRlwaqjZh/8+gdYSjFJyFMOk3etkpPK4I5mkFWXo
 PPNzrtlgxwhvu+n2tWQHyaJsUUFBBsU+HnyUbfsdbePjFBiANbQgUu7NC73NDZ6/LgqjGYNVs
 1qaZqEGEwd2QX9j3DlNH9XI/+n6hoNNedAEE/GABjExZZO3xzNoozMRHDunHD4ojGcRD7HhR4
 aiJzyjHahnBDQavPkfPxHZtMaILOzqT3zFZpgVD+CBen0XdC+Wsw/U+DEw9TCaLqL8xIxHK7w
 XOYfcOX2qti//AMhecInZX8DOOo3TpCE8SZssuRcCHqLiMPkPNm7DvNharLfBeBdNOseHge6V
 OKl1ZSGdZE54UDbdTuo4jEmszNTwy50AhTVrqx8ZwEtw8Zlr5w8H3R8I+SZYIkqw4AfogLiHH
 Kl1iiktAY04q1wuG3uGio4NTqsyAWHB6PiYqaky4vCm4ohhzv8mbFJWPw07TDAngTlMGnsg/c
 vIOL0EJowm7TFmxJuhzHra+ydMtKByxyydunpKYC+N2IzIrawOSVu5/teHKbgZVCfuy8Ogyzq
 vSOAn3J1Q6UPktFwDnv8b7sgxjRwOT/3Poq
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

However, there is an exception to files in drivers/net/ and net/, where
multiline comments are prefered to look like this:

/* Mutliline comments for
 * drivers/net/ should look
 * like this.
 */

The comments in this file initially looked like the first example.
But since this file is part of a networking driver and thus should
be moved to drivers/net/ one day, this patch adjusts the comments
such that they are fitting to the style imposed for drivers/net/.

Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
=2D--
 v1 contains the initial patch.

 v2 contains the same patch, but with a different subject to better distin=
guish
    this patch from the other one in this patch series.

 v3 contains the same patch again, but this time with this changelog appen=
ded.

 drivers/staging/rtl8192u/r8192U_dm.c | 69 ++++++++++------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index 2ba01041406b..86215fee8f0b 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -99,8 +99,7 @@ static	void	dm_dynamic_txpower(struct net_device *dev);
 static	void dm_send_rssi_tofw(struct net_device *dev);
 static	void	dm_ctstoself(struct net_device *dev);
 /*---------------------------Define function prototype-------------------=
-----*/
-/*
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  *	HW Dynamic mechanism interface.
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  *
@@ -178,8 +177,7 @@ void dm_CheckRxAggregation(struct net_device *dev)

 			ulValue =3D (pHTInfo->UsbRxFwAggrEn<<24) | (pHTInfo->UsbRxFwAggrPageNu=
m<<16) |
 				(pHTInfo->UsbRxFwAggrPacketNum<<8) | (pHTInfo->UsbRxFwAggrTimeout);
-			/*
-			 * If usb rx firmware aggregation is enabled,
+			/* If usb rx firmware aggregation is enabled,
 			 * when anyone of three threshold conditions above is reached,
 			 * firmware will send aggregated packet to driver.
 			 */
@@ -219,8 +217,7 @@ void hal_dm_watchdog(struct net_device *dev)
 #endif
 }	/* HalDmWatchDog */

-/*
- * Decide Rate Adaptive Set according to distance (signal strength)
+/* Decide Rate Adaptive Set according to distance (signal strength)
  *	01/11/2008	MHC		Modify input arguments and RATR table level.
  *	01/16/2008	MHC		RF_Type is assigned in ReadAdapterInfo(). We must call
  *						the function after making sure RF_Type.
@@ -246,8 +243,7 @@ void init_rate_adaptive(struct net_device *dev)
 	pra->ping_rssi_thresh_for_ra =3D 15;

 	if (priv->rf_type =3D=3D RF_2T4R) {
-		/*
-		 * 07/10/08 MH Modify for RA smooth scheme.
+		/* 07/10/08 MH Modify for RA smooth scheme.
 		 * 2008/01/11 MH Modify 2T RATR table for different RSSI. 080515 portin=
g by amy from windows code.
 		 */
 		pra->upper_rssi_threshold_ratr		=3D	0x8f0f0000;
@@ -387,8 +383,7 @@ static void dm_check_rate_adaptive(struct net_device *=
dev)
 			}
 		}

-		/*
-		 * 2008.04.01
+		/* 2008.04.01
 		 * For RTL819X, if pairwisekey =3D wep/tkip, we support only MCS0~7.
 		 */
 		if (priv->ieee80211->GetHalfNmodeSupportByAPsHandler(dev))
@@ -683,8 +678,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(st=
ruct net_device *dev)
 		return;
 	}

-	/*
-	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+	/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 	 * this is only for test, should be masked
 	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 	 */
@@ -850,8 +844,7 @@ static void dm_InitializeTXPowerTracking_TSSI(struct n=
et_device *dev)
 	priv->txbbgain_table[36].txbb_iq_amplifygain =3D		     -24;
 	priv->txbbgain_table[36].txbbgain_value =3D 0x10000040;

-	/*
-	 * ccktxbb_valuearray[0] is 0xA22 [1] is 0xA24 ...[7] is 0xA29
+	/* ccktxbb_valuearray[0] is 0xA22 [1] is 0xA24 ...[7] is 0xA29
 	 * This Table is for CH1~CH13
 	 */
 	priv->cck_txbbgain_table[0].ccktxbb_valuearray[0] =3D 0x36;
@@ -1061,8 +1054,7 @@ static void dm_InitializeTXPowerTracking_TSSI(struct=
 net_device *dev)
 	priv->cck_txbbgain_table[22].ccktxbb_valuearray[6] =3D 0x03;
 	priv->cck_txbbgain_table[22].ccktxbb_valuearray[7] =3D 0x01;

-	/*
-	 * ccktxbb_valuearray[0] is 0xA22 [1] is 0xA24 ...[7] is 0xA29
+	/* ccktxbb_valuearray[0] is 0xA22 [1] is 0xA24 ...[7] is 0xA29
 	 * This Table is for CH14
 	 */
 	priv->cck_txbbgain_ch14_table[0].ccktxbb_valuearray[0] =3D 0x36;
@@ -1282,8 +1274,7 @@ static void dm_InitializeTXPowerTracking_ThermalMete=
r(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);

-	/*
-	 * Tx Power tracking by Thermal Meter requires Firmware R/W 3-wire. This=
 mechanism
+	/* Tx Power tracking by Thermal Meter requires Firmware R/W 3-wire. This=
 mechanism
 	 * can be enabled only when Firmware R/W 3-wire is enabled. Otherwise, f=
requent r/w
 	 * 3-wire by driver causes RF to go into a wrong state.
 	 */
@@ -1330,8 +1321,7 @@ static void dm_CheckTXPowerTracking_ThermalMeter(str=
uct net_device *dev)
 	}

 	if (!TM_Trigger) {
-		/*
-		 * Attention!! You have to write all 12bits of data to RF, or it may ca=
use RF to crash
+		/* Attention!! You have to write all 12bits of data to RF, or it may ca=
use RF to crash
 		 * actually write reg0x02 bit1=3D0, then bit1=3D1.
 		 * DbgPrint("Trigger ThermalMeter, write RF reg0x2 =3D 0x4d to 0x4f\n")=
;
 		 */
@@ -1773,8 +1763,7 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(

 		/*  1.3 Lower PD_TH for OFDM. */
 		if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
-			/*
-			 * 2008/01/11 MH 40MHZ 90/92 register are not the same.
+			/* 2008/01/11 MH 40MHZ 90/92 register are not the same.
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
@@ -1814,8 +1803,7 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
 		dm_digtable.dig_state =3D DM_STA_DIG_ON;
 		/*DbgPrint("DIG ON\n\r");*/

-		/*
-		 * 2.1 Set initial gain.
+		/* 2.1 Set initial gain.
 		 * 2008/02/26 MH SD3-Jerry suggest to prevent dirty environment.
 		 */
 		if (reset_flag =3D=3D 1) {
@@ -1832,8 +1820,7 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(

 		/* 2.2 Higher PD_TH for OFDM. */
 		if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
-			/*
-			 * 2008/01/11 MH 40MHZ 90/92 register are not the same.
+			/* 2008/01/11 MH 40MHZ 90/92 register are not the same.
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
@@ -1850,8 +1837,7 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
 		/* 2.3 Higher CS ratio for CCK. */
 		write_nic_byte(dev, 0xa0a, 0xcd);

-		/*
-		 * 2.4 Lower EDCCA.
+		/* 2.4 Lower EDCCA.
 		 * 2008/01/11 MH 90/92 series are the same.
 		 */
 		/*PlatformEFIOWrite4Byte(pAdapter, rOFDM0_ECCAThreshold, 0x346);*/
@@ -1892,8 +1878,7 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		(priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_power_highthre=
sh))
 		return;

-	/*
-	 * 3. When RSSI >75% or <70%, it is a high power issue. We have to judge=
 if
+	/* 3. When RSSI >75% or <70%, it is a high power issue. We have to judge=
 if
 	 *    it is larger than a threshold and then execute the step below.
 	 *
 	 * 2008/02/05 MH SD3-Jerry Modify PD_TH for high power issue.
@@ -2042,8 +2027,7 @@ static void dm_pd_th(
 			if (dm_digtable.curpd_thstate =3D=3D DIG_PD_AT_LOW_POWER) {
 				/*  Lower PD_TH for OFDM. */
 				if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
-					/*
-					 * 2008/01/11 MH 40MHZ 90/92 register are not the same.
+					/* 2008/01/11 MH 40MHZ 90/92 register are not the same.
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
@@ -2055,8 +2039,7 @@ static void dm_pd_th(
 			} else if (dm_digtable.curpd_thstate =3D=3D DIG_PD_AT_NORMAL_POWER) {
 				/* Higher PD_TH for OFDM. */
 				if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
-					/*
-					 * 2008/01/11 MH 40MHZ 90/92 register are not the same.
+					/* 2008/01/11 MH 40MHZ 90/92 register are not the same.
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
@@ -2155,8 +2138,7 @@ static void dm_check_edca_turbo(
 	unsigned long				curTxOkCnt =3D 0;
 	unsigned long				curRxOkCnt =3D 0;

-	/*
-	 * Do not be Turbo if it's under WiFi config and Qos Enabled, because th=
e EDCA parameters
+	/* Do not be Turbo if it's under WiFi config and Qos Enabled, because th=
e EDCA parameters
 	 * should follow the settings from QAP. By Bruce, 2007-12-07.
 	 */
 	if (priv->ieee80211->state !=3D IEEE80211_LINKED)
@@ -2188,8 +2170,7 @@ static void dm_check_edca_turbo(

 		priv->bcurrent_turbo_EDCA =3D true;
 	} else {
-		/*
-		 * Turn Off EDCA turbo here.
+		/* Turn Off EDCA turbo here.
 		 * Restore original EDCA according to the declaration of AP.
 		 */
 		if (priv->bcurrent_turbo_EDCA) {
@@ -2219,8 +2200,7 @@ static void dm_check_edca_turbo(
 			write_nic_dword(dev, EDCAPARA_BE, u4bAcParam);


-			/*
-			 * Check ACM bit.
+			/* Check ACM bit.
 			 * If it is set, immediately set ACM control bit to downgrading AC for=
 passing WMM testplan. Annie, 2005-12-13.
 			 */
 			{
@@ -2319,8 +2299,7 @@ static	void	dm_check_pbc_gpio(struct net_device *dev=
)
 		return;

 	if (tmp1byte & BIT(6) || tmp1byte & BIT(0)) {
-		/*
-		 * Here we only set bPbcPressed to TRUE
+		/* Here we only set bPbcPressed to TRUE
 		 * After trigger PBC, the variable will be set to FALSE
 		 */
 		RT_TRACE(COMP_IO, "CheckPbcGPIO - PBC is pressed\n");
@@ -2529,8 +2508,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *=
dev)
 		}
 	}

-	/*
-	 * Set CCK Rx path
+	/* Set CCK Rx path
 	 * reg0xA07[3:2]=3Dcck default rx path, reg0xa07[1:0]=3Dcck optional rx =
path.
 	 */
 	update_cck_rx_path =3D 0;
@@ -3049,8 +3027,7 @@ static void dm_send_rssi_tofw(struct net_device *dev=
)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);

-	/*
-	 * If we test chariot, we should stop the TX command ?
+	/* If we test chariot, we should stop the TX command ?
 	 * Because 92E will always silent reset when we send tx command. We use =
register
 	 * 0x1e0(byte) to notify driver.
 	 */
=2D-
2.17.1

