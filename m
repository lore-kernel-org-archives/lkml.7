Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D8FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7E121855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbfI3ONM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:13:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:49308 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbfI3ONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:13:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0AEDA740;
        Mon, 30 Sep 2019 14:13:11 +0000 (UTC)
Date:   Mon, 30 Sep 2019 08:13:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove dead mutt url and add active mutt url
Message-ID: <20190930081310.7e3b9c52@lwn.net>
In-Reply-To: <20190928151300.GA18122@debian>
References: <20190928151300.GA18122@debian>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 20:43:03 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> The following changes since commit 4e4327891fe2a2a4db342985bff4d4c48703c707:
> 
>   replace dead mutt url with active one. (2019-09-28 20:11:00 +0530)
> 
>   are available in the Git repository at:

Bhaskar, I'm not going to take a pull request for a change like this.  If
you would like to make this change (and it seems like a useful change to
make), please send me a patch that is:

 - based on docs-next
 - properly changelogged
 - demonstrated to build properly with sphinx

Thanks,

jon
