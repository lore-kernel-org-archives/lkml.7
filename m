Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E2520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCDIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfCDIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:52:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4908308FB9D;
        Mon,  4 Mar 2019 08:52:14 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C83106013A;
        Mon,  4 Mar 2019 08:52:13 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:52:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190304085210.GY14858@MiWiFi-R3L-srv>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
 <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
 <20190228100419.GS14858@MiWiFi-R3L-srv>
 <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
 <20190301144502.GV14858@MiWiFi-R3L-srv>
 <20190304081529.nuneutcjhoa56fw7@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304081529.nuneutcjhoa56fw7@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 04 Mar 2019 08:52:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/19 at 11:15am, Kirill A. Shutemov wrote:
> On Fri, Mar 01, 2019 at 10:45:02PM +0800, Baoquan He wrote:
> > Hi Kirill,
> > 
> > I updated patch per your comments. While I kept the 'paddr' variable and
> > the '0' initilization stuffs. My thought is there are two kinds of mapping
> > in the handling, so keeping these names from old codes can make it more
> > understandable. What do you think?
> > 
> > Kind               Physical address            Virtual address
> > ----------------------------------------------------------------
> > Direct mapping     paddr                vaddr = paddr+PAGE_OFFSET
> > 1:1 mapping        paddr                    paddr
> 
> I agree with your logic and patch looks good to me. But maybe you should
> exmplain this in the comments too?

OK, will add this into code comment, and sent a v3 patchset to wrap all
these changes according to your suggestions. Thanks a lot.

Thanks
Baoquan

