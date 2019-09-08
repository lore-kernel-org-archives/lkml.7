Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430CC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A8F214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfIHXdE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 19:33:04 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:57788 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731203AbfIHXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:33:03 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i76fw-000DCZ-PC; Mon, 09 Sep 2019 01:32:56 +0200
Received: from [213.55.221.83] (helo=[100.83.17.111])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i76fw-000CGI-Jm; Mon, 09 Sep 2019 01:32:56 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 9 Sep 2019 01:32:54 +0200
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Message-Id: <6FA8CE55-211A-43C2-A929-A2CBC74CA9D1@volery.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 8 Sep 2019, at 22:59, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 

Hi Ted,

Thank you, for elaborating all this to me! I will try to limit my patches to the staging tree, until I feel confident enough to tackle a real coding issue in the kernel. 

Thanks,
Sandro V



