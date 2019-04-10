Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEF5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40DC20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfDJJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfDJJ7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C25F7C05E767;
        Wed, 10 Apr 2019 09:59:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40ECF608EB;
        Wed, 10 Apr 2019 09:59:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190328074712.GQ2665@phenom.ffwll.local>
References: <20190328074712.GQ2665@phenom.ffwll.local> <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk> <155373013865.7602.4323790421889477990.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk, Daniel Vetter <daniel@ffwll.ch>
Cc:     dhowells@redhat.com, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/68] vfs: Convert drm to use the new mount API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <748.1554890391.1@warthog.procyon.org.uk>
Date:   Wed, 10 Apr 2019 10:59:51 +0100
Message-ID: <749.1554890391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 10 Apr 2019 09:59:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I wonder if it would be possible to extend anon_inodes to return just an
anonymous inode, thereby allowing the drm filesystem to be removed in favour
of just using an anon_inode.

David
