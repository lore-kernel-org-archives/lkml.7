Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA5C352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DD421A4C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765465;
	bh=I2kJ2/7FJi+enkweu08eYYQvGFDJ6QywGvJCOXSoA5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v20OVDC1S/JDKol4pacEw0MfBleV9c4DkdfMvVbCneZHFc8H4HoM+9wSlVoZAXd2z
	 gUn1B9wVVr03Gb0U2/qdzxxfYzRZVaByg6WIt9pEyIDP56QjrEwAFeZ2hWXwKDtBvq
	 ks1vhDqIV/cwqkIVZn5p49aw3qlT6wWHZ8HMVXc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfI2N5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfI2N5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:57:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C18218AC;
        Sun, 29 Sep 2019 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765462;
        bh=I2kJ2/7FJi+enkweu08eYYQvGFDJ6QywGvJCOXSoA5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtGvcFUQgCk9uUy9La61+Zi4BQcHZWlzhYqyeYT8UU0lr7TuRj652P6cPVRfmtYbV
         6RUirSNWg53nhN0//tSyleQhFTebo5kdoISYlulw8u6vEG9gaNMBNrIs9ha5NYnPQC
         QestVVl5bdnY121K6HTKb3JT1lsnF35fr3HYgjts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilya Pshonkin <sudokamikaze@protonmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 27/63] ALSA: usb-audio: Add Hiby device family to quirks for native DSD support
Date:   Sun, 29 Sep 2019 15:54:00 +0200
Message-Id: <20190929135037.126284432@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Pshonkin <sudokamikaze@protonmail.com>

commit 029d2c0fd61eac74700fb4ffff36fc63bfff7e5e upstream.

This patch adds quirk VID ID for Hiby portable players family with
native DSD playback support.

Signed-off-by: Ilya Pshonkin <sudokamikaze@protonmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190917074937.157802-1-ilya.pshonkin@netforce.ua
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1449,6 +1449,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 	case 0x2ab6:  /* T+A devices */
+	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;


