Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E620863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfCYQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:56:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3556F2D7E6;
        Mon, 25 Mar 2019 16:56:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3D71001E70;
        Mon, 25 Mar 2019 16:56:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
References: <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com> <20190325162052.28987-1-christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, khlebnikov@yandex-team.ru,
        Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/4] pid: add pidctl()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18682.1553532974.1@warthog.procyon.org.uk>
Date:   Mon, 25 Mar 2019 16:56:14 +0000
Message-ID: <18683.1553532974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 25 Mar 2019 16:56:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Colascione <dancol@google.com> wrote:

> System calls are cheap.

Only to a point.  x86_64 will have an issue when we hit syscall 512.  We're
currently at 427.

David
