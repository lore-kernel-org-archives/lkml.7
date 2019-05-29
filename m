Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075B92429F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE2Way (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:30:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:43864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2Way (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:30:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6ECC660C;
        Wed, 29 May 2019 22:30:53 +0000 (UTC)
Date:   Wed, 29 May 2019 16:30:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] docs: Convert VFS doc to RST
Message-ID: <20190529163052.6ce91581@lwn.net>
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 10:29:04 +1000
"Tobin C. Harding" <tobin@kernel.org> wrote:

> Here is an updated version of the VFS doc conversion.  This series in no
> way represents a final point for the VFS documentation rather it is a
> small step towards getting VFS docs updated.  This series does not
> update the content of vfs.txt, only does formatting.

I've finally gotten to this, sorry for taking so long.  Applying it to
docs-next turned out to be a bit of a chore; there have been intervening
changes to vfs.txt that we didn't want to lose.  But I did it.

Unfortunately, there's still a remaining issue.  You did a lot of list
conversions like this:

> -  struct file_system_type *fs_type: describes the filesystem, partly initialized
> +``struct file_system_type *fs_type``: describes the filesystem, partly initialized
>  	by the specific filesystem code

but that does not render the way you would like, trust me.  You really
want to use the list format, something like:

    ``struct file_system_type *fs_type``
	 describes the filesystem, partly initialized by the specific
	 filesystem code

There are, unfortunately, a lot of these to fix...  I bet it could be done
with an elisp function, but I don't have time to beat my head against that
wall right now.

Any chance you would have time to send me a followup patch fixing these
up?  I'll keep my branch with this set for now so there's no need to
rebase those.

Thanks,

jon
