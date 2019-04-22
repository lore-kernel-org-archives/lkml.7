Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990AFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662BA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDVJOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:14:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfDVJOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:14:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6FD0308FEDE;
        Mon, 22 Apr 2019 09:14:45 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 232D860139;
        Mon, 22 Apr 2019 09:14:44 +0000 (UTC)
Date:   Mon, 22 Apr 2019 17:14:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        keescook@chromium.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190422091442.GC3584@localhost.localdomain>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190422091045.GB3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422091045.GB3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 22 Apr 2019 09:14:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill, Kees,

On 04/22/19 at 05:10pm, Baoquan He wrote:
> kernel_randomize_memory() hardcodes the size of vmemmap section as 1 TB,
> to support the maximum amount of system RAM in 4-level paging mode, 64 TB.

Could you help review this one, and offer ack if it's OK to you?

Thanks
Baoquan
