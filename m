Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB06C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1521903
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfDRJH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:07:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbfDRJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:07:22 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hH30q-00025T-FO; Thu, 18 Apr 2019 11:07:20 +0200
Date:   Thu, 18 Apr 2019 11:07:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] ntp: Allow TAI-UTC offset to be set to zero
In-Reply-To: <20190418080710.GE5984@localhost>
Message-ID: <alpine.DEB.2.21.1904181106150.3174@nanos.tec.linutronix.de>
References: <20190417084833.7401-1-mlichvar@redhat.com> <CAFqZXNu_pc1BEGZJb=3Ez58uN+BfoECpSm2yVqv1MMx7iTLfRw@mail.gmail.com> <20190418080710.GE5984@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Miroslav Lichvar wrote:
> On Wed, Apr 17, 2019 at 11:00:23AM +0200, Ondrej Mosnacek wrote:
> > On Wed, Apr 17, 2019 at 10:48 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > > Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
> > > order to allow setting it back to the initial value.
> 
> > Thanks for sending the patch! Maybe you (or the committer) could
> > consider adding:
> > 
> > Fixes: 153b5d054ac2 ("ntp: support for TAI")
> 
> To me the change looks more like an extension of the API, rather than
> a bug fix, so I'd leave that up to the committer.

I don't see why we need to backport that all the way, but I'm happy to add
the tag if there is some really good reason.

Thanks,

	tglx
