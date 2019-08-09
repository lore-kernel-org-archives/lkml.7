Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C7C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6346214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436592AbfHISwh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:52:37 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51800 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726168AbfHISwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:52:36 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17947255-1500050 
        for multiple; Fri, 09 Aug 2019 19:52:26 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Matthew Auld <matthew.william.auld@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAM0jSHP0BZJyJO3JeMqPDK=eYhS-Az6i6fGFz1tUQgaErA7mfA@mail.gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
 <CAM0jSHP0BZJyJO3JeMqPDK=eYhS-Az6i6fGFz1tUQgaErA7mfA@mail.gmail.com>
Message-ID: <156537674371.32306.7527004745489566049@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
Date:   Fri, 09 Aug 2019 19:52:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Auld (2019-08-09 19:47:02)
> On Thu, 8 Aug 2019 at 18:23, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > The filesystem reconfigure API is undergoing a transition, breaking our
> > current code. As we only set the default options, we can simply remove
> > the call to s_op->remount_fs(). In the future, when HW permits, we can
> > try re-enabling huge page support, albeit as suggested with new per-file
> > controls.
> >
> > Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Thanks, picked up with the s/within/within_size/ fix.
-Chris
