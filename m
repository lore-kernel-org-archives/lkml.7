Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54FC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168B2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJBH4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:56:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfJBH4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11626AE21;
        Wed,  2 Oct 2019 07:56:30 +0000 (UTC)
Subject: Re: [PATCH v1 1/3] xen/balloon: Drop __balloon_append()
To:     David Hildenbrand <david@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org
References: <20191001090152.1770-1-david@redhat.com>
 <20191001090152.1770-2-david@redhat.com>
 <be450770-07f6-9fbf-087d-6fc420b6329b@oracle.com>
 <b89e930b-bbf4-9358-97fe-8107e304ee65@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <25797c40-2ea9-1a3a-eeea-2f6057358481@suse.com>
Date:   Wed, 2 Oct 2019 09:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b89e930b-bbf4-9358-97fe-8107e304ee65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.19 09:47, David Hildenbrand wrote:
> On 01.10.19 19:45, Boris Ostrovsky wrote:
>> On 10/1/19 5:01 AM, David Hildenbrand wrote:
>>> Let's simply use balloon_append() directly.
>>>
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> For the series (and your earlier patch)
>>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Thanks! Who's the lucky winner to eventually pick the four patches up? :)

They will be taken through the Xen tree.


Juergen
