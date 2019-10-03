Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021CEC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA23821A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570089733;
	bh=/FByIc2bVbyB9VJkoXnU41B0AmUP+XZ6UCyB+elJJrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DgzXR0cEKDa37gvKP9UDyCOXv9C06bAWkKJenFSzD5qHgjk6c8pwEWSiUdUGYutZd
	 1AtankPEKZxu7wV3/S8wKa0sQLmGFvzWiNbY984Syor4YbI9SKtbIatRaW0iSwKnc4
	 ZO7+TXKNyqMJe9axZYNWm/ML1LpfIsoo5PdQPCUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfJCICN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfJCICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:02:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C738921A4C;
        Thu,  3 Oct 2019 08:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570089731;
        bh=/FByIc2bVbyB9VJkoXnU41B0AmUP+XZ6UCyB+elJJrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlJz8ZATalEhL76gNCEqZjF+TM/e5TDOAj7X1MQn0EkoQys2G/wd7XqWSFle3nFxK
         V5g/lBDrWhrZDp0xbluVHFbSlBjOce6Bs0CHqVhiif9kD/jx59W3u/p0/kZ+74mL7g
         sfEIWVoHUB8g6JGx0CPjbkjL4KFCF4aR4NRaZ3tY=
Date:   Thu, 3 Oct 2019 10:02:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-5.3.y] Versions in stable.git and stable-rc.git
Message-ID: <20191003080208.GA1884816@kroah.com>
References: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
 <20191003074119.GA1815771@kroah.com>
 <CA+icZUWPkK8vsR_Wm6v=+davoFAaOsEay_siVj2BZjmnVioCjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWPkK8vsR_Wm6v=+davoFAaOsEay_siVj2BZjmnVioCjw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:49:27AM +0200, Sedat Dilek wrote:
> On Thu, Oct 3, 2019 at 9:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 03, 2019 at 09:38:27AM +0200, Sedat Dilek wrote:
> > > Hi Greg,
> > >
> > > I see two commits with "Linux 5.3.2" - in [1] it is tagged but there
> > > is a second one in [2] - both in stable.git.
> > >
> > > In stable-rc.git I see a commit "Linux 5.3.4-rc1" and there was no
> > > v5.3.3 released before.
> > >
> > > Can you look at this?
> >
> > Known issue, please see the announcement I made where I messed this all
> > up:
> >         https://lore.kernel.org/lkml/20191001070738.GC2893807@kroah.com/
> >
> > thanks,
> >
> 
> I have re-read this announcement but did not get it.
> Will there be a v5.3.3 or do you jump directly from v5.3.2 to v5.3.4?

I will jump to 5.3.4, there is no v5.3.3, sorry.

greg k
