Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1530C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2B52082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SXzO8Msv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0Idw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:33:52 -0400
Received: from mout.web.de ([217.72.192.78]:32979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0Idw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561624422;
        bh=v9IXSbIiVGRRWMpAUNdEZIILYsiZ+tvHSdo7MoRM1ac=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SXzO8Msv7iMJqbR3UIP+dVyQxI/DfWx8BwFgrOjMeB3S1+GxYtr3uEGxIfRayv8bT
         HTTAEzOU0lMQDd7CFiEp3bfu4swkawNQ8fem5772oJftn9LWYMCaXi5vqTRbw3E9i6
         TBF13rbkeWgv/zXpEIy2dLB/iaKlyaP9DbQrmXTg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LecRm-1iLjbs35W2-00qRZW; Thu, 27 Jun 2019 10:33:42 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>,
        Felix Trommer <felix.trommer@hotmail.de>
Subject: [PATCH v2 2/2] drivers/staging/rtl8192u: style nonstyled comments
Date:   Thu, 27 Jun 2019 10:33:36 +0200
Message-Id: <20190627083336.3897-2-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627083336.3897-1-muellerch-privat@web.de>
References: <20190626015301.GA30966@kroah.com>
 <20190627083336.3897-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fq22YNdqP3Q/Mz6bF5i7fBPgfCqJYEbrYnWYesndMAUDMAbkbwJ
 nitnIvPaqJDNlEszNy4+hYbZQEmZj6FIMTmdNbFk8JrGiRvbTFYiwV1eQZaWxLWIjHCC+gG
 cW89R/sZzSewcKKGGLkSZiNgFa2OkiqBiykvbZ6999+2oncjkj5u7pzONwikti9d5QRKgQ2
 Z3WLOEvN0fwk+8b40F5Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GPMiKzP/3SQ=:nxn9jRTtfAyUWs28IJa9+S
 oxntDf7JW7ZmO59PT3G4wgJxmqAZU85ECDeDGfcZk0mKrl08UgxDYFBkudHoOk8Q9I7V1wHBq
 7BKJO5qM8Z+NSXocdi3xvzNO9qf7cD2P76siefYR2YJ2gkY4BuYIh1bDTTKBRUAsb0C8QEzFv
 24jcGJQpXTn3l98gXNcMWMQFVEKK5zoHmN+DOI/yt8IIQKHl6DfcaQa8qjrvhFzrC3cYbqSSA
 AlyhGvH/A5E5c6KEdVJ+Nmj2QkTa8XTSldfI6AUZdlXZF+sY/amgvGgDQnULsPYWv7LhGgZV2
 GjQ4QcZhUz4AEw8ItX+ZuTO2IFCpWs/Q1wSlcL52lBuihpWKncLSF/iGnKyVVwYvRpRqaUZcc
 LQYC9Ugj3viCAlE3fuKOGKQY3nV90k/rLMrgGASyADnC4AcM9I/yZn55sT9d81X2IU4u1lTt5
 TvOOfkP93DvJAYHwfIndkhn1WnAZEQKnd9blPB9Xg8ZmfhzFE891bhMpDgZoz2usVPErnxas0
 eDSsrGTShSU7LzIvepAfuoIOvdDAg8wh6uU0VMmNXvDwlr6DO5mBaKCrKbTl9qDZA9km5JovH
 PlUJ2saTh7Ajj7GZeLlllDfXSUlmY/r+RbjMjMJPKC1RnVzRzi67u++qY62zfDj3Zhss6eAp3
 B5FUDZmLFrc8Lw1BqJiGWDH7JaWpGsdAjSWLvT1e7ZLlYxicwnRtIhGYcpzUlI8/GaLkAmw26
 1hSpXL1rbLj99brOMtw5dw5USnF02L8H/V+KshUgnwRRk9KZhp2mP4T1KoKeaPQMRFG+Mmtb7
 WV+F99pCzvYYrETRstxwTVKgjW8uE5ausAahtbOlsxig3o8zYkgPBjlj4ASa4U6zmlZEBj06I
 S8XhM6Op9FRHl+zb0hms8BTQfDo0UUvzTTDZSPx6gStSd/VSjEuXnreUTPN6cl0ZtbLZkm/TO
 BWOPT4sKpLVkBsYMqGXJE3XKGE7UuKwtHFVzcScm6iS3YUb63PYdP
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

