Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A8C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938C8218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfDXPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfDXPWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:22:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BC5330B49ED;
        Wed, 24 Apr 2019 15:22:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB3E5D704;
        Wed, 24 Apr 2019 15:22:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <CAJfpegvowwePJHEMRkaabx-NxLoJ5f8_QziPFyQUui+bmAaT1w@mail.gmail.com>
References: <CAJfpegvowwePJHEMRkaabx-NxLoJ5f8_QziPFyQUui+bmAaT1w@mail.gmail.com> <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk> <155373036414.7602.7964458548629410897.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 44/68] vfs: Convert fuse to use the new mount API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3077.1556119203.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 24 Apr 2019 16:22:03 +0100
Message-ID: <3217.1556119323@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 15:22:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Should I be applying this, together with the vfs dependencies?  Or
> will you take care of these?

I'm hoping Al will take the entire series.

> One minor comment is that fuse conventionally uses "struct fuse_conn
> *fc", so "struct fs_context *fc" is confusing here.  There's one place
> you use "struct fs_context *fsc", which seems the right thing to do
> for all the cases.

Except in ceph, where "struct ceph_fs_client *fsc" is a common thing...

David
