Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8482620B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr/Q7ZL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfJUP7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:59:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbfJUP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571673558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB3h1+rX6SwZqtoY3Kw85+CkKWUkDR1tjhYDoTIgQqI=;
        b=Yr/Q7ZL8MJAVMiFbIi8tp9ibze5U2B/hU0douP+WMf2A8OP1GFsJggyWojLWSuE84t1C1T
        cFZ+6VubAgOafi5tZVkOLsbzjDLsEWpJI/eTtwCRFVdpzoMNLcFJM2sGt27wobMBuyR7+D
        Dr78NMssfcAoevfbQxOXDn9Ada7w68I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ZRM1CcYIMe2Hn_ko3VmGjA-1; Mon, 21 Oct 2019 11:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CBA01005500;
        Mon, 21 Oct 2019 15:59:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD4756012E;
        Mon, 21 Oct 2019 15:59:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000830fe50595115344@google.com>
References: <000000000000830fe50595115344@google.com>
To:     syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: refcount bug in find_key_to_update
MIME-Version: 1.0
Content-ID: <8508.1571673553.1@warthog.procyon.org.uk>
Date:   Mon, 21 Oct 2019 16:59:13 +0100
Message-ID: <8509.1571673553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZRM1CcYIMe2Hn_ko3VmGjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:

> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11c8adab600=
000

How do I tell what's been passed into the add_key for the encrypted key?

David

