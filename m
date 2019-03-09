Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA80C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6BE2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCIJgX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:36:23 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:65176 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbfCIJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:36:23 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15832626-1500050 
        for multiple; Sat, 09 Mar 2019 09:36:17 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     kjlu@umn.edu
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190309042450.4188-1-kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190309042450.4188-1-kjlu@umn.edu>
Message-ID: <155212417408.28502.15628871831122730555@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] gpu: i915: fix a missing check of get_free_page
Date:   Sat, 09 Mar 2019 09:36:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kangjie Lu (2019-03-09 04:24:50)
> If the allocation fails, return false to avoid potential
> NULL pointer dereference

No. If we fail to allocate c->tmp, we do uncached reads instead.
-Chris
