Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F8C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224921906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfI3RBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 13:01:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:49970 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfI3RA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 13:00:59 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5B149A9;
        Mon, 30 Sep 2019 17:00:58 +0000 (UTC)
Date:   Mon, 30 Sep 2019 11:00:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-can@vger.kernel.org, linux-afs@lists.infradead.org,
        kvm@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: use flexible array members, not zero-length
Message-ID: <20190930110057.1b11d798@lwn.net>
In-Reply-To: <20190928105557.221fb119@heffalump.sk2.org>
References: <20190927142927.27968-1-steve@sk2.org>
        <20190928011639.7c983e77@lwn.net>
        <20190928105557.221fb119@heffalump.sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 10:55:57 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Wouldn’t it be better to update the docs simultaneously in each patch which
> fixes a structure? Or is that unworkable with current development practices?

Definitely update the two together.  The doc fix should just go through
the appropriate maintainer with the code change.

Thanks,

jon
