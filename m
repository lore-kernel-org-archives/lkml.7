Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B8121835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406149AbfIGRfr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:35:47 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:52233 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405317AbfIGRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:35:47 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6eci-0002eP-71; Sat, 07 Sep 2019 19:35:44 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6eci-0006W0-1q; Sat, 07 Sep 2019 19:35:44 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 7 Sep 2019 19:35:42 +0200
Message-Id: <B45E122D-2B8B-43DA-8658-889E30CB2F0F@volery.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
References: <20190907172944.GB18166@kroah.com>
In-Reply-To: <20190907172944.GB18166@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        jslaby@suse.com
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
>> ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
>> Dear Greg,
>> I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
> 
> <snip>
> 
> For some reason you sent this only to me, which is a bit rude to
> everyone else on the mailing list.  I'll be glad to respond if you
> resend it to everyone.

I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)

I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?

Sincerely,
Sandro V
