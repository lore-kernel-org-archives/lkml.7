Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8C921473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558542869;
	bh=rjpTK0vqI8wpJEgJpF6flGa6KGkYMQF445ZImyoktIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptdGTpG5Oo8Ti4ZSaT2AXshWZ8mZHHN2pTdpSZPRCHfVWJIW34jU5a80Ay787dxTw
	 n5h0ySSSEATnrW+VoapoTkqkybUuPHfDG54Kvx0J7rILbvdbIg9NEd8+br+E6QuqOo
	 qx7lLszY8DisZ4lVfEA5kB6NZblG6CAsqef+wNWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfEVQe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfEVQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:34:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A938F2081C;
        Wed, 22 May 2019 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558542868;
        bh=rjpTK0vqI8wpJEgJpF6flGa6KGkYMQF445ZImyoktIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIpZoS8gYCYyT1fHZ4WPFGDCNapjX7tmsOAQH5cmhPAp0RAg3ZG7Ny4rfZ0fbPk0t
         MJVBk1AfPop7dJhGZjnWqsPSqySPFvwmuH3/hiSb0QG97e26Dqx6h4OYoQ5r0R81q3
         nqMsVDq5TfRuC3qVJrRhJBpcxIzb11zqPiuFu4AU=
Date:   Wed, 22 May 2019 18:34:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
Message-ID: <20190522163425.GA393@kroah.com>
References: <20190521133257.GA21471@kroah.com>
 <CAHk-=wiPy6ak8ERbRaPrkJ+n9iqVuNhH4t8YnbLXsM00K0fRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPy6ak8ERbRaPrkJ+n9iqVuNhH4t8YnbLXsM00K0fRPg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:56:54PM -0700, Linus Torvalds wrote:
> On Tue, May 21, 2019 at 6:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Thomas Gleixner (24):
> >       treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 1
> 
> I thought rule 1 was that we don't talk about SPDX replacement?

Oh if only that were the case, there's been too much talk, and not
enough action over the years.  Finally we are trying to fix that...

thanks for taking these,

greg k-h
