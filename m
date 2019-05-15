Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DBFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D052A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfEOMr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:47:59 -0400
Received: from ns.iliad.fr ([212.27.33.1]:33166 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfEOMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:47:59 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 955111FF4E;
        Wed, 15 May 2019 14:47:57 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7D59D1FF2C;
        Wed, 15 May 2019 14:47:57 +0200 (CEST)
To:     arm-soc <arm@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] Opt out of scripts/get_maintainer.pl
Message-ID: <d1427cd2-9111-025c-1a97-d0fa498f1a03@free.fr>
Date:   Wed, 15 May 2019 14:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed May 15 14:47:57 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago, I submitted a trivial arm64 defconfig update.
get_maintainer.pl now outputs my address for every defconfig tweak.
Add me to .get_maintainer.ignore to opt out of these notifications.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 .get_maintainer.ignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index cca6d870f7a5..a64d21913745 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1 +1,2 @@
 Christoph Hellwig <hch@lst.de>
+Marc Gonzalez <marc.w.gonzalez@free.fr>
-- 
2.17.1
