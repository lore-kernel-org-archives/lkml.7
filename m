Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1450C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 00:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18CC2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 00:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfLAAOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 19:14:30 -0500
Received: from ms.lwn.net ([45.79.88.28]:36082 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfLAAOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 19:14:30 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7962230D;
        Sun,  1 Dec 2019 00:14:29 +0000 (UTC)
Date:   Sat, 30 Nov 2019 17:14:28 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Subject: Re: [PULL] Documentation for 5.5
Message-ID: <20191130171428.6c09f892@lwn.net>
In-Reply-To: <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
References: <20191126093002.06ece6dd@lwn.net>
        <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2019 15:11:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> There are DOS line-endings now in some of the  patches, and I noticed
> because I got a conflict in
> 
>   Documentation/networking/device_drivers/intel/e100.rst
> 
> where your version was identical to one I had merged elsewhere, but
> had ^M at the end of the new lines.
> 
> There are other examples of the same in other places.
> 
> I'm not going to pull this. I have no idea what you're doing and how
> many incorrect line endings you have that just didn't happen to
> conflict.
> 
> You have some *serious* tooling issues. We don't do CRLF line endings.

Hmm.

So my tooling is "git am", nothing special.

All of the afflicted files arrived in that state as the result of a pair
of patches from Jonathan (copied); I have verified that the original
patches also had the DOS line endings.

The problem repeats if I apply those patches now, even if I add an
explicit "--no-keep-cr" to the "git am" command line.  It seems like maybe
my version of git is somehow broken?  I have git-2.21.0-1.fc30.x86_64,
FWIW.

Anyway, if I revert the two offending patches and resend the pull, is that
good enough, or do you want this mess out of the history entirely?

Sorry for the trouble,

jon
