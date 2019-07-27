Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A3C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4942075C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564225617;
	bh=uGlMJNh8VE7kip7O24qK6wOKHfho1CIUNRdJQAgqSwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3P6CqEtblJ2vVtO4NR6PM2OjRIm+Ylpa1Y5aQ/TiMHhDsxB3iHKggZYnA6LOS1Qi
	 b7HN7azyyoh/q0mPKXfxl/Wqxd8gX8o90PvrPqxmh31Gj3WEPBHewZvx89kTSOkQLy
	 9/1GvUVl52GOhrlMiTjI+V5Jjqvt0HJvt3R4tgMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfG0LG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 07:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387442AbfG0LG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:06:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F2C2075C;
        Sat, 27 Jul 2019 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564225615;
        bh=uGlMJNh8VE7kip7O24qK6wOKHfho1CIUNRdJQAgqSwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gpux8TCJhkRSm+bf32EPFxXwvIirUMbtaEJILvxLsa6oI0aRrbfCz05NklaU41ddr
         jW0CC+R+A0pyk+6Wb9uh2aFd+qXBPaVp1UR9p06ewp41PUVjZioM55FI4WhdWkrgPD
         s2pbd1Djh6hoLoc3Z3GL+08Rf6N+ty/BBimZAakY=
Date:   Sat, 27 Jul 2019 13:06:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Devicetree fixes for 5.3-rc, take 2
Message-ID: <20190727110653.GF458@kroah.com>
References: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:03:50PM -0600, Rob Herring wrote:
> Hi Linus,
> 
> Please pull some more DT fixes for 5.3. The nvmem changes would
> typically go thru Greg's tree, but they were missed in the merge
> window and I've been unable to get a response (partly because Srinivas
> is out on vacation it appears).

No objection from me for this.

thanks,

greg k-h
