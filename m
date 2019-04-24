Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F3B218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfDXIbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:31:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfDXIbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:31:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98C82124562;
        Wed, 24 Apr 2019 08:31:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94758600C4;
        Wed, 24 Apr 2019 08:31:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190423170445.GB21047@fuggles.cambridge.arm.com>
References: <20190423170445.GB21047@fuggles.cambridge.arm.com> <1555504525-17962-1-git-send-email-zhouby_cn@126.com> <20190418112818.GA31923@lakrids.cambridge.arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     dhowells@redhat.com, Mark Rutland <mark.rutland@arm.com>,
        Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com,
        haozhu@nudt.edu.cn, linux@dominikbrodowski.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH] The patch solves the type error  of the parameter
 =?utf-8?B?4oCcb2Zm4oCd?= in syscall mmap on the ARM64 platform.
MIME-Version: 1.0
Content-Type: text/plain
Date:   Wed, 24 Apr 2019 09:31:28 +0100
Message-ID: <28023.1556094688@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Apr 2019 08:31:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will.deacon@arm.com> wrote:

> -		unsigned long, fd, off_t, off)
> +		unsigned long, fd, off_t, pgoff)
>  {
> +	unsigned long off = pgoff;
> +

Would loff_t be better?

David
