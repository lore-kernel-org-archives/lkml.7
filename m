Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0191C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8A1206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmI8FOkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfKQQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 11:59:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26270 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbfKQQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574009943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E72ZrVSS3vygVMm8IAKL6pChQMj9BcYC7SJtaQNwxSg=;
        b=WmI8FOkYSHb1tuXEJ9gW3jNpvMBbFbsKiAGEE31KNYbwoK6DaxHRq6emaNCCqra+Q3LgxY
        Tn+BAsZc/82Nd5ONpuqlV5EyteNnxHDoMFo8PSKYWT3W4JmFbBdiLzX82aUg6YICg8Zm/c
        x3P1I/flZlgPBcEwrrAPnz/dKnMSIiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-gTR7JPoyN3G6kH5bUY96Yw-1; Sun, 17 Nov 2019 11:59:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BFD1005500;
        Sun, 17 Nov 2019 16:58:58 +0000 (UTC)
Received: from localhost (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E755100EBBB;
        Sun, 17 Nov 2019 16:58:56 +0000 (UTC)
Date:   Sun, 17 Nov 2019 16:58:55 +0000
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, Wouter Verhelst <w@uter.be>,
        nbd@other.debian.org
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20191117165855.GD16477@redhat.com>
References: <20190215191953.GB17897@amd>
 <20190215224126.GX12500@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190215224126.GX12500@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gTR7JPoyN3G6kH5bUY96Yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW to follow up to this old thread, I made the change in nbdkit:

https://github.com/libguestfs/nbdkit/commit/acc37af9989aae708e8acad3535e149=
1931e6bdb

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

