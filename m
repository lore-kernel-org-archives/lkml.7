Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9189EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600BD20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552040812;
	bh=FaEa8cKqVZ2pAzlQB8gqIaWOw8/IL+LUxc0mV93hE+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ADYfkr1rteUfLVqou4AFlFt8u6xmsZ33TWcAw6qS3fKxsg1R6yMs/qXb/rq7LKeyA
	 yF3K8qXteNfDtmvn/z+ISQPuei5tfuboto2A4vFtdsu7rqilFDgCAK8v1uXM91mX2I
	 CGOm+bSXyaxMJMUaoYv3XmOj568Z3GW2iNheY6vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCHK0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCHK0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:26:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647FF2081B;
        Fri,  8 Mar 2019 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552040809;
        bh=FaEa8cKqVZ2pAzlQB8gqIaWOw8/IL+LUxc0mV93hE+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lG1puNtKVJuq6kyeiQpCLEkRwPHehoS/JzoILElxVzq98uAlod5aOo42I139IHOLE
         cWuNz+hL9P9UxFmTB9Lv6u3E5I1TVof6xRsbLsiIuPPxaKqwTHZ65ES+YA6vvqh1ic
         ugI3MztlWGUrRD1snyNgqAvAbmgUPiBYyl8C8oj4=
Date:   Fri, 8 Mar 2019 11:26:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     stable <stable@vger.kernel.org>, linux-tip-commits@vger.kernel.org,
        suravee.suthikulpanit@amd.com, jiaxun.yang@flygoat.com,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        sherry.hurwitz@amd.com, mingo@redhat.com, mingo@kernel.org,
        thomas.lendacky@amd.com, hpa@zytor.com,
        Erwan Velu <e.velu@criteo.com>
Subject: Re: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Message-ID: <20190308102647.GA19469@kroah.com>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
 <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
 <20190220085334.GA5177@zn.tnic>
 <20190221115230.GB25198@kroah.com>
 <20190221122523.GB12997@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221122523.GB12997@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:25:23PM +0100, Borislav Petkov wrote:
> On Thu, Feb 21, 2019 at 12:52:30PM +0100, Greg KH wrote:
> > I would, but I do not see this patch in Linus's tree yet :)
> 
> You will soon :)

I see it now, so it's now queued up, thanks.

greg k-h
