Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB85C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DE2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfHSNJr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:09:47 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57065 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727563AbfHSNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:09:45 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18189198-1500050 
        for multiple; Mon, 19 Aug 2019 14:09:37 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Masanari Iida <standby24x7@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190819130552.28354-1-standby24x7@gmail.com>
Cc:     Masanari Iida <standby24x7@gmail.com>
References: <20190819130552.28354-1-standby24x7@gmail.com>
Message-ID: <156622017506.1374.14327133187971388720@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm: selftests: Fix a typo in test-drm_mm.c
Date:   Mon, 19 Aug 2019 14:09:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masanari Iida (2019-08-19 14:05:52)
> This patch fix a spelling typo in test-drm_mm.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
