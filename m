Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DCC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B27F2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfE1QW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE1QWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59DA2307D928;
        Tue, 28 May 2019 16:22:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74AA1001E6E;
        Tue, 28 May 2019 16:22:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com>
References: <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com> <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com> <11440.1559046181@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9329.1559060541.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 17:22:21 +0100
Message-ID: <9330.1559060541@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 28 May 2019 16:22:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > Also, should all of these be prefixed with "smack"?  So:
> >
> >   	fsparam_string("smackfsdef",	Opt_fsdefault),
> >   	fsparam_string("smackfsfloor",	Opt_fsfloor),
> >   	fsparam_string("smackfshat",	Opt_fshat),	
> 
> No. smack_fs_parameters takes care of that.

It does?  *Blink*.

smack_fs_parameters.name is just for decorating messages, if that's what
you're looking at.

David
