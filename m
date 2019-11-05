Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADAC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFED222CD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFhRCRqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfKEKO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:14:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34063 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387945AbfKEKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572948897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjKU1u6KcaZgX4NYjUsHfYNS+cOdjDOwyw+V7fvfunk=;
        b=eFhRCRqWhhnEJIEAJfqARGT4SfnYdiS2mnNtvMRYAK+z9ooWVj3hW86yGf0jv7GxVnJ6rC
        gxOaWVvcf1BbmVN4h/14g/SMtlsJTCwZPaPMgmMpSomZ8VzSXEUmzmzQaBsokO0KsH52m4
        TrUrM7pjC1UyrJje0eIXJ+oCTZIyAGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-TI7KHRKBPAa8P93Eoj7deg-1; Tue, 05 Nov 2019 05:14:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82C4107ACC2;
        Tue,  5 Nov 2019 10:14:51 +0000 (UTC)
Received: from [10.36.117.253] (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C67A608C8;
        Tue,  5 Nov 2019 10:14:48 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191030202217.3498133-1-songliubraving@fb.com>
 <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
 <20191105094518.GA25980@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <70dedc65-6668-bce9-f42d-f99ea71e9a26@redhat.com>
Date:   Tue, 5 Nov 2019 11:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191105094518.GA25980@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: TI7KHRKBPAa8P93Eoj7deg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.19 10:45, Michal Hocko wrote:
> On Mon 04-11-19 15:53:18, Vlastimil Babka wrote:
> [...]
>> (And obviously, could we finally get a real git? :)
>=20
> I would love to see that happen! While I do appreciate existance of
> Johannes' mirror that is not something that is suitable for a long term
> development IMHO because the tree rebases constantly.
>=20
> And while we are talking about a better information on the MM
> maintainership, should we also be explicit about maintainers of MM parts
> which have a primary go to person? At least compaction, allocator, OOM,
> memory hotplug, THP, shmem, memory hwpoisoning, early allocators come to
> mind.

Yes please. This is valuable information.


--=20

Thanks,

David / dhildenb

