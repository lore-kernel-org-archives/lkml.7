Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="cYoRvzBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfD2Qon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:44:43 -0400
Received: from mail.nic.cz ([217.31.204.67]:45632 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbfD2Qom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:44:42 -0400
Received: from localhost (unknown [172.20.6.125])
        by mail.nic.cz (Postfix) with ESMTPS id 2F920632B0;
        Mon, 29 Apr 2019 18:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1556556280; bh=KPqT55OC6AnnkshO0m7QOgkOsRziVHu4tEdrC34WjNg=;
        h=Date:From:To;
        b=cYoRvzBECmO98HTvZ6UYHzESlEw6QB4ej9NSnQ5rlJBo6vxNBey4RbX51r8jvbggk
         PUqXBiNYjtLsrtZSPRq9rXkSHz68OZYiuNe8itraRjiqFbwNspud73iabIgIYnvRZT
         hhgeNwWipXRS8Gz85BampV/y9IW5+6evbNuYxqiA=
Date:   Mon, 29 Apr 2019 18:44:39 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Subject: Re: linux-next: Tree for Apr 29 (drivers/leds/leds-turris-omnia)
Message-ID: <20190429184439.68049050@nic.cz>
In-Reply-To: <20190429163753.GA16782@amd>
References: <20190429190354.0d5e2e93@canb.auug.org.au>
        <d3822785-0683-28df-ffa6-ab679aa27c73@infradead.org>
        <20190429153200.GA11761@amd>
        <20190429173842.06f02852@nic.cz>
        <20190429163753.GA16782@amd>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 18:37:53 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2019-04-29 17:38:42, Marek Behun wrote:
> > I am sending patch only adding the I2C dep. Theoretically it is
> > possible that someone uses the same I2C API in their microcontroller on
> > another architecture.  
> 
> Theoretically. But we both now that probability of that is very low,
> and that likely driver would need other updates, too... right?
> 
> 								Pavel

What would be the benefit to add ARM dependency? So that distro
compilations don't ship the turris_omnia driver unnecesarily?
