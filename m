Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1163C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07BB204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gGqbMZjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfFXJrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:47:21 -0400
Received: from mout.web.de ([217.72.192.78]:44543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfFXJrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561369632;
        bh=v9IXSbIiVGRRWMpAUNdEZIILYsiZ+tvHSdo7MoRM1ac=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gGqbMZjgglQ2rnqmzY11Gklzz5Ngl1jTDCCKrGr6Qsk612av43RQG/gVhX9aCwVFa
         Ro0m2gVmMuqD6pnqGo1ipZN5fCOOAsgczueG7CSDLZu9rYqk/jhwifIQsccqLeh2fD
         iTwvgiSeyVlggFf62V9UEW3hesgDCp3Nu38hH5AM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MTPn1-1i7lwN1sdb-00SQR9; Mon, 24 Jun 2019 11:47:12 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 2/2] drivers/staging/rtl8192u: adjust block comments
Date:   Mon, 24 Jun 2019 11:46:40 +0200
Message-Id: <20190624094640.5459-3-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624094640.5459-1-muellerch-privat@web.de>
References: <20190620113308.GA16195@kroah.com>
 <20190624094640.5459-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e149tY6k836nlGBWHz92KE8e9eBplRZ2XBv1pgTb/uCRLbNtqz/
 I+QYm3t6Oseza5qyWVTMRrpGoNLKjF3qEija3q+ITH6HzpHGnVme5KartN2UTYGvn5JZs8q
 hv2Maihj9iPEAmwGh7pzvZrHY9LjuIZtmzuMPQVzr2FpbFVgLCA6a01ExgJjJON8kFGfSlJ
 mlbauFp0k+nanVk7D0gFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LnGiBRdn9N4=:dI/cVEJgJPSrvdV6ReSJZ2
 fUHw4tnnCSUKZH/z2v0YfpAt+zoCkf1B0Dds6MvqVGyypwzTLQjDXO3s3iVQ9wBuLPIFtSc/r
 3Gc31T7s99Q30OvYapTGlzLnXz2K7YCNHu+epLfzCybtMfOniPzKyal9EafbMInP2jCcoei20
 D65kRaFNDQRQoGgeSwkAaq8jCoKFqjs3YzIsXk4vnijhgQA/u9jcSccy7f9oWNpHBUckfNJ1+
 8iZCdowQ6zYf4N+epGmNTckYC5xboz0cdlGX4iPe4/eTgvHSO+UZRSMX1l6DMvifj+zbUyqe7
 EjwDAY5rSea+DB1Kz8I4F6j//i8Jx1CPSGDFrDTBcn+IcmgeBxmYqfZwXt8N1ttksMeRboJTe
 32nhDqP7Hw7TG5d4Ihmd08efvYZpSodtlYmnYmBTqmvuSbHb1baHDdCoSdiyqfzw/aNsrQHfK
 iPxl3x6NuVKFI3gIo7w765V47zkm0zwgVEscleixhSiP0dteAoE7lXN6c/BarER0G9n6jgzrj
 vww82cqQDXespBDFIU0GatP/hZXKgv7upWIx/g5FHMrlF7aykvZNF0UzfGI0cv2Oq8pJO61y/
 l30t8QxKK8Vj0b5otQAzz9dMEryo0jLNAq1zjNeZChVasvj72DbcpLUyEy1SqKwH+TyP+BxnW
 mNwRi6qKLkYD1rDu6HrmAqW+578sul8LP4uvNFBgP/W4J6JRQraczkIpeaNx+JaviG5woZTw4
 h+bdVTlRFigYlzjk+Yn6XdKcJHlw/4fg0ZlkewTv+QkFK5xflNhhl/gSSvr7yxRpYn+7hR//U
 2SGIxzboPmH0PTXQvnbulH9+New2MDss5Ort7KFP7+uCDVzO+oom2abzQHZbIEtz+NrVG0tyX
 vm85Xkk0wUzFMKKafyA/QegSYVMJG9P0WLy8P48J7y0PiAsTyMTLztbmmHzahjojVst9jswdG
 eK1uqWTW5ycvHfVEgSjhYRW8KU4ifaMkbtARCnXi86X8F2ww74b02
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coding-styles.rst states, that multiline comments should
allways contain a leading "*" in each line.
For multiline comments in general they

/*
 * should look
 * like this.
 */

For multiline comments in either net/ or drivers/net/ however,
they should

/* omit
 * the first
 * empty line.
 */

Since this file is part of a networking driver, the goal for it would
be to reside in drivers/net/ one day.

This patch changes comments, that were in neither form of the two listed
above, to have the style that is specified for drivers/net/.

Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
=2D--
 drivers/staging/rtl8192u/r8192U_dm.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index 86215fee8f0b..cb6c653e624d 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -332,9 +332,10 @@ static void dm_check_rate_adaptive(struct net_device =
*dev)
 				((bshort_gi_enabled) ? BIT(31) : 0);

 		/* 2007/10/08 MH We support RA smooth scheme now. When it is the first
-		   time to link with AP. We will not change upper/lower threshold. If
-		   STA stay in high or low level, we must change two different threshol=
d
-		   to prevent jumping frequently. */
+		 * time to link with AP. We will not change upper/lower threshold. If
+		 * STA stay in high or low level, we must change two different threshol=
d
+		 * to prevent jumping frequently.
+		 */
 		if (pra->ratr_state =3D=3D DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA	=3D pra->high2low_rssi_thresh_for_ra;
 			LowRSSIThreshForRA	=3D (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_2=
0) ?
@@ -1738,10 +1739,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_ala=
rm(
 	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
 	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
 	/* 1. When RSSI decrease, We have to judge if it is smaller than a thres=
hold
-		  and then execute the step below. */
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb <=3D dm_digtable.rssi_low_thresh) {
 		/* 2008/02/05 MH When we execute silent reset, the DIG PHY parameters
-		   will be reset to init value. We must prevent the condition. */
+		 * will be reset to init value. We must prevent the condition.
+		 */
 		if (dm_digtable.dig_state =3D=3D DM_STA_DIG_OFF &&
 		    (priv->reset_count =3D=3D reset_cnt)) {
 			return;
@@ -1786,7 +1789,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
 	}

 	/* 2. When RSSI increase, We have to judge if it is larger than a thresh=
old
-		  and then execute the step below.  */
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb >=3D dm_digtable.rssi_high_thresh) {
 		u8 reset_flag =3D 0;

@@ -2252,11 +2256,10 @@ static void dm_ctstoself(struct net_device *dev)
 		pHTInfo->IOTAction &=3D ~HT_IOT_ACT_FORCED_CTS2SELF;
 		return;
 	}
-	/*
-	1. Uplink
-	2. Linksys350/Linksys300N
-	3. <50 disable, >55 enable
-	*/
+	/* 1. Uplink
+	 * 2. Linksys350/Linksys300N
+	 * 3. <50 disable, >55 enable
+	 */

 	if (pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt =3D priv->stats.txbytesunicast - lastTxOkCnt;
@@ -2333,7 +2336,8 @@ void dm_rf_pathcheck_workitemcallback(struct work_st=
ruct *work)
 	u8 rfpath =3D 0, i;

 	/* 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register w=
ill
-	   always be the same. We only read 0xc04 now. */
+	 * always be the same. We only read 0xc04 now.
+	 */
 	read_nic_byte(dev, 0xc04, &rfpath);

 	/* Check Bit 0-3, it means if RF A-D is enabled. */
=2D-
2.17.1

