Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03130C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC12720836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLJOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:14:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:32868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfLJOOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9F8BAEDC;
        Tue, 10 Dec 2019 14:14:04 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH for-5.6 0/4] staging: ALSA PCM API updates
Date:   Tue, 10 Dec 2019 15:13:52 +0100
Message-Id: <20191210141356.18074-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a patch set to adapt the latest ALSA PCM API to staging
drivers.  Basically these are merely cleanups, as shown in diffstat,
and there should be no functional changes.

As the corresponding ALSA PCM API change is found in 5.5-rc1, please
apply these on 5.5-rc1 or later.  Or if you prefer, I can merge them
through sound tree, too.  Let me know.


thanks,

Takashi

===

Takashi Iwai (4):
  staging: most: Use managed buffer allocation
  staging: bcm2835-audio: Use managed buffer allocation
  staging: most: Drop superfluous ioctl PCM ops
  staging: bcm2835-audio: Drop superfluous ioctl PCM ops

 drivers/staging/most/sound/sound.c                 | 45 +---------------------
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 19 +--------
 2 files changed, 2 insertions(+), 62 deletions(-)

-- 
2.16.4

