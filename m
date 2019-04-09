Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2107C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BE42084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDIJey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfDIJey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E9EA10C6E;
        Tue,  9 Apr 2019 09:34:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF1E21001E71;
        Tue,  9 Apr 2019 09:34:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190110220245.GA20942@embeddedor>
References: <20190110220245.GA20942@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] afs: Mark expected switch fall-throughs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2694.1554802492.1@warthog.procyon.org.uk>
Date:   Tue, 09 Apr 2019 10:34:52 +0100
Message-ID: <2695.1554802492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 09 Apr 2019 09:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:

Please fix the compiler so that you can annotate a switch-statement to say
that every case must fall through (except, perhaps, the last).

>  		/* extract the FID array and its count in two steps */
> +		/* fall through */
>  	case 1:

Capitialise "Fall" for consistency, please, and can you put the fall-through
marker *before* the comment introducing the case please?  It belongs to the
preceding section.

>  		/* extract the callback array and its count in two steps */
> +		/* fall through */
>  	case 3:

Ditto.

>  		/* extract the FID array and its count in two steps */
> +		/* Fall through */

Ditto on putting the fall-through before the introductory comment.

(And more dittos).

> -		/* Extract fsEndpoints[] entries */
> +		/* Fall through - and extract fsEndpoints[] entries */

And here you're doing something different yet again, though you could drop
either the "-" or the "and".

David
