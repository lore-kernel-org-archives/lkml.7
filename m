Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA2C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43EF20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568216698;
	bh=W4sq4g8vHz/1RaxHr/60DG1a5MmEGKJJ2sUuzxXyeYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WiTcSemPBSDRWRwzy96V0bbtsBoFkVBiQCicsm56SyrBdZlw++nAMseoEYNM1UG0
	 XS0ulF3lgWWBwQVqJh2RWHJXvuP779gJm1G4gLoCxQeESVQp39WvXPOcfjQit1Ysf+
	 iVLFmZds1FVNZ+pJEXdeMojdc+g+LZaD/ztVi3BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfIKPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfIKPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:44:57 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB0E2087E;
        Wed, 11 Sep 2019 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568216696;
        bh=W4sq4g8vHz/1RaxHr/60DG1a5MmEGKJJ2sUuzxXyeYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOTRMBbis1WBB6PGeKfz9LCOfEiuFKIC8PH+F7brFo4uDcQQbVg58lIi+WChMzzOb
         EeZThZmdKdvg15pu1OjQmxWpcUzceuqfiTLOZ9uV5Po7f+TFKduekYKR5bVXIVzjsy
         l4+vbdNgaMBarvV9b+9x5atzXmgOFOnEOuVth5BY=
Date:   Wed, 11 Sep 2019 16:44:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, tglx@linutronix.de, labbott@redhat.com,
        andrew.cooper3@citrix.com, tsoni@codeaurora.org,
        keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/4] Documentation/process: describe relaxing disclosing
 party NDAs
Message-ID: <20190911154453.GA14152@kroah.com>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
 <20190910172649.74639177@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910172649.74639177@viggo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:26:49AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Hardware companies like Intel have lots of information which they
> want to disclose to some folks but not others.  Non-disclosure
> agreements are a tool of choice for helping to ensure that the
> flow of information is controlled.
> 
> But, they have caused problems in mitigation development.  It
> can be hard for individual developers employed by companies to
> figure out how they can participate, especially if their
> employer is under an NDA.
> 
> To make this easier for developers, make it clear to disclosing
> parties that they are expected to give permission for individuals
> to participate in mitigation efforts.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Trilok Soni <tsoni@codeaurora.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/Documentation/process/embargoed-hardware-issues.rst |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff -puN Documentation/process/embargoed-hardware-issues.rst~hw-sec-0 Documentation/process/embargoed-hardware-issues.rst
> --- a/Documentation/process/embargoed-hardware-issues.rst~hw-sec-0	2019-09-10 08:39:02.835488131 -0700
> +++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 08:39:02.838488131 -0700
> @@ -74,6 +74,13 @@ unable to enter into any non-disclosure
>  is aware of the sensitive nature of such issues and offers a Memorandum of
>  Understanding instead.
>  
> +Disclosing parties may have shared information about an issue under a
> +non-disclosure agreement with third parties.  In order to ensure that
> +these agreements do not interfere with the mitigation development
> +process, the disclosing party must provide explicit permission to
> +participate to any response team members affected by a non-disclosure
> +agreement.  Disclosing parties must resolve requests to do so in a
> +timely manner.

I wrote a fun long rant of a response here, but deleted it so now I feel
better.  But that doesn't help anyone but myself, so here's my censored
response instead...

Intel had months of review time for this document before this was
published.  Your lawyers had it and never objected to this lack of
inclusion at all, and explictitly said that the document as written was
fine with them.  So I'm sorry, but it is much too late to add something
like this to the document at this point in time.

If your legal department has any remaining objections like this, please
bring it up in the proper legal forum where all of the other companies
that already discussed this in can review and discuss it.  As it is,
including something like this would require their buy-in anyway, and
obviously that did not happen with this proposal.

So no, I'm not going to apply this change, sorry.

Oh, and cute use of the term, "timely manner", as if we are going to
fall for that one again... :)

greg k-h
