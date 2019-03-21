Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66772C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9C2218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfCUP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbfCUP72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:59:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C0F21874;
        Thu, 21 Mar 2019 15:59:27 +0000 (UTC)
Date:   Thu, 21 Mar 2019 11:59:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] vfs: Convert tracefs to fs_context
Message-ID: <20190321115925.0ea8e964@gandalf.local.home>
In-Reply-To: <19901.1553183340@warthog.procyon.org.uk>
References: <20190321085836.3579c2b4@gandalf.local.home>
        <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
        <155316887777.29437.11898477863408246585.stgit@warthog.procyon.org.uk>
        <19901.1553183340@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 15:49:00 +0000
David Howells <dhowells@redhat.com> wrote:

> How about this:
> 
> """
> Convert tracefs to the new internal mount API as the old one will be
> obsoleted and removed.  This allows greater flexibility in communication of
> mount parameters between userspace, the VFS and the filesystem.
> 
> See Documentation/filesystems/mount_api.txt
> """

Better than none ;-)

> 
> I should update the subjects to say "Convert xxxfs to use the new mount
> API" too.
> 

Yep.

-- Steve
