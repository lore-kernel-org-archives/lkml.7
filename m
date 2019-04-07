Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28888C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F3420863
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYuWRTEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDGTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:12:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W+mC+jPN9621HgxKxIvMdEkKqSSf7mvZuxBHxa25kNc=; b=nYuWRTEvcSIoqh3hMwWQRISpe
        D+TQFn4zJoSCeDmSyvHvpOzkwfY/F1UWvN7VwTMaxYcqKissmqVCvcS6fZ6FsRCOgVAWSWJSp9ghu
        CRRxPASBu2ljgJJ4HyyxN/EUAgMojqMfSJv2BeUg4gns6mznMynIF372L1qLSMEKC/Fo7HoXXfK6O
        pHuEIJKTkbLCLKadX6PAuFTzEQMFxj0m6y/QuWi1CV1R+JMqz/oHqXNGOf463tEOX/I/RAhdulbCb
        J+MlVXGLq/aZ6QorMwavamrWf4BwklGjkRt/9SFsfcmCdfWshBSj80tI6YdRz5jcvQ97vw4oJur08
        TV6QwmEHw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDDD9-00036s-F3; Sun, 07 Apr 2019 19:12:11 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Qiang Yu <yuq825@gmail.com>, lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
Message-ID: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
Date:   Sun, 7 Apr 2019 12:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Note that the lima mailing list is moderated.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qiang Yu <yuq825@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: lima@lists.freedesktop.org
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm-2019-0405-1828.orig/MAINTAINERS
+++ mmotm-2019-0405-1828/MAINTAINERS
@@ -5226,7 +5226,7 @@ F:	Documentation/devicetree/bindings/dis
 DRM DRIVERS FOR LIMA
 M:	Qiang Yu <yuq825@gmail.com>
 L:	dri-devel@lists.freedesktop.org
-L:	lima@lists.freedesktop.org
+L:	lima@lists.freedesktop.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h


