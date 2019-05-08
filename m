Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4799DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170CB216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfEHVuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:50:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:55296 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfEHVuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:50:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E872E316;
        Wed,  8 May 2019 21:50:51 +0000 (UTC)
Date:   Wed, 8 May 2019 15:50:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: GFS2: Pull Request
Message-ID: <20190508155050.186a1ba4@lwn.net>
In-Reply-To: <CAHk-=wiUMj0nwj_ee59J4yLnbnR_UfMeRx4agijSc7DKJADoPw@mail.gmail.com>
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
        <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
        <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
        <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
        <20190508145818.6a53dff5@lwn.net>
        <CAHk-=wiUMj0nwj_ee59J4yLnbnR_UfMeRx4agijSc7DKJADoPw@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 14:05:35 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 8, 2019 at 1:58 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > I think this certainly belongs in the maintainer manual, but probably not
> > in pull-requests.rst.  There are a lot of things about repository
> > management that seem to trip up even experienced maintainers; pre-pull
> > merges is just one of those.  I would love to see a proper guide on when
> > and how to do merges in general.  
> 
> We had another pull request issue today, about a situation that I
> definitely know you've written about in the past, because I linked to
> lwn in my email:
> 
>    https://lore.kernel.org/lkml/CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com/

Sigh, I never can escape my past sins...

> and while I suspect people don't actually read documentation
> (_particularly_ maintainers that have already been around for a long
> time but still do this), maybe that part could be in the same
> documentation?

Something derived from that would make sense, yes.  I'll see if I can't
pull something together, unless by some delightful miracle somebody beats
me to it.

jon
