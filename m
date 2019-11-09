Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13451C17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3B214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfKIAzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:55:15 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:33453 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfKIAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:55:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1D52A182CED2A;
        Sat,  9 Nov 2019 00:55:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: woman68_84de4be6cd92a
X-Filterd-Recvd-Size: 1721
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Nov 2019 00:55:12 +0000 (UTC)
Message-ID: <c6c9bd718c4cbee34b13a0b2c9dfefeee00bada5.camel@perches.com>
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
From:   Joe Perches <joe@perches.com>
To:     Frank Lee <tiny.windzz@gmail.com>, tytso@mit.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Nov 2019 16:54:59 -0800
In-Reply-To: <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
         <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
         <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 00:14 -0700, Joe Perches wrote:
> On Thu, 2019-07-11 at 22:49 +0800, Frank Lee wrote:
> > ping...
> 
> Ted?
> 
> Is there some reason this patch series was not applied?
> 
> https://lore.kernel.org/lkml/20190607182517.28266-1-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-2-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-3-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-4-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-5-tiny.windzz@gmail.com/

Ted?

Do you object to this series going into the tree at all?
If not, do you want someone else to pick it up?


