Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88946CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F40421721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572281956;
	bh=UYouAhSgD6Ci8zsPE6rdCP7HF2cJHswezxxOQTzMf9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bo1y0Z3HkCoyr20XizeeApaSRUuyd+2V8UF+MFbbF4EYQ7rGCz+k4TLaRNK/h+lL7
	 kwiGs0agED849hEN6lXlRILeWm9ZnrP3nzo6E5Xx3q0EhFfDhvZsdHoR3F0JQd6+2B
	 1RuQ5iGw60P4JSEqAPvBrxVuUaUPlLr8+4Xy/qbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbfJ1Q7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfJ1Q7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:59:12 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4911F208C0;
        Mon, 28 Oct 2019 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572281951;
        bh=UYouAhSgD6Ci8zsPE6rdCP7HF2cJHswezxxOQTzMf9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqs9XFdFAkSZIlT5PTS4XYl6FpeFgw1NlLwbUkgyqiDIRfL4FbaXiFLxBciPFCsEg
         QlPMhcoiXGwxlACI9zioIW/pJEICg79mqqsTLYbioElb2HIJt/VtjZFJdEpUPqVPLx
         hhKOQV6Pp764XR1ZfW3Tha9FZJzg3OGuyfe48B2E=
Date:   Mon, 28 Oct 2019 17:59:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     devel@driverdev.osuosl.org, eric@anholt.net, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028165909.GA469472@kroah.com>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <20191028155354.s3bgq2wazwlh32km@linux-p48b>
 <20191028162412.GA321492@kroah.com>
 <20191028163537.b2pspgdl6ceevcxv@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163537.b2pspgdl6ceevcxv@linux-p48b>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:35:37AM -0700, Davidlohr Bueso wrote:
> On Mon, 28 Oct 2019, Greg KH wrote:
> > This is obviously not in a format I can apply it in :(
> 
> What are you talking about? I sent you the original patch,
> then Cc'ed the drivers mailing list. So you still have a
> patch you can apply... this is quite a common way of doing
> things (Ccing for future references to someone or another
> ml). I don't understand why you are hairsplitting over this
> patch.

I don't understand what is going on at all.  Is this patch already
applied?  If not, then yes, I need it in a format I can apply it in.  If
it's already applied to my tree/branch, then there's no need to send it
at all.

totally confused,

greg k-h
