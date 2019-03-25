Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB2F20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:31:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:43140 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:31:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2934B9B1;
        Mon, 25 Mar 2019 16:31:15 +0000 (UTC)
Date:   Mon, 25 Mar 2019 10:31:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v5 1/2] docs: Clarify the usage and sign-off
 requirements for Co-developed-by
Message-ID: <20190325103114.2df3b91d@lwn.net>
In-Reply-To: <20190322211137.18241-2-sean.j.christopherson@intel.com>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
        <20190322211137.18241-2-sean.j.christopherson@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 14:11:36 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> The documentation for Co-developed-by is a bit light on details, e.g. it
> doesn't explicitly state that:
> 
>   - Multiple Co-developed-by tags are perfectly acceptable
>   - Co-developed-by and Signed-off-by must be paired together
>   - SOB ordering should still follow standard sign-off procedure
> 
> Lack of explicit direction has resulted in developers taking a variety
> of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
> willy-nilly, collecting them all at the end or the beginning, etc...
> Tweak the wording to make it clear that multiple co-authors are allowed,
> and document the expectation that standard sign-off procedures are to
> be followed.
> 
> The use of "original author" has also led to confusion as many patches
> don't have just one "original" author, e.g. when multiple developers
> are involved from the genesis of the patch.  Remove all usage of
> "original" and instead call out that Co-developed-by is simply a way to
> provide attribution in addition to the From tag, i.e. neither tag is
> intended to imply anything with regard to who did what.
> 
> Provide examples to (hopefully) eliminate any ambiguity.

I've applied this.  Joe, do you want to handle the checkpatch.pl patch, or
would you prefer I take that one too?

Thanks,

jon
