Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A738C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B54B2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395250AbfIGUEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:04:38 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:48094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728494AbfIGUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:04:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 513CD180A68C3;
        Sat,  7 Sep 2019 20:04:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew81_626ed4401de14
X-Filterd-Recvd-Size: 1248
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 20:04:36 +0000 (UTC)
Message-ID: <529940f5dd3ca0426f8e953d232a16b4eccfbfb7.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     volery <sandro@volery.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Date:   Sat, 07 Sep 2019 13:04:35 -0700
In-Reply-To: <20190907090948.GA5824@volery>
References: <20190907090948.GA5824@volery>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 11:09 +0200, volery wrote:
> There were a lot of styling problems using space then tab or spaces
> instead of tabs in that file. Especially the entire function at line
> 2677.
> Also added a space before the : on line 2221.

You do not have an appropriate subject line.

This subject should probably be something like:

[PATCH] tty: tty_io: Use normal indentation

Please make changes only in drivers/staging until you are
really familiar with the linux kernel patch process.


