Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A333C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4162077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfCUOiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:38:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38333 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:38:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6ypR-0006dI-PE; Thu, 21 Mar 2019 15:37:57 +0100
Date:   Thu, 21 Mar 2019 15:37:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] docs: Explicitly state ordering requirements for
 Co-developed-by
In-Reply-To: <20190321142622.GA6519@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903211537340.1784@nanos.tec.linutronix.de>
References: <20190320151140.32432-1-sean.j.christopherson@intel.com> <87lg18e4nx.fsf@intel.com> <20190321142622.GA6519@linux.intel.com>
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

On Thu, 21 Mar 2019, Sean Christopherson wrote:
> On Thu, Mar 21, 2019 at 03:30:10PM +0200, Jani Nikula wrote:
> Hmm, and my experience is exclusively limited to contributing code to
> someone else's patches.  Rather than dictate exact ordering, what about
> deferring to standard sign-off procedure?
> 
> E.g.:
> 
>   A Co-developed-by: states that the patch was also created by another developer
>   along with the original author.  This is useful at times when multiple people
>   work on a single patch.  Co-developed-by: must be immediately followed by a
>   Signed-off-by: of the co-author(s).  As per standard sign-off procedure, the
>   ordering of Co-developed-by:/Signed-off-by: pairs should reflect the patch's
>   handling insofar as possible.  Notably, the last Signed-off-by: must always be
>   that of the developer submitting the patch, regardless of whether they are the
>   original author or a co-author.

Yes, that makes sense.

Thanks,

	tglx

