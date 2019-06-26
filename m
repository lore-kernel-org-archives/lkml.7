Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C94C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE4B2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfFZObm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:31:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C56F30832DE;
        Wed, 26 Jun 2019 14:31:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04FE15D717;
        Wed, 26 Jun 2019 14:31:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190626131902.6xat2ab65arc62td@brauner.io>
References: <20190626131902.6xat2ab65arc62td@brauner.io> <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk> <20190626100525.irdehd24jowz5f75@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query syscall [ver #14]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9359.1561559497.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jun 2019 15:31:37 +0100
Message-ID: <9360.1561559497@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 26 Jun 2019 14:31:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> And I also very much recommend to remove any potential cross-dependency
> between the fsinfo() and the notification patchset.

The problem with that is that to make the notification patchset useful for
mount notifications, you need some information that you would obtain through
fsinfo().

David
