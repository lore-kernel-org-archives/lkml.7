Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C99C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E902206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDAVkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:40:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:40762 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDAVkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:40:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 640B92C4;
        Mon,  1 Apr 2019 21:40:04 +0000 (UTC)
Date:   Mon, 1 Apr 2019 15:40:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: soundwire: Ensure that code is inside
 the code blocks
Message-ID: <20190401154003.7eddc9e9@lwn.net>
In-Reply-To: <20190331223423.29855-1-j.neuschaefer@gmx.net>
References: <20190331223423.29855-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 00:34:22 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> The way the document is written now, Sphinx renders empty code blocks
> followed by the lines that should be inside them.
> 
> Unindent the code-block directives to fix this.
> 
> Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup warnings")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

That definitely makes things better.  Applied, thanks.

I'm going to take out the Fixes tag, though, since the named commit did
not, in fact, introduce that problem.  It's also good to copy authors of
patches named in Fixes tags so they can defend themselves :)

Thanks,

jon
