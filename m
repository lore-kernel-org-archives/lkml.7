Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF05C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC92206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfKFIBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:01:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729878AbfKFIBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:01:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05EFFAFBB;
        Wed,  6 Nov 2019 08:01:04 +0000 (UTC)
Message-ID: <1573026302.3090.2.camel@suse.com>
Subject: Re: [PATCH 4.9 37/62] UAS: Revert commit 3ae62a42090f ("UAS: fix
 alignment of scatter/gather segments")
From:   Oliver Neukum <oneukum@suse.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>
Date:   Wed, 06 Nov 2019 08:45:02 +0100
In-Reply-To: <20191106001102.GI4787@sasha-vm>
References: <20191104211901.387893698@linuxfoundation.org>
         <20191104211940.713506931@linuxfoundation.org>
         <1572964268.2921.19.camel@suse.com> <20191106001102.GI4787@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.11.2019, 19:11 -0500 schrieb Sasha Levin:
> On Tue, Nov 05, 2019 at 03:31:08PM +0100, Oliver Neukum wrote:
> > Am Montag, den 04.11.2019, 22:44 +0100 schrieb Greg Kroah-Hartman:
> > >         All the host controllers capable of SuperSpeed operation can
> > >         handle fully general SG;
> > > 
> > >         Since commit ea44d190764b ("usbip: Implement SG support to
> > >         vhci-hcd and stub driver") was merged, the USB/IP driver can
> > >         also handle SG.
> > 
> > Not in 4.9.x. AFAICT the same story as 4.4.x
> > The patch is not strictly needed, but breaks UAS over usbip.
> 
> It's in 4.9 since April this year... Same story for 4.4.

Hi,

now I am confused. Neither looking at the logs nor the source
I can see the commit. Top commit is
9e48f0c28dd505e39bd136ec92a042b311b127c6
of git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

I am sorry for being obnoxious here and it is entirely possible that
I am stupid, but this is a discrepancy that needs to be resolved.

	Regards
		Oliver

