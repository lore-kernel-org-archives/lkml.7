Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EAFCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D6A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572436286;
	bh=86niS+Bu6PjKYw/OmoYM8CXQ0cHmlv2vxZTrQuilw9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2bFU3uKnCXtNYTYdWvWDQI+FbaadPzb/BBM/3wn4Sos8oOhFFIeijrA6fbnsYS1kG
	 WjLETI4gI7jVkzZiS9qa+JIyfVzAp7bGHrG80nYeqdx7zKKIywWmgMSoA9LD2lLuyw
	 v2z2SiCUUvBNjXMZPpEUa1/taH8ynryr0MH1Fv+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfJ3LvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:51:25 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D93620874;
        Wed, 30 Oct 2019 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572436285;
        bh=86niS+Bu6PjKYw/OmoYM8CXQ0cHmlv2vxZTrQuilw9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmnnp6uQ7usy1WwwcWFC41vIu3m7xivvzDSrcqnz/a/YOQGK1XNMS9tZ7GWhwUim0
         ia5oYVoRcZaF4XjJ2GTNiPJBUdrYs/YyASbOpTLTNRaub6k9FnSPGBI6wKzqibVrva
         tG2RANrpXw61lcJtf5xG0BM+i6/g1+D9uCHL/txg=
Date:   Wed, 30 Oct 2019 12:51:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Sanket Parmar <sparmar@cadence.com>, pawell@cadence.com,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        peter.chen@nxp.com, nsekhar@ti.com
Subject: Re: [PATCH] usb: cdns3: gadget: reset EP_CLAIMED flag while unloading
Message-ID: <20191030115122.GB701802@kroah.com>
References: <20191029122441.5816-1-sparmar@cadence.com>
 <8736fafomi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736fafomi.fsf@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 01:40:05PM +0200, Felipe Balbi wrote:
> 
> Hi Greg,
> 
> Sanket Parmar <sparmar@cadence.com> writes:
> 
> > EP_CLAIMED flag is used to track the claimed endpoints. While unloading the
> > module, Reset EP_CLAIMED flag for all enabled endpoints. So that it can be
> > reused.
> >
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> 
> if you want to take this as a patch:
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>

Thanks, will queue it up.

greg k-h
