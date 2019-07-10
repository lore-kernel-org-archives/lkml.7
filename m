Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABDC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A620665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfGJQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:45:19 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:33437 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbfGJQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:45:19 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id lFiUhwAZy0SBqlFiXh8vkM; Wed, 10 Jul 2019 18:45:17 +0200
Message-ID: <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 18:45:14 +0200
In-Reply-To: <1562776339.3213.50.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
         <1562776339.3213.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNbzLWZLuh1XujReLYpRK8CR5zZBk8afhybZyOc0P8XoqWz2+slcd9HGh7xkABVaQu054GrdSrCpN8vNd/JzsrDStYmD4KqONQdh0MUQd3iIrnTw2Wxy
 bi8ZQ3MYREuWcUhh1dSYkbpbf9bECwc/6L/GNcDrpUjqHbc5cTot0/WWX1OKYlXWi6hdtlPO40geBVGzxcBahggrYyx7QUVD2WLrwqVCDarGIXZfWlsfi0RN
 0pdosbU7uXHoz1D3cw11ygFTM8Mc/p3O5TsjWTXVURg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley schreef op wo 10-07-2019 om 09:32 [-0700]:
> You seem to be getting it to happen much more often than I can. Last
> night, on the below pull request it took me a good hour to see the
> freeze.

Yes. Sometimes within a minute of resuming. Typing stuff into evolution seems
to help with triggering this. It's all a bit mysterious, but this message
alone frooze my laptop a few times. Seriously!

> Sure, my current testing indicates it's somewhere inside this pull
> request:
> 
> Merge: 89c3b37af87e eb85d03e01c3
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed May 8 21:35:19 2019 -0700
> 
>     Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
>     
>     Pull drm updates from Dave Airlie:

Lazy question: how does one determine the first and last commit inside a merge
request? Can I simply do
    good   a2d635decbfa9c1e4ae15cb05b68b2559f7f827c^
    bad    a2d635decbfa9c1e4ae15cb05b68b2559f7f827c

for git bisect?

> So I was about to test out the i915 changes in that but since my laptop
> is what I use for daily work, it's a bit hard (can't freeze up on video
> calls for instance).

I usually use one of the ThinkPads from my embarrassing pile of outdated
hardware to do nasty bisects, but I'm not about to loose any income if my much
appreciated XPS 13 is out of order for a while.

Thanks,


Paul Bolle

