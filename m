Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFECFC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B9206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfD1NVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:21:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58374 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbfD1NVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 09:21:51 -0400
Received: from callcc.thunk.org (75-104-85-109.mobility.exede.net [75.104.85.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3SDLRqG015813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 09:21:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8DF54420023; Sun, 28 Apr 2019 09:21:26 -0400 (EDT)
Date:   Sun, 28 Apr 2019 09:21:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] unicode: fix dereference of a potentially null
 pointer
Message-ID: <20190428132126.GB24089@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190426222237.13209-1-colin.king@canonical.com>
 <CAK7LNATC5b9yx79sF55hw1X9vZTJK8H+WsLRfy81_chZYRgTYw@mail.gmail.com>
 <85ef5mcrze.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ef5mcrze.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 07:02:45AM -0400, Gabriel Krisman Bertazi wrote:
> > On Sat, Apr 27, 2019 at 7:22 AM Colin King <colin.king@canonical.com> wrote:
> >>
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The pointer 'tree' is deferenced when assigning pointer 'trie', however
> >> trie is being null checked a few lines later, so it could potentially
> >> be null. Fix the potential null pointer dereference by only dereferencing
> >> it after it has been null checked.
> >>
> >> Addresses-Coverity: ("Dereference before null check")
> >> Fixes: b08fcacaaaf4 ("unicode: introduce UTF-8 character database")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Ted, can you pick this up directly for now?

Ack, I've merged it into the the patch "unicode: introduce UTF-8
character database".

						- Ted
