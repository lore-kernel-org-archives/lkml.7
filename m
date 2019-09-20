Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568965576;
	bh=1yZ0DYSLh5xqAj+fIasPisqFTh/IWQdz6nmgz7HE5EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ds0yD358CyL7sqbr0iIS8EXST7Liq9OpaV/E4hbfjpPgytxQLv7vslUvENwOIDD26
	 2T6ZHQKEo3Z6vlgwWgKikdD9knv1oddhP8s5/bYfRhmrh8XoVGGnM/hy255ZQ92CEn
	 wV6Eic/KhhVUuwf9lOQxgjOf037ocrxrkkevLy4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437578AbfITHqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404836AbfITHqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:46:15 -0400
Received: from localhost (unknown [89.205.140.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC6F2054F;
        Fri, 20 Sep 2019 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568965574;
        bh=1yZ0DYSLh5xqAj+fIasPisqFTh/IWQdz6nmgz7HE5EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P31Qlo4gk7+HByBoI78w0V5DQl5SxrCwc6l7P5lLN6+n2vTplKynBMFkBQddGveup
         lWrlCn9QH8uFozfKqY86Z069nY3e3NlXvqtjS6msuEZVMfRDUeGgFxchMKtirA2df9
         K6Qz7cph8oqRc/puWtBc73kMw2TEJaBn0ZhtJwWQ=
Date:   Fri, 20 Sep 2019 09:46:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gregory Nowak <greg@gregn.net>
Cc:     devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        okash.khawaja@gmail.com, Didier Spaier <didier@slint.fr>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190920074611.GB518462@kroah.com>
References: <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
 <20190915134300.GA552892@kroah.com>
 <CAOtcWM2MD-Z1tg7gdgzrXiv7y62JrV7eHnTgXpv-LFW7zRApjg@mail.gmail.com>
 <20190916134727.4gi6rvz4sm6znrqc@function>
 <20190916141100.GA1595107@kroah.com>
 <20190916223848.GA8679@gregn.net>
 <20190917080118.GC2075173@kroah.com>
 <20190918010351.GA10455@gregn.net>
 <20190918061642.GB1832786@kroah.com>
 <20190918203032.GA3987@gregn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918203032.GA3987@gregn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 01:30:33PM -0700, Gregory Nowak wrote:
> > Extra line between each attribute (before the "What:" line) would be
> > nice.
> 
> In a previous post above, you wrote:
> On Mon, Sep 16, 2019 at 04:11:00PM +0200, Greg Kroah-Hartman wrote:
> > Anyway, please put the Description: lines without a blank after that,
> > with the description text starting on that same line.
> 
> I understood that to mean that the description text should start on
> the same line, and the blank lines after the description text should
> be removed. I've put them back in. Someone more familiar with the
> speakup code will have to dig into it to resolve the TODO items I
> suppose.

No problem, this looks good to me.  If someone wants to turn this into a
patch adding it to the drivers/staging/speakup/ directory, I'll be glad
to take it and it will allow others to fill in the TODO entries easier.

thanks,

greg k-h
