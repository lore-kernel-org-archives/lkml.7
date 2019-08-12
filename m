Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AD820663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHLHNy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:13:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61302 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfHLHNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:13:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17964774-1500050 
        for multiple; Mon, 12 Aug 2019 08:13:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190812071148.GA696@tigerII.localdomain>
Cc:     intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
 <20190812071148.GA696@tigerII.localdomain>
Message-ID: <156559400671.2301.14424611837808765850@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
Date:   Mon, 12 Aug 2019 08:13:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-12 08:11:48)
> On (08/08/19 18:22), Chris Wilson wrote:
> [..]
> > @@ -20,31 +20,18 @@ int i915_gemfs_init(struct drm_i915_private *i915)
> >       if (!type)
> >               return -ENODEV;
> [..]
> > +     gemfs = kern_mount(type);
> > +     if (IS_ERR(gemfs))
> > +             return PTR_ERR(gemfs);
> >  
> >       i915->mm.gemfs = gemfs;
> 
> We still have to put_filesystem(). Right?

Yes. We still your patches for EXPORT_SYMBOL.
-Chris
