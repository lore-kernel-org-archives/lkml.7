Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E28C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5D20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfENSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:16:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:45440 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfENSQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:16:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC621308;
        Tue, 14 May 2019 18:16:24 +0000 (UTC)
Date:   Tue, 14 May 2019 12:16:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for
 KUnit
Message-ID: <20190514121623.0314bf07@lwn.net>
In-Reply-To: <20190514180810.GA109557@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
        <20190514054251.186196-16-brendanhiggins@google.com>
        <20190514073422.4287267c@lwn.net>
        <20190514180810.GA109557@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 11:08:10 -0700
Brendan Higgins <brendanhiggins@google.com> wrote:

> > Naturally, though, I have one request: I'd rather not see this at the top
> > level, which is more than crowded enough as it is.  Can this material
> > please go into the development tools book, alongside the kselftest
> > documentation?  
> 
> Oh yeah, that seems like the obvious home for this in hindsight. Sorry
> about that. Will fix in next revision!

No need to apologize - I have to say the same thing to everybody :)

Thanks,

jon
