Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2B6C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F38120863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560798870;
	bh=96nDFxr5NSaDzK5hagsvc8sybepkdnbVQY2MD6PCZHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0iiOjHyeR9QvgU9289+rk+9deM3QYYKQsHf6OlBh8jYtwX2S4S3ohaamBhVjDbKB0
	 NksrRgRLzbXkkfpIsSw5PSLSpJgVOw77hgn9Pj2ydN/n9xwbmweE+WlB1Q9KxCuuQ5
	 Kzb1dvyQw6+gL+GIW2nFVO0sFF2z+rdCw0sBXSS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfFQTO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFQTO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:14:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9CB20863;
        Mon, 17 Jun 2019 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560798868;
        bh=96nDFxr5NSaDzK5hagsvc8sybepkdnbVQY2MD6PCZHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuJp1ARROzllwMHd05+fmqTqFCUPKYOoZC37pebYHIwbmg4cgcTD+J6qnx6t1NZX2
         Y6gXPV+JljLSi2UrS6HO7SXhMWKQyUWDHP/GthuRITRKL9WHGAWOvS4JzzNGi+lF/t
         8zk9afKqCqxTQ2vjj4PWDZBjfL2qucEhwphVm32A=
Date:   Mon, 17 Jun 2019 21:14:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 5.1.11
Message-ID: <20190617191425.GA27683@kroah.com>
References: <20190617180944.GA16975@kroah.com>
 <qe8n4h$649b$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qe8n4h$649b$1@blaine.gmane.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:45:36PM +0200, François Valenduc wrote:
> Le 17/06/19 à 20:09, Greg KH a écrit :
> > I'm announcing the release of the 5.1.11 kernel.
> > 
> > All users of the 5.1 kernel series must upgrade.
> > 
> > The updated 5.1.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.1.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> > 
> >  Documentation/networking/ip-sysctl.txt |    8 ++++++++
> >  Makefile                               |    2 +-
> >  include/linux/tcp.h                    |    4 ++++
> >  include/net/netns/ipv4.h               |    1 +
> >  include/net/tcp.h                      |    2 ++
> >  include/uapi/linux/snmp.h              |    1 +
> >  net/ipv4/proc.c                        |    1 +
> >  net/ipv4/sysctl_net_ipv4.c             |   11 +++++++++++
> >  net/ipv4/tcp.c                         |    1 +
> >  net/ipv4/tcp_input.c                   |   26 ++++++++++++++++++++------
> >  net/ipv4/tcp_ipv4.c                    |    1 +
> >  net/ipv4/tcp_output.c                  |   10 +++++++---
> >  net/ipv4/tcp_timer.c                   |    1 +
> >  13 files changed, 59 insertions(+), 10 deletions(-)
> > 
> > Eric Dumazet (4):
> >       tcp: limit payload size of sacked skbs
> >       tcp: tcp_fragment() should apply sane memory limits
> >       tcp: add tcp_min_snd_mss sysctl
> >       tcp: enforce tcp_min_snd_mss in tcp_mtu_probing()
> > 
> > Greg Kroah-Hartman (1):
> >       Linux 5.1.11
> > 
> 
> It seems a bit strange, it contains only 4 patches, and there was no
> review or I didn't find it. Is this some kind of urgent bugfix release ?

Yes, see:
	https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
for the details.

