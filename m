Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF8C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4B421721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562003529;
	bh=nNSyRPMdKr1Xt5LJUtyg2hWBa5tpH1uBIMohn4cochs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZZ3H6SsrHxEbrGmhXt+FykPJmNKcfJ20up/wh7yVcUEhV37WMMlltwYv2/nG6vHk
	 Mc1odeJT526i9K9eHbZDOws+b+UwONmvDulPeGG0DpbAV7rYYCMWLZQuUXDZqLEBvx
	 36zQnqfrIK8Kar30tbBg0e5dfbeukpxcjalnRLFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfGARwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfGARwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:52:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1ED206A3;
        Mon,  1 Jul 2019 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562003527;
        bh=nNSyRPMdKr1Xt5LJUtyg2hWBa5tpH1uBIMohn4cochs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJHLs6b4F6hsTNGOCKkk71L5nyboDvnpHQMWGQ1C0DKO5R8fFnz70k/8cPkLjnJjd
         Lh1Cv72+Gd/SSeE0kK4vFQtRw9LyKZ+/kgnwPTIOQGuJFAVYrBi4oY5pW79jOp7/zB
         IUgDKuaIT29u5WEuZYZz/3x77GXi0tDp969Mhmdc=
Date:   Mon, 1 Jul 2019 19:52:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Josh Elsasser <jelsasser@appneta.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: net: check before dereferencing netdev_ops during busy poll
Message-ID: <20190701175204.GA9081@kroah.com>
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 06:34:58PM +0200, Matteo Croce wrote:
> Hi,
> 
> Is there any reason for this panic fix not being applied in stable?
> 
> https://lore.kernel.org/netdev/20180313053248.13654-1-jelsasser@appneta.com/T/

I can't apply patches from random urls :)

