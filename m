Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08889C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D54205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430688;
	bh=oRCeYSMmp0m1iqf4ohdkAmpqrThC+viBHh35Dr23+2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RmjDxt6wW7lo2giR2eUUsHZsRTG15tINKy2AWr4U2unZEwagauJ1yWb1Nejz3r89k
	 hUYhCAp6EgmDmog9qybbhG9+npYKHuSPEX2bvNl+BG/xzvJu8opvJ6xbkIwyKjoL9W
	 EpyVPv8HTIyaOqBk7U+Id3Hf18eGqkEGj3bwLqTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbfG2Top (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389803AbfG2Toe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:44:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1E4321655;
        Mon, 29 Jul 2019 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429473;
        bh=oRCeYSMmp0m1iqf4ohdkAmpqrThC+viBHh35Dr23+2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQZjP0VT5RQLrILeEAYCbFQ4J2n/sGmXzxM6oxDIiFRkwiKsga7Y8mJoqdga2SXe9
         +twYvSp/kfkU03dCfHoGjH2JCxP0uKeVw+v4a6BUwS3psPggjvQ8RxijPetasNr++6
         BGcCGr3qk4FXhbFVXElYxWy/o50XAGgVoepjHnWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 108/113] ALSA: line6: Fix wrong altsetting for LINE6_PODHD500_1
Date:   Mon, 29 Jul 2019 21:23:15 +0200
Message-Id: <20190729190720.956388036@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 70256b42caaf3e13c2932c2be7903a73fbe8bb8b upstream.

Commit 7b9584fa1c0b ("staging: line6: Move altsetting to properties")
set a wrong altsetting for LINE6_PODHD500_1 during refactoring.

Set the correct altsetting number to fix the issue.

BugLink: https://bugs.launchpad.net/bugs/1790595
Fixes: 7b9584fa1c0b ("staging: line6: Move altsetting to properties")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/podhd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -417,7 +417,7 @@ static const struct line6_properties pod
 		.name = "POD HD500",
 		.capabilities	= LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
-		.altsetting = 1,
+		.altsetting = 0,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,


