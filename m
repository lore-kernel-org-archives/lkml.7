Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA1C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AF121872
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565858651;
	bh=llVxxBukpJG5SJY+eHk9wmKykH5m0KfyP/mwsBZgdvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=159xetPq7plLe86ZKqWdIvFSHNhuum6A3fbWpdOcX/mpmN2KSzCswcWyT532JsgBY
	 u9vLxBEuRCwUrnAIH/7d4Jt5zTJhT6gmhrTwINpPl/e7maojj27SkushbFL9uYLYTZ
	 uetfoYImqbu1CeR8JATA34OqJQ2GdkmNG+GDR2no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfHOIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B760C21851;
        Thu, 15 Aug 2019 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858649;
        bh=llVxxBukpJG5SJY+eHk9wmKykH5m0KfyP/mwsBZgdvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+JngZy0Ci5goEa/AnERQlvhzC0OENPk2e5akbI4QvA6V8bRkKpqq49QWADMLZWyc
         Xk8lSxhYWqIvyPSJgaFTvyXBOOoRyPTWyUARLf7z/319tewP1n3EE7COsg8uBaWB31
         CXEcN6g8OJO9t3TlC+Q4yaDKWMRn1eAh2UvA5dMQ=
Date:   Thu, 15 Aug 2019 10:44:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        matthias.bgg@gmail.com, neil@brown.name,
        thirtythreeforty@gmail.com, christian@lkamp.de,
        nishadkamdar@gmail.com, ser.perschin@gmail.com, blogic@openwrt.org,
        jan.kiszka@siemens.com
Subject: Re: [stable] Deleting "mt7621-mmc" with "interesting" license?
Message-ID: <20190815084406.GC3512@kroah.com>
References: <20190815071350.GB3906@amd>
 <20190815075132.GA30284@kroah.com>
 <20190815075927.GC3669@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815075927.GC3669@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:59:27AM +0200, Pavel Machek wrote:
> On Thu 2019-08-15 09:51:32, Greg KH wrote:
> > On Thu, Aug 15, 2019 at 09:13:50AM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I realize that "interesting" license is not on a list of bugs suitable
> > > for -stable, but on the other hand, this tends to scare corporate
> > > lawyers... so perhaps we should remove the driver in -stable, too?
> > > 
> > > Upstream commit id is 441bf7332d55c4d34afae9ffc3bbec621093f4d1.
> > > 
> > > 4.19 has the problematic driver, 4.4 does not.
> > 
> > If a lawyer has issues with this, please just upgrade to the latest
> > kernel release :)
> 
> We are talking this project:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/start .
> Upgrading is not an option, but I can take the patch locally.

It does not meet the stable rules, sorry, I'm not going to take it.

> If someone has confirmation that "interesting" license is a mistake
> and it is indeed GPL, that would be nice, too.

Feel free to discus it with the company who wrote the driver :)

good luck!

greg k-h
