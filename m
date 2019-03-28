Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06737C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBB82082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfC1ADy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:03:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1ADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:03:54 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9IWM-0005hk-1p; Thu, 28 Mar 2019 01:03:50 +0100
Date:   Thu, 28 Mar 2019 01:03:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-audit@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect
 the system clock
In-Reply-To: <CALAqxLVbGRgJFgNU-45QvLe0SiPP+VMw3Jx_jrLQvAhgs2ZQqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903280103320.1789@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com> <CALAqxLVbGRgJFgNU-45QvLe0SiPP+VMw3Jx_jrLQvAhgs2ZQqQ@mail.gmail.com>
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

On Wed, 27 Mar 2019, John Stultz wrote:
> On Mon, Mar 25, 2019 at 7:50 AM Paul Moore <paul@paul-moore.com> wrote:
> > These patches look fine to me, but it would be really nice to get an
> > ACK from the time folks before I merge this into audit/next.  Time
> > folks, I know you've looked at previous versions of this patchset, can
> > you give this a quick look to make sure everything is still okay from
> > your perspective?
> >
> 
> Sorry for the slow response.  I briefly looked it over and it seems
> simple enough, so don't really have any objections. Though I don't
> have as sharp an eye (or opinion :) as Thomas, so no promises he won't
> step in with an issue.

I did already :)
