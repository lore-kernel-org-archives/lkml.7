Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E9C20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfJ2HOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:14:37 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:60072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbfJ2HOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:14:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 81C27181D341E;
        Tue, 29 Oct 2019 07:14:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rule99_27f311606342e
X-Filterd-Recvd-Size: 1467
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Oct 2019 07:14:34 +0000 (UTC)
Message-ID: <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com>
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
From:   Joe Perches <joe@perches.com>
To:     Frank Lee <tiny.windzz@gmail.com>, tytso@mit.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Oct 2019 00:14:27 -0700
In-Reply-To: <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
         <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 22:49 +0800, Frank Lee wrote:
> ping...

Ted?

Is there some reason this patch series was not applied?

https://lore.kernel.org/lkml/20190607182517.28266-1-tiny.windzz@gmail.com/
https://lore.kernel.org/lkml/20190607182517.28266-2-tiny.windzz@gmail.com/
https://lore.kernel.org/lkml/20190607182517.28266-3-tiny.windzz@gmail.com/
https://lore.kernel.org/lkml/20190607182517.28266-4-tiny.windzz@gmail.com/
https://lore.kernel.org/lkml/20190607182517.28266-5-tiny.windzz@gmail.com/

