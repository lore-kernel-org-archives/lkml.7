Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A6C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA20F214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfDYLCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDYLCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C1D230882A4;
        Thu, 25 Apr 2019 11:02:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96902600C5;
        Thu, 25 Apr 2019 11:02:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com>
References: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk> <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
To:     Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc:     dhowells@redhat.com, ebiederm@xmission.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Subject: Re: [PATCH 05/11] keys: Add a 'recurse' flag for keyring searches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20947.1556190162.1@warthog.procyon.org.uk>
Date:   Thu, 25 Apr 2019 12:02:42 +0100
Message-ID: <20948.1556190162@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 25 Apr 2019 11:02:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Zaborowski <andrew.zaborowski@intel.com> wrote:

> >  extern key_ref_t keyring_search(key_ref_t keyring,
> >                                 struct key_type *type,
> > -                               const char *description);
> > +                               const char *description,
> > +                               bool no_recurse);
> 
> No functional difference but it's "recurse" everywhere else.

Fixed, thanks.

David
