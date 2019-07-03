Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E514A218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGCN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfGCN5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52962F8BCB;
        Wed,  3 Jul 2019 13:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAF0883CD7;
        Wed,  3 Jul 2019 13:57:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190703025518.6379-1-yuehaibing@huawei.com>
References: <20190703025518.6379-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kairui Song <kasong@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Eric Biggers" <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] integrity: Remove set but not used variable 'acl'
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15690.1562162261.1@warthog.procyon.org.uk>
Date:   Wed, 03 Jul 2019 14:57:41 +0100
Message-ID: <15691.1562162261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 03 Jul 2019 13:57:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/integrity/digsig.c: In function 'integrity_init_keyring':
> security/integrity/digsig.c:99:18: warning:
>  variable 'acl' set but not used [-Wunused-but-set-variable]
> 
> It seems 'acl' is needed in __integrity_init_keyring

I've folded this fix in, thanks.

David
