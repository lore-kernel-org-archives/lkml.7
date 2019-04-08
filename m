Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55964C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A39820879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Zbc+c/tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDHBXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:23:35 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5252 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHBXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:23:34 -0400
X-AuditID: 0a650161-78bff700000078a3-78-5caaa28bd427
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 22.E3.30883.B82AAAC5; Mon,  8 Apr 2019 09:23:23 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554686603; h=from:subject:to:date:message-id;
        bh=Ux048TmV854h+e950bXokICm1VWZROCck0ccAamUXr0=;
        b=Zbc+c/tjn6VUUGy7gHT+rvKNJnbSpGkvqNlxx5CXMucMs21p//6rIXdkO+/THtZae3SDSXz+hZM
        AloXWfy1olhnocsuAnEPf1MhRrZfCCkRpesAd+0Fl6WMgQfap04teimdi94j/nLFVieD0OgWKFIqA
        lCZ/bjkmFE2Rm3TjdhQ=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 8 Apr 2019 09:23:23 +0800
Date:   Mon, 8 Apr 2019 09:23:21 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/gup.c: fix the wrong comments
Message-ID: <20190408012320.GA11988@hsj-Precision-5520>
References: <20190404072347.3440-1-sjhuang@iluvatar.ai>
 <20190404165046.GB1857@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190404165046.GB1857@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXClcqYptu9aFWMQesJDYs569ewWex/+pzF
        4vKuOWwW99b8Z7XYuvcquwOrR+ONG2wei/e8ZPLY9GkSu8eJGb9ZPD5vkgtgjeKySUnNySxL
        LdK3S+DK+HaMrWAHR8XO1sUsDYxn2LoYOTgkBEwkjk7i72Lk4hASOMEosX9XP2MXIycHs4CO
        xILdn8BqmAWkJZb/4wCpYRF4yyTxfPELZoiGb4wSy6Z/ZAdpYBFQkVi29zqYzSagITH3xF1m
        EFtEQFni9L+rbBBD8yUe3ZvNDDJUWMBU4s/GDBCTV8Bc4uhGf5AKIYFsidWXPoB18goISpyc
        +YQFxOYUsJN483ED2GmiQBMPbDvOBNIqJKAg8WKlFkhYQkBJYsneWUwQdqHEjIkrGCcwCs9C
        8swshGdmIVmwgJF5FSN/cW66XmZOaVliSWKRXmLmJkZIDCTuYLzR+VLvEKMAB6MSD++N7FUx
        QqyJZcWVuYcYJTiYlUR4d04FCvGmJFZWpRblxxeV5qQWH2KU5mBREuctm2gSIySQnliSmp2a
        WpBaBJNl4uCUamCaOV3o6p1NBisO9qzcL1O4fstiTe1vL1xUFTd83KEi0b6i7IpZ9pIXjBW+
        5+S/HX1jejbrrpf0bNaLNW9d/tk+vXsnc5XWnQyRLWJFN7deZzsheaS72f60XcXT4g9+9Tvt
        O6dvc7Bcv2PGrFOfjx2zTp//zdNngYvC0g3ZXlV/24LTBV3VlX6wf7ueeXDBL5t/J/ieyEgf
        3cTe4lPQfWZi11nlojVlx+u4P7fvZvDauPHkhnkVT5q/c0pGVAb+XDj/UKld4IfKayc+bpe9
        uNGvqUHD+aZ1T8JJCY6pa55N4d22y9+Zg3VWn/15cevgeboMDs/Xnvr06P0TwS3S/DqurWls
        G086WpiX2RpJyLtOUWIpzkg01GIuKk4EALCAxvD+AgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:50:47AM -0700, Ira Weiny wrote:
> On Thu, Apr 04, 2019 at 03:23:47PM +0800, Huang Shijie wrote:
> > When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
> > get_user_pages_fast().
> > 
> > In the following scenario, we will may meet the bug in the DMA case:
> > 	    .....................
> > 	    get_user_pages_fast(start,,, pages);
> > 	        ......
> > 	    sg_alloc_table_from_pages(, pages, ...);
> > 	    .....................
> > 
> > The root cause is that sg_alloc_table_from_pages() requires the
> > page order to keep the same as it used in the user space, but
> > get_user_pages_fast() will mess it up.
> 
> I wonder if there is something we can do to change sg_alloc_table_from_pages()
> to work?  Reading the comment for it there is no indication of this limitation.
The sg_alloc_table_from_pages() cannot work if the page order is wrong...

> So should we update that comment as well?
Okay.

I will create a DMA patch to add more comment for sg_alloc_table_from_pages().

Thanks
Huang Shijie
