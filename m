Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E126C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539C12166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560965874;
	bh=FI/Aaanl67vGaL7CZBArwPQzwgfCA/zMq2im/eG81jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LttJoSxhbXkFxMAFd6ddx25vjXcPXoYVw2joHQJZ/GVpWWy4cXJROjp1z/FtQsjIR
	 mnAAB5N3ol2c2XT/HjRf0pGg5CMa4JDaaC0DkiICjRlgkXE7HuB7Ocp08qOgwLM5cS
	 owCJW0Wj4Q4rNOD+7GE6zOdZhYZ7D4FK84YSDshw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfFSRhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbfFSRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:37:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED25220645;
        Wed, 19 Jun 2019 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965871;
        bh=FI/Aaanl67vGaL7CZBArwPQzwgfCA/zMq2im/eG81jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjOlTvbXBJ8Q7188Pf6UHmQ6i3qmehkbMqf7qti7BktvzpIvamuZ8KJmvYB8sjW4B
         ic35saUA2nB2ol0AYoe1ccLop1CBme8rVqGtfJN120tzxq8pq4jYyDPOER+Ya1ARQe
         n/0jMhsWjkDHoXZn4dxxh248BSTmyjh2BXwGmXoM=
Date:   Wed, 19 Jun 2019 19:37:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 7/7] MAINTAINERS: Add an entry for generic
 architecture topology
Message-ID: <20190619173749.GA20916@kroah.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
 <20190617185920.29581-8-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617185920.29581-8-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:59:20AM -0700, Atish Patra wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> arm and arm64 shared lot of CPU topology related code. This was
> consolidated under driver/base/arch_topology.c by Juri. Now RISC-V
> is also started sharing the same code pulling more code from arm64
> into arch_topology.c
> 
> Since I was involved in the review from the beginning, I would like
> to assume maintenance for the same.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
