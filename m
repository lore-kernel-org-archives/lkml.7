Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC122146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCTHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43EF988ABD;
        Wed, 20 Mar 2019 07:42:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDB625D788;
        Wed, 20 Mar 2019 07:42:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87o966uj6z.fsf@linux.intel.com>
References: <87o966uj6z.fsf@linux.intel.com> <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk> <155257998686.13720.8551460564620091523.stgit@warthog.procyon.org.uk>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/38] vfs: Convert gadgetfs to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27310.1553067744.1@warthog.procyon.org.uk>
Date:   Wed, 20 Mar 2019 07:42:24 +0000
Message-ID: <27311.1553067744@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 20 Mar 2019 07:42:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Balbi <balbi@kernel.org> wrote:

> looks like a mostly mechanical change. Do you want this to go through
> the USB tree or FS tree?

I'm going to try and get all of these to go through the Al's vfs tree since
there are dependent cleanup patches that remove code that's then obsolete.

> Also, do you mind doing the same for drivers/usb/gadget/function/f_fs.c?

Sure.  The reason I hadn't already done it is that it doesn't look entirely
trivial.

David
