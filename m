Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79044C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE221902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553195646;
	bh=sVkLHg1pEO55aBJJS11l3KKaWK2rcQgqa02HwPhjGvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AHFP/B/uPuNSKSlcg1NFyATlGCYH0I4HGJhQWkFgclHcLxUDqZh/mCgNGS8pXq9o7
	 rcgtciTbGVwJgEiGIDHn22VFwrYJDXAWZZURCdBz7jnkLbtbvhtlvCB4JwNvM+fc83
	 gnBwjbLDTWrjO7XJhbbBG/SNLzaOXHNiciz+UYPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCUTOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCUTOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:14:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D522175B;
        Thu, 21 Mar 2019 19:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553195643;
        bh=sVkLHg1pEO55aBJJS11l3KKaWK2rcQgqa02HwPhjGvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjkfh3hRQPA2Hz8WE81BHtgzYGKgVnfnHZVveURdEfs3Ee+bk0ADRscnucbw9/0wW
         ShGgX1bnsYCdSCcgdUTL3LeHB0BoRQ0n0olzGGggAc22ZqlOB3GSH5AalC2+thHoAy
         f8SRm4G5nORKz9IEC0dbyY8/3coZquMf+51NRRtw=
Date:   Thu, 21 Mar 2019 20:14:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2] docs: Clarify the usage and sign-off requirements for
 Co-developed-by
Message-ID: <20190321191400.GA6408@kroah.com>
References: <20190321184316.8525-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321184316.8525-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:43:16AM -0700, Sean Christopherson wrote:
> The documentation for Co-developed-by is a bit light on details, e.g. it
> doesn't explicitly state that:
> 
>   - Multiple Co-developed-by tags are perfectly acceptable
>   - Co-developed-by and Signed-off-by must be paired together
>   - SOB ordering should still follow standard sign-off procedure
> 
> Lack of explicit direciton has resulted in developers taking a variety
> of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
> willy-nilly, collecting them all at the end or the beginning, etc...
> 
> Tweak the wording to make it clear that multiple co-authors are allowed,
> and document the expectation that standard sign-off procedures are to
> be followed.  Provide examples to (hopefully) eliminate any ambiguity.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
