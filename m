Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C907B206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfE1PRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1PQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:16:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 676DE64394;
        Tue, 28 May 2019 15:16:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28DA511483C1;
        Tue, 28 May 2019 15:16:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
References: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 0/7] VFS: Introduce filesystem information query syscall [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3128.1559056615.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 16:16:55 +0100
Message-ID: <3129.1559056615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 28 May 2019 15:16:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I posted this on the wrong branch - will repost on the right branch.

David
