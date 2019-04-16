Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70920821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415274;
	bh=5kq96tturiTsx61T66hvtiYgunFkOa7cUvbhn9Dj7Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Trjc83uuy2VYplNdHd17TmNMfMrlTT+YX2LwktsgjED76w2U17jY+/OUHLVkLTnk4
	 mbib+I/bwOwVStqUxrvpDHKwvL85qXj+RFueHDstiRwd+OQ4cus3iGypAFznqTWHmg
	 8Hq1w382wh3juE2w/RL5lL9vBR1jRMjY47AAP7GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfDPLrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbfDPLrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D2520870;
        Tue, 16 Apr 2019 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415270;
        bh=5kq96tturiTsx61T66hvtiYgunFkOa7cUvbhn9Dj7Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crQw7J6SsUaIlLt4czNcxMpoxzyXXOlgZU9llTkSOt8rsuElGaF8nK49fW6I4G34D
         5ZUTSJFH4OwXp6mUefhSTfGiVrRmH1pc52NpRN2L7BEqjLs5K8dNpJnk1PV2WjiQMB
         5aghJzGkDUMj4qlnUGHx+mPOsEu659+C/kg+86sM=
Date:   Tue, 16 Apr 2019 13:20:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andre <andredainez@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org, realwakka@gmail.com,
        straube.linux@gmail.com, hle@owl.eu.com, rico.schrage@gmail.com,
        sophie.matter@web.de, Valentin.Vidic@carnet.hr, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Add parenthesis to Macro arguments
Message-ID: <20190416112029.GB9823@kroah.com>
References: <1554253445-28635-1-git-send-email-andredainez@gmail.com>
 <20190403042632.GA31130@kroah.com>
 <0d8cd5e0-71f0-6748-08a6-84c3477c874d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8cd5e0-71f0-6748-08a6-84c3477c874d@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:37:58PM -0300, Andre wrote:
> Hi Greg, thanks for replying.
> 
> On 03/04/2019 01:26, Greg KH wrote:
> > On Tue, Apr 02, 2019 at 10:04:05PM -0300, Andre Dainez wrote:
> >> Fix checkpatch errors:
> >>
> >> CHECK: Macro argument 'len' may be better as '(len)' to avoid precedence issues
> >> CHECK: Macro argument 'nlh' may be better as '(nlh)' to avoid precedence issues
> >>
> >> Signed-off-by: Andre Dainez <andredainez@gmail.com>
> >> ---
> >>  drivers/staging/gdm724x/netlink_k.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
> >> index 92440c3..36d88f4 100644
> >> --- a/drivers/staging/gdm724x/netlink_k.c
> >> +++ b/drivers/staging/gdm724x/netlink_k.c
> >> @@ -19,8 +19,8 @@ static DEFINE_MUTEX(netlink_mutex);
> >>  #define ND_NLMSG_SPACE(len)	(NLMSG_SPACE(len) + ND_IFINDEX_LEN)
> >>  #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
> >>  						  ND_IFINDEX_LEN))
> >> -#define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
> >> -#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
> >> +#define ND_NLMSG_S_LEN(len)	((len) + ND_IFINDEX_LEN)
> > 
> > This makes sense, but:
> > 
> >> +#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)
> > 
> > That does not, correct?
> > 
> Could you please clarify why this doesn't make sense?
> If, for some reason I calculate by hand the pointer address and call this macro like: 
> ND_NLMSG_R_LEN(nlh + sizeof(*nlh)), 
> then it would expand like nlh + sizeof(*nlh)->nlmsg_len - ND_IFINDEX_LEN
> which looks wrong in my pov, no?

Why would anyone ever do such a thing?  :)

That's the issue here, this is not needed as if someone were to want to
do something crazy like you are suggesting, it will properly blow up, so
no need to change anything here.

thanks,

greg k-h
