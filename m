Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7524C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfGWL3C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:02 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:65146 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727826AbfGWL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17532238-1500050 
        for multiple; Tue, 23 Jul 2019 12:28:49 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DC7C082@hasmsx108.ger.corp.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>
References: <20190723111913.20475-1-chris@chris-wilson.co.uk>
 <5B8DA87D05A7694D9FA63FD143655C1B9DC7C082@hasmsx108.ger.corp.intel.com>
Message-ID: <156388132716.31349.11822559564861280475@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: RE: [PATCH] mei: Abort writes if incomplete after 1s
Date:   Tue, 23 Jul 2019 12:28:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Winkler, Tomas (2019-07-23 12:25:14)
> > 
> > During i915 unload, it appears that it may get stuck waiting on a workqueue
> > being hogged by mei:
> 
> Thanks for the bug report, but this is not a proper fix, we will try to work it out.

Perfect :)

It's only happened a couple of times in the last week or so, but if you
want to throw patches at intel-gfx-trybot@lists.freedesktop.org to try
and grab more information, please feel free to.
-Chris
