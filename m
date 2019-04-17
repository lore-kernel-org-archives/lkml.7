Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C8CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B120693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfDQWmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQWmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E61D3025495;
        Wed, 17 Apr 2019 22:42:54 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 322665C220;
        Wed, 17 Apr 2019 22:42:52 +0000 (UTC)
Date:   Thu, 18 Apr 2019 06:42:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 1/2] x86/mm/KASLR: Fix the size of the direct
 mapping section
Message-ID: <20190417224248.GF7065@MiWiFi-R3L-srv>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-2-bhe@redhat.com>
 <20190415185319.GI29317@zn.tnic>
 <20190417083536.GE7065@MiWiFi-R3L-srv>
 <20190417150122.GF20492@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417150122.GF20492@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Apr 2019 22:42:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/19 at 05:01pm, Borislav Petkov wrote:
> On Wed, Apr 17, 2019 at 04:35:36PM +0800, Baoquan He wrote:
> > I made a new one to add this fact, I can repost if it's OK to you.
> 
> No, it looks ok and I can take it from here.
> 
> Also, resending too often is annoying, as I'm sure you know. Try to
> stick to resending once a week.

OK, thanks.
