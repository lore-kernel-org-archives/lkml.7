Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146B2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6QCS63+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBR1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:27:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35481 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:27:09 -0400
Received: by mail-io1-f66.google.com with SMTP id r18so2907767ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSV3za5h6TmBn30fKr9DcVJtEpE2QIEo0gVfRz6Uuuk=;
        b=H6QCS63+H4ulewvjtJZ8/K4jbaKx4q0voM+BcLBzjr+tM1MNXqKjejQCw/TgvsayL+
         fz3wYlr9IPyR46iOl1vMq+xkHfmkAfDCkymf8Xv9D1HFZPku1N0NreMIkZ6Z4i1HIGdm
         7t1HvtCNornGg5c30FvEx4lWyjl9MSwTFsybo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSV3za5h6TmBn30fKr9DcVJtEpE2QIEo0gVfRz6Uuuk=;
        b=JTOxs2o+QffnX8VUS2dcM2zj9R6pWzJb6nL02YLYLsnpQmcteUGaus2+EWBwZKrm4m
         dhLjK0dKqJ4VI4GZKaxuClhLWw4rDfRQHKVfiiiyFchhHeOMVWw/zg4240otiY5XLMll
         yEEOztXahKhJy0XTcvGOYq4m5iG8UX/KyeM3+rAXkx2IIzyfPHy5vEn928LjeWMDvQ55
         nzT4O2quQrSaCWQ2fdB73k/6+T8hMuu9IiGqmevoduEnJhRv17qAFV7vXU6Hv2paZc+E
         MG6JDxmjPWWpcWlYqZCWrwl0vomQJif2liqIp//IoBLJ2VF1M/mQddP5xV4YGqelGUHd
         QIOw==
X-Gm-Message-State: APjAAAXmvPP2/M5CavTz5Bn/ydQWgxnYKytddkg9sRZ6uyofl0AmyK6E
        DtPFYSH+sQQx/57Oc2X7gACVQCtC9nw=
X-Google-Smtp-Source: APXvYqxf9/LTf8Om4JbEc+c1oOqa3tbBbDX8hfcc/WF7j7McISDSQTro/vzmlVOXO8ATigMRH0U3Og==
X-Received: by 2002:a6b:3b11:: with SMTP id i17mr3543172ioa.105.1556818027933;
        Thu, 02 May 2019 10:27:07 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id 125sm5019437itx.21.2019.05.02.10.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 10:27:07 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Clemens Ladisch <clemens@ladisch.de>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] MAINTAINERS: update git tree for sound entries
Date:   Thu,  2 May 2019 11:27:00 -0600
Message-Id: <20190502172700.215737-1-zwisler@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several sound related entries in MAINTAINERS refer to the old git tree
at "git://git.alsa-project.org/alsa-kernel.git".  This is no longer used
for development, and Takashi Iwai's kernel.org tree is used instead.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 MAINTAINERS | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b5480..d373d976a9317 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3351,7 +3351,7 @@ F:	include/uapi/linux/bsg.h
 BT87X AUDIO DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	Documentation/sound/cards/bt87x.rst
 F:	sound/pci/bt87x.c
@@ -3404,7 +3404,7 @@ F:	drivers/scsi/FlashPoint.*
 C-MEDIA CMI8788 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/pci/oxygen/
 
@@ -5696,7 +5696,7 @@ F:	drivers/edac/qcom_edac.c
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/usb/misc/ua101.c
 
@@ -6036,7 +6036,7 @@ F:	include/linux/f75375s.h
 FIREWIRE AUDIO DRIVERS
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/firewire/
 
@@ -11593,7 +11593,7 @@ F:	Documentation/devicetree/bindings/opp/
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/drivers/opl4/
 
@@ -14490,7 +14490,6 @@ M:	Takashi Iwai <tiwai@suse.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://www.alsa-project.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
-T:	git git://git.alsa-project.org/alsa-kernel.git
 Q:	http://patchwork.kernel.org/project/alsa-devel/list/
 S:	Maintained
 F:	Documentation/sound/
@@ -16100,7 +16099,7 @@ F:	drivers/usb/storage/
 USB MIDI DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-T:	git git://git.alsa-project.org/alsa-kernel.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/usb/midi.*
 
-- 
2.21.0.593.g511ec345e18-goog

