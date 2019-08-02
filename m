Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB7C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA92120679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738584;
	bh=ypH8/ikrrepBuxnryWfkrCGiNNhMh8PmI7wTcODDPxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fm+0c1CoL5rPQNmC+HUG91w7hroT9BHxsAfqRjSDW1lVlnARujYjOghoOlCpBHLfl
	 8OY4VJniJNgU+tEDczha147c0+vgbLAt1eq4Qg4OqKgVF8UmAunt4OdR+q8sqYEjJ8
	 Vi2KGQILxJ419XeRZtpnHOiH9hFG2FY3gTQVWp5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfHBJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404845AbfHBJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:36:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32142183F;
        Fri,  2 Aug 2019 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738578;
        bh=ypH8/ikrrepBuxnryWfkrCGiNNhMh8PmI7wTcODDPxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4AFbmhNu+xPG3m2Y37ySXVkeuYNoWD8Y16pM7knHQxeFnVyRZTA7mP2/G8S6gmjK
         Wd0FeEb/aVCiLKYQotcCjajl1o3Y3y7wciDXlEquNNe3PITFAGwtaV2znglb3GBwOV
         EiMN71c7MGbLR6dEEGjQ0+aSGD4x22B6OqfWYjn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 144/158] ALSA: line6: Fix wrong altsetting for LINE6_PODHD500_1
Date:   Fri,  2 Aug 2019 11:29:25 +0200
Message-Id: <20190802092231.916878684@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
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
@@ -155,7 +155,7 @@ static const struct line6_properties pod
 		.capabilities	= LINE6_CAP_CONTROL
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
-		.altsetting = 1,
+		.altsetting = 0,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,


