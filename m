Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23D21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfCVRNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:13:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:62824 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfCVRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:13:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331088388"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2019 10:13:44 -0700
Date:   Fri, 22 Mar 2019 10:13:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v4] docs: Clarify the usage and sign-off requirements for
 Co-developed-by
Message-ID: <20190322171344.GC12666@linux.intel.com>
References: <20190322155735.13954-1-sean.j.christopherson@intel.com>
 <0f4538aa6a91c071f6e590c2d3f60a474b14fab5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4538aa6a91c071f6e590c2d3f60a474b14fab5.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:03:07AM -0700, Joe Perches wrote:
> On Fri, 2019-03-22 at 08:57 -0700, Sean Christopherson wrote:
> > The documentation for Co-developed-by is a bit light on details, e.g. it
> > doesn't explicitly state that:
> > 
> >   - Multiple Co-developed-by tags are perfectly acceptable
> >   - Co-developed-by and Signed-off-by must be paired together
> >   - SOB ordering should still follow standard sign-off procedure
> > 
> > Lack of explicit direction has resulted in developers taking a variety
> > of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
> > willy-nilly, collecting them all at the end or the beginning, etc...
> > Tweak the wording to make it clear that multiple co-authors are allowed,
> > and document the expectation that standard sign-off procedures are to
> > be followed.
> > 
> > The use of "original author" has also led to confusion as many patches
> > don't have just one "original" author, e.g. when multiple developers
> > are involved from the genesis of the patch.  Remove all usage of
> > "original" and instead call out that Co-developed-by is simply a way to
> > provide attribution in addition to the From tag, i.e. neither tag is
> > intended to imply anything with regard to who did what.
> > 
> > Provide examples to (hopefully) eliminate any ambiguity.
> 
> Please add the checkpatch bit to this at the same time.

Doh, spaced on that.  I'll wait for additional feedback before sending v5.
