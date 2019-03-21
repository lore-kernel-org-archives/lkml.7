Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA78DC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9247620828
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfCUPu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:50:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfCUPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25C373D3C;
        Thu, 21 Mar 2019 15:50:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6D31001E8E;
        Thu, 21 Mar 2019 15:50:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <19901.1553183340@warthog.procyon.org.uk>
References: <19901.1553183340@warthog.procyon.org.uk> <20190321085836.3579c2b4@gandalf.local.home> <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk> <155316887777.29437.11898477863408246585.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] vfs: Convert tracefs to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20003.1553183426.1@warthog.procyon.org.uk>
Date:   Thu, 21 Mar 2019 15:50:26 +0000
Message-ID: <20004.1553183426@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Mar 2019 15:50:28 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> See Documentation/filesystems/mount_api.txt

And that document is slightly out of date, so I'll need to post an update for
that too.

David
