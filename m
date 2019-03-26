Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A072086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZJnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZJnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:43:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38C7B3084026;
        Tue, 26 Mar 2019 09:43:51 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 886241712F;
        Tue, 26 Mar 2019 09:43:50 +0000 (UTC)
Date:   Tue, 26 Mar 2019 17:43:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        osalvador@suse.de, willy@infradead.org,
        william.kucharski@oracle.com
Subject: Re: [PATCH v2 1/4] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190326094348.GT3659@MiWiFi-R3L-srv>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-2-bhe@redhat.com>
 <20190326092324.GJ28406@dhcp22.suse.cz>
 <20190326093057.GS3659@MiWiFi-R3L-srv>
 <20190326093642.GD4234@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326093642.GD4234@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 26 Mar 2019 09:43:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 05:36pm, Chao Fan wrote:
> On Tue, Mar 26, 2019 at 05:30:57PM +0800, Baoquan He wrote:
> >On 03/26/19 at 10:23am, Michal Hocko wrote:
> >> On Tue 26-03-19 17:02:24, Baoquan He wrote:
> >> > The code comment above sparse_add_one_section() is obsolete and
> >> > incorrect, clean it up and write new one.
> >> > 
> >> > Signed-off-by: Baoquan He <bhe@redhat.com>
> >> 
> >> Please note that you need /** to start a kernel doc. Other than that.
> >
> >I didn't find a template in coding-style.rst, and saw someone is using
> >/*, others use /**. I will use '/**' instead. Thanks for telling.
> 
> How to format kernel-doc comments
> ---------------------------------
> 
> The opening comment mark ``/**`` is used for kernel-doc comments. The
> ``kernel-doc`` tool will extract comments marked this way. The rest of
> the comment is formatted like a normal multi-line comment with a column
> of asterisks on the left side, closing with ``*/`` on a line by itself.
> 
> See Documentation/doc-guide/kernel-doc.rst for more details.
> Hope that can help you.

Great, there's a specific kernel-doc file. Thanks, I will update and
repost this one with '/**'.
