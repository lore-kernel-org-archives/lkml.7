Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E9C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B227216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562222507;
	bh=ZgOT5gnAWwt7R1SX532sifxgSNbKcfH6YLHcs//T4c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWP5xnklE2y5tfSOiiPNjcfC0GoZYj5Xhjis/6io04Fd3Zn33Vvu8b4w+GhLH1s1A
	 ec/k9HDlKcA8MSSH2rzyXSVYTWgiy+zcY6yaDmfbNpV3WXoP5tYaAMmY2Zb0hjvZv3
	 p6wvHDxIXunmotQX+DghrEEdSV0lFKUQrrolTJS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGDGlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfGDGlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:41:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214E7216E3;
        Thu,  4 Jul 2019 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562222504;
        bh=ZgOT5gnAWwt7R1SX532sifxgSNbKcfH6YLHcs//T4c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTPf+coXqs6xVLJi9AbzaiSFs2r1xpRl0ZpWGsCo2SNdvWJofn9AunZzmUegtfuHM
         3yJ1+Mf/MwB3SbxkP2LMQtYSSiGsx+XOAu9+HN2lHqJEu4Y7TzS0FIql0SK2hD26MC
         pvUMSR9ENrD0O+TNDXc8GqKorJ/s0gHQQAnOjf48=
Date:   Thu, 4 Jul 2019 08:41:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.3
Message-ID: <20190704064141.GA1289@kroah.com>
References: <20190704062259.GA1094@ogabbay-VM>
 <20190704064010.GA11575@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704064010.GA11575@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:40:10AM +0200, Greg KH wrote:
> On Thu, Jul 04, 2019 at 09:22:59AM +0300, Oded Gabbay wrote:
> > Hello Greg,
> > 
> > This is the pull request for habanalabs driver for kernel 5.3.
> > 
> > It mostly contains improvements to the existing code base. Nothing too
> > exciting this time.
> > 
> > Please see the tag message for details on what this pull request contains.
> > 
> > Thanks,
> > Oded
> > 
> > The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:
> > 
> >   ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04
> 
> Pulled and pushed out, thanks.

Oops, no, I got the following errors from my scripts when trying to
push:

Commit a8330ecebaee2703042b95b5437511c5b2876819
        committer SOB missing
        dbenzoor@habana.ai oded.gabbay@gmail.com
        Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Commit 5a0b645318fd96d2d9c65f9b39ef07562c83a494
        committer SOB missing
        dbenzoor@habana.ai oded.gabbay@gmail.com
        Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Commit 4a0fedfc20422d83edd874040a6a965cd55d27d5
        committer SOB missing
        dbenzoor@habana.ai oded.gabbay@gmail.com
        Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>

You "reviewed" these, but as you committed the patch, you also need to
sign off on them.

Can you fix up the tree and resend?

thanks,

greg k-h
