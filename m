Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59808C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2549420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfDJJyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDJJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C4A59091F;
        Wed, 10 Apr 2019 09:54:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC239104C425;
        Wed, 10 Apr 2019 09:54:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com>
References: <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com> <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk> <155373004377.7602.1209303093988055088.stgit@warthog.procyon.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Schwab <schwab@suse.de>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 01/68] kbuild: skip sub-make for in-tree build with GNU Make 4.x
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32423.1554890092.1@warthog.procyon.org.uk>
Date:   Wed, 10 Apr 2019 10:54:52 +0100
Message-ID: <32424.1554890092@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 10 Apr 2019 09:54:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Why should this patch be included in a
> totally unrelated patch series?

Sorry, I forgot to exclude it.  It's in all my branches that I've touched
since upstream got broken.  I've now rebased and it's gone from this branch.

David
