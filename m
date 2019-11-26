Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A18C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52192084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKZVhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:37:11 -0500
Received: from ms.lwn.net ([45.79.88.28]:37048 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKZVhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:37:10 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3A9F2E7;
        Tue, 26 Nov 2019 21:37:09 +0000 (UTC)
Date:   Tue, 26 Nov 2019 14:37:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: docs: device-mapper: Add dm-clone to documentation index
Message-ID: <20191126143708.1921e442@lwn.net>
In-Reply-To: <20191126201613.GA3750@redhat.com>
References: <20191126185627.970-1-geert+renesas@glider.be>
        <20191126201613.GA3750@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 15:16:13 -0500
Mike Snitzer <snitzer@redhat.com> wrote:

> I already staged this for 5.5 here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.5&id=484e0d2b11e1fdd0d17702b282eb2ed56148385f
> 
> But I don't plan to send to Linus for a week or 2...
> 
> If Jon and/or someone else would like to send it along before then
> that'd be fine with me.

It seems like things are well in hand to me, no need to do anything else.

Thanks,

jon
