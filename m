Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EED320857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfCZJhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:37:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9059 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfCZJhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:37:37 -0400
X-IronPort-AV: E=Sophos;i="5.60,271,1549900800"; 
   d="scan'208";a="57729882"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Mar 2019 17:37:36 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7D1B44CD5BD8;
        Tue, 26 Mar 2019 17:37:31 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 26 Mar 2019 17:37:36 +0800
Date:   Tue, 26 Mar 2019 17:36:42 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <rppt@linux.ibm.com>, <osalvador@suse.de>, <willy@infradead.org>,
        <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/4] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190326093642.GD4234@localhost.localdomain>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-2-bhe@redhat.com>
 <20190326092324.GJ28406@dhcp22.suse.cz>
 <20190326093057.GS3659@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190326093057.GS3659@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 7D1B44CD5BD8.AC83F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:30:57PM +0800, Baoquan He wrote:
>On 03/26/19 at 10:23am, Michal Hocko wrote:
>> On Tue 26-03-19 17:02:24, Baoquan He wrote:
>> > The code comment above sparse_add_one_section() is obsolete and
>> > incorrect, clean it up and write new one.
>> > 
>> > Signed-off-by: Baoquan He <bhe@redhat.com>
>> 
>> Please note that you need /** to start a kernel doc. Other than that.
>
>I didn't find a template in coding-style.rst, and saw someone is using
>/*, others use /**. I will use '/**' instead. Thanks for telling.

How to format kernel-doc comments
---------------------------------

The opening comment mark ``/**`` is used for kernel-doc comments. The
``kernel-doc`` tool will extract comments marked this way. The rest of
the comment is formatted like a normal multi-line comment with a column
of asterisks on the left side, closing with ``*/`` on a line by itself.

See Documentation/doc-guide/kernel-doc.rst for more details.
Hope that can help you.

Thanks,
Chao Fan

>
>> 
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> > ---
>> > v1-v2:
>> >   Add comments to explain what the returned value means for
>> >   each error code.
>> > 
>> >  mm/sparse.c | 15 ++++++++++++---
>> >  1 file changed, 12 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/mm/sparse.c b/mm/sparse.c
>> > index 69904aa6165b..b2111f996aa6 100644
>> > --- a/mm/sparse.c
>> > +++ b/mm/sparse.c
>> > @@ -685,9 +685,18 @@ static void free_map_bootmem(struct page *memmap)
>> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>> >  
>> >  /*
>> > - * returns the number of sections whose mem_maps were properly
>> > - * set.  If this is <=0, then that means that the passed-in
>> > - * map was not consumed and must be freed.
>> > + * sparse_add_one_section - add a memory section
>> > + * @nid: The node to add section on
>> > + * @start_pfn: start pfn of the memory range
>> > + * @altmap: device page map
>> > + *
>> > + * This is only intended for hotplug.
>> > + *
>> > + * Returns:
>> > + *   0 on success.
>> > + *   Other error code on failure:
>> > + *     - -EEXIST - section has been present.
>> > + *     - -ENOMEM - out of memory.
>> >   */
>> >  int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>> >  				     struct vmem_altmap *altmap)
>> > -- 
>> > 2.17.2
>> > 
>> 
>> -- 
>> Michal Hocko
>> SUSE Labs
>
>


