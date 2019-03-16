Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757D2218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCPKWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:22:07 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54660 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:22:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 566CBE45F;
        Sat, 16 Mar 2019 11:22:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 13FbM_lOeFsS; Sat, 16 Mar 2019 11:22:03 +0100 (CET)
Received: from function (rev36.vpn.fdn.fr [80.67.179.36])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A8B91E45E;
        Sat, 16 Mar 2019 11:22:03 +0100 (CET)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1h56S2-0000ai-K4; Sat, 16 Mar 2019 11:22:02 +0100
Date:   Sat, 16 Mar 2019 11:22:02 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Chris Brannon <chris@the-brannons.com>, deedra@the-brannons.com,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190316102202.py3qczl3g4fw3myn@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>, deedra@the-brannons.com,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>, Kirk Reiser <kirk@reisers.ca>,
        linux-kernel@vger.kernel.org
References: <20190315130035.6a8f16e9@narunkot>
 <87ef77obtg.fsf@cmbmachine.messageid.invalid>
 <20190316093543.w4i6djt5uuqtx5xr@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316093543.w4i6djt5uuqtx5xr@function>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please keep the lists in Cc, so that not only I have the information
(in particular since I will probably *not* have the time to investigate
myself).

Samuel Thibault, le sam. 16 mars 2019 10:35:43 +0100, a ecrit:
> The problem is that neither Okash nor I are even casual users of
> speakup, so we need a walk-through of the kind of operation that
> produces the issue.

deedra Waters <deedra@the-brannons.com> wrote:
> it's dead simple

For a user, perhaps, but again, neither Okash or I are actual users of
speakup, so we have just no idea what casual use is.

> just lead the screenreader read large blocks of text i guarantee it's
> reproduceable.

Which shortcut do you use to make the screen reader read it?  What is
"large"? Is that only one 80x25 complete output screen? Is that cat-ing
a long text? How is it garbled: is that right from the beginning of the
text? or at some point during it? or is that just a piece of it and then
it's Ok again?

Samuel
