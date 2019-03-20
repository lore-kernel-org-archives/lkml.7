Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF8E21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066789;
	bh=ANsm3D2ovhBcn46e8GhphgkcjpvAJ09BO3ijctap7OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bq1iOfqdB3v2oAuvXEzkcqm8TzWwJHM/PLscEwdWV7z619qBIzEjgS9xYcIEvkP/f
	 ekuOpwFrYXLPpDGD3aI3TrUsyILy3FvSI5ec+TW+GfNHLm/JiMKddN8kRGQZ7Rmpk/
	 YOib5smrCdK5YI1viNfBPBE2A+XPcs5mPnjUJBfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfCTH01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:26:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA46421841;
        Wed, 20 Mar 2019 07:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066787;
        bh=ANsm3D2ovhBcn46e8GhphgkcjpvAJ09BO3ijctap7OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbK/iFoFQUWu6WLZMoZuSW3q3DZVvRhLFSQgFxPha0rtaHXkjUeuvMXfGzwU1lbFl
         cWbHSgwPRrqc/Cwp+QWjg7oaE5HzFPwEx/vRK1/+E6vL3gOHTiPV48RF8LXqKJbqH0
         HixBrXyuKLgfR/T20MI2lU29b/iX4Dgsc+NcO0HE=
Date:   Wed, 20 Mar 2019 08:26:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20190320072605.GA32121@kroah.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:01PM -0600, George Hilliard wrote:
> Because of this change, the driver now expects a pinctrl device
> reference in the mmc controller's device tree node; without it, it will
> bail out.  This could break existing setups that don't specify it
> because it "just worked" up until now.  So currently I just let the old
> behavior fall away because this is a staging driver.  But if this is a
> problem, the old behavior could be added back as a fallback.
> 
> This is version 2 of a patchset that I requested feedback for about a
> month ago.  Please review as if they are a new patchset; all the patches
> were rebased several times and a couple new correctness fixes added.
> 
> The TODO list is largely unchanged, aside from the couple of TODO
> comments in the code that I have addressed.  Ultimately, I think this
> driver could potentially be merged with the "real" mtk-mmc driver as the
> TODO suggests, but someone who is more familiar with the IP core will
> have to do that.  Mediatek documentation (that I can find) is very
> sparse.
> 
> This is ready to merge if there is no other feedback!
> 
> >From George Hilliard <thirtythreeforty@gmail.com> # This line is ignored.
> From: George Hilliard <thirtythreeforty@gmail.com>
> Reply-To: 
> Subject: [PATCH v2 00/11] mt7621-mmc: Various correctness fixes
> In-Reply-To: 
> 
> 

No subject for this email?

