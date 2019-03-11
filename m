Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BC2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552305330;
	bh=EKxwG/qfQQ9/W+NkA+tIC2TchJFLWz0TrfiUdjN5i/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DphGJGlYLPBVNfI0OYqHGEFBZBwsgCQKuk961NLdAPMHm07kkX5wb4qhxGshb6PhB
	 wXlXTq2UhT7Bnu00PsA0RDGrxiQuWXszpS3UmEF6FGWg51dlcR/6kLg+golW9byGAm
	 DOn115EWWVEOT2ae6KxLwBGW7voqr1bZEsJ7RBaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCKLz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfCKLz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:55:28 -0400
Received: from linux-8ccs (ip5f5ade5e.dynamic.kabel-deutschland.de [95.90.222.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96BCB206BA;
        Mon, 11 Mar 2019 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552305327;
        bh=EKxwG/qfQQ9/W+NkA+tIC2TchJFLWz0TrfiUdjN5i/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0cm+EiySYb1k8Y0kNmE4Aj19KE87EL7tUwnDOdRwV/2Lg3aFlL0+0wMvTSMM8sI/Q
         ZsA+zw0wAxTSrj5th0dYOIBZotpsFYu7hPjVOEpgyzykF8fd2gOYRbjabeX0jUQzml
         qTrzKgsmvAxHV/5w3baTCdev0uLlyL9vGs7IxLws=
Date:   Mon, 11 Mar 2019 12:55:23 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Mathias Krause <minipli@googlemail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Message-ID: <20190311115523.GA30951@linux-8ccs>
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
 <20190102202938.GA26600@linux-8ccs>
 <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
 <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mathias Krause [10/03/19 20:26 +0100]:
>Hi Jessica,
>
>On Mon, 21 Jan 2019 at 12:39, Mathias Krause <minipli@googlemail.com> wrote:
>>
>> On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
>> >
>> > +++ Mathias Krause [30/12/18 13:40 +0100]:
>> > >The reference to '__vermagic' is a relict from v2.5 times. And even
>> > >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
>> > >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
>> > >67ac5b866bda ("[PATCH] complete modinfo section")).
>> > >
>> > >Neither current kernels nor modules contain a '__vermagic' section any
>> > >more, so get rid of it.
>> > >
>> > >Signed-off-by: Mathias Krause <minipli@googlemail.com>
>> > >Cc: Rusty Russell <rusty@rustcorp.com.au>
>> > >Cc: Jessica Yu <jeyu@kernel.org>
>> >
>> > Thanks for the cleanup.
>> >
>> > Reviewed-by: Jessica Yu <jeyu@kernel.org>
>> >
>>
>> Arnd, will you carry this patch through your asm-generic tree or did
>> the MAINTAINERS file mislead me here?
>>
>
>looks like Arnd keeps ignoring my Emails. :/ Can you carry this patch
>through your module tree? Or do you think I should ask Andrew Morton
>instead?

Sure, I'll queue this up in modules-next shortly after the merge window.

Thanks,

Jessica
