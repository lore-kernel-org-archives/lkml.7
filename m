Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C5C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999BD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfFQKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbfFQKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4217AE1C;
        Mon, 17 Jun 2019 10:14:15 +0000 (UTC)
Subject: Re: [RFC PATCH 14/16] xen/blk: gnttab, evtchn, xenbus API changes
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-15-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <1a4e2fe7-ed2d-05f1-9f2f-f0a940b30151@suse.com>
Date:   Mon, 17 Jun 2019 12:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-15-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> For the most part, we now pass xenhost_t * as a parameter.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

I don't see how this can be a patch on its own.

The only way to be able to use a patch for each driver would be to
keep the original grant-, event- and xenbus-interfaces and add the
new ones taking xenhost * with a new name. The original interfaces
could then use xenhost_default and you can switch them to the new
interfaces one by one. The last patch could then remove the old
interfaces when there is no user left.


Juergen
