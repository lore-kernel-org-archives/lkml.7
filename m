Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D2C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DE7217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbfKETNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:13:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:44004 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390526AbfKETNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:13:46 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 368496EC;
        Tue,  5 Nov 2019 19:13:46 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:13:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Will Deacon <will@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the arm-perf
 tree
Message-ID: <20191105121345.445a3438@lwn.net>
In-Reply-To: <20191105181137.GB32767@willie-the-truck>
References: <20191105113726.2a6e3317@canb.auug.org.au>
        <20191105181137.GB32767@willie-the-truck>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 18:11:38 +0000
Will Deacon <will@kernel.org> wrote:

> Looks fine to me, thanks. Jon -- are you ok living with this conflict?

Just another day in the life of the docs tree...:)  No worries here.
Thanks, Stephen.

jon
