Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1D5218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCPJfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:35:47 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54040 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCPJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 05:35:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id E8A5AE421;
        Sat, 16 Mar 2019 10:35:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ydu5AIlnvBS1; Sat, 16 Mar 2019 10:35:45 +0100 (CET)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 44DBFE420;
        Sat, 16 Mar 2019 10:35:45 +0100 (CET)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1h55jD-0000rS-Vd; Sat, 16 Mar 2019 10:35:43 +0100
Date:   Sat, 16 Mar 2019 10:35:43 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Chris Brannon <chris@the-brannons.com>
Cc:     Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190316093543.w4i6djt5uuqtx5xr@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>, Kirk Reiser <kirk@reisers.ca>,
        linux-kernel@vger.kernel.org
References: <20190315130035.6a8f16e9@narunkot>
 <87ef77obtg.fsf@cmbmachine.messageid.invalid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef77obtg.fsf@cmbmachine.messageid.invalid>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Brannon, le ven. 15 mars 2019 18:19:39 -0700, a ecrit:
> Okash Khawaja <okash.khawaja@gmail.com> writes:
> > Finally there is an issue where text in output buffer sometimes gets
> > garbled on SMP systems, but we can continue working on it after the
> > driver is moved out of staging, if that's okay. Basically we need a
> > reproducer of this issue.
> 
> What kind of reproducer do you need here?  It's straightforward to
> reproduce in casual use, at least with a software synthesizer.

The problem is that neither Okash nor I are even casual users of
speakup, so we need a walk-through of the kind of operation that
produces the issue. It does not have to be reproducible each time it is
done. Perhaps (I really don't know what that bug is about actually) it
is a matter of putting text in the selection buffer, and try to paste it
100 times, and once every 10 times it will be garbled, for instance.

Samuel
