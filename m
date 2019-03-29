Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905692183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfC2OAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:00:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbfC2OAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:00:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A0D930718E8;
        Fri, 29 Mar 2019 14:00:02 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6365D9D1;
        Fri, 29 Mar 2019 14:00:01 +0000 (UTC)
Date:   Fri, 29 Mar 2019 21:59:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rafael@kernel.org, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.ibm.com, willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 1/2] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190329135958.GL7627@MiWiFi-R3L-srv>
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329103644.ljswr5usslrx7twr@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329103644.ljswr5usslrx7twr@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 29 Mar 2019 14:00:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/19 at 11:36am, Oscar Salvador wrote:
> > +/**
> > + * sparse_add_one_section - add a memory section
> > + * @nid: The node to add section on
> > + * @start_pfn: start pfn of the memory range
> > + * @altmap: device page map
> > + *
> > + * This is only intended for hotplug.
> > + *
> > + * Returns:
> > + *   0 on success.
> > + *   Other error code on failure:
> > + *     - -EEXIST - section has been present.
> > + *     - -ENOMEM - out of memory.
> 
> I am not really into kernel-doc format, but I thought it was something like:
> 
> <--
> Return:
>   0: success
>   -EEXIST: Section is already present
>   -ENOMEM: Out of memory
> -->
> 
> But as I said, I might very well be wrong.

Below is excerpt from doc-guide/kernel-doc.rst. Seems they suggest it
like this if format returned values with multi-line style. While the
format is not strictly defined. I will use it to update.

*Return:
* * 0		- Success
* * -EEXIST 	- Section is already present
* * -ENOMEM	- Out of memory

The return value, if any, should be described in a dedicated section
named ``Return``.

.. note::

  #) The multi-line descriptive text you provide does *not* recognize
     line breaks, so if you try to format some text nicely, as in::

        * Return:
        * 0 - OK
        * -EINVAL - invalid argument
        * -ENOMEM - out of memory

     this will all run together and produce::

        Return: 0 - OK -EINVAL - invalid argument -ENOMEM - out of memory

     So, in order to produce the desired line breaks, you need to use a
     ReST list, e. g.::                                                                                                                           

      * Return:
      * * 0             - OK to runtime suspend the device
      * * -EBUSY        - Device should not be runtime suspended

