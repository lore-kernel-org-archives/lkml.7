Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40CBC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFB4214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGIRWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:22:20 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:60544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfGIRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:22:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D220D180A68B6;
        Tue,  9 Jul 2019 17:22:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pin68_886ea01b22811
X-Filterd-Recvd-Size: 1239
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 17:22:17 +0000 (UTC)
Message-ID: <d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com>
Subject: [PATCH] ASoC: rt1308: Remove executable attribute from source files
From:   Joe Perches <joe@perches.com>
To:     Derek Fang <derek.fang@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jul 2019 10:22:16 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are source files not executable.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/rt1308.c | 0
 sound/soc/codecs/rt1308.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/rt1308.h b/sound/soc/codecs/rt1308.h
old mode 100755
new mode 100644

