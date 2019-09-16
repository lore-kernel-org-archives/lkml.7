Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90353C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C62D206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfIPIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:30:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfIPIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:30:20 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9mOa-00036L-2I; Mon, 16 Sep 2019 10:30:04 +0200
Date:   Mon, 16 Sep 2019 10:30:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 4/4] Documentation/process: add transparency promise to
 list subscription
In-Reply-To: <20190911155137.GC14152@kroah.com>
Message-ID: <alpine.DEB.2.21.1909161028340.10731@nanos.tec.linutronix.de>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com> <20190910172652.4FFF6CA3@viggo.jf.intel.com> <20190911155137.GC14152@kroah.com>
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

On Wed, 11 Sep 2019, Greg KH wrote:
> On Tue, Sep 10, 2019 at 10:26:52AM -0700, Dave Hansen wrote:
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > Transparency is good.  It it essential for everyone working under an
> > embargo to know who is involved and who else is a "knower".  Being
> > transparent allows everyone to always make informed decisions about
> > ongoing participating in a mitigation effort.
> > 
> > Add a step to the subscription process which will notify existing
> > subscribers when a new one is added.
> 
> As I don't run the mailing list software here, I don't know how much of
> a burden adding this support to it would be, so I'll defer to Thomas.
> 
> We could just have something like "All new people need to announce
> themselves" rule like many other private mailing lists have at times.
> That would put the burden on the new person once, instead of the list
> manager for every time a new person is added.

That's trivial and can be fully automated into the list scripts. I'll put
that on to the todo list as I'm in the process of cleaning stuff up and
fixing the documentation before pushing the whole pile out.

Thanks,

	tglx
