Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25210C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DF920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfFFPqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:46:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:50162 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfFFPqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:46:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0CCF9737;
        Thu,  6 Jun 2019 15:46:30 +0000 (UTC)
Date:   Thu, 6 Jun 2019 09:46:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: Render method descriptions
Message-ID: <20190606094628.0e8775f7@lwn.net>
In-Reply-To: <20190604002656.30925-1-tobin@kernel.org>
References: <20190604002656.30925-1-tobin@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Jun 2019 10:26:56 +1000
"Tobin C. Harding" <tobin@kernel.org> wrote:

> Currently vfs.rst does not render well into HTML the method descriptions
> for VFS data structures.  We can improve the HTML output by putting the
> description string on a new line following the method name.
> 
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Jon,
> 
> As discussed on LKML; this patch applies on top of the series
> 
> 	[PATCH v4 0/9] docs: Convert VFS doc to RST
> 
> If it does not apply cleanly to your branch please feel free to ask me
> to fix it.

There was one merge conflict, but nothing too serious.  I've applied it,
and things look a lot better - thanks!

jon
