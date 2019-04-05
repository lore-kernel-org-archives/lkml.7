Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47291C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166E02184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ETibEjj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfDERU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:20:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17609 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDERU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:20:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca78e4e0000>; Fri, 05 Apr 2019 10:20:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 05 Apr 2019 10:20:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 05 Apr 2019 10:20:26 -0700
Received: from [10.2.169.63] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 17:20:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 00/25] Accelerate page migration and use memcg for
 PMEM management
Date:   Fri, 5 Apr 2019 10:20:24 -0700
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <D0A02EB6-A255-463A-9AF2-CAF8E35A706C@nvidia.com>
In-Reply-To: <ef7d952f-a0c2-3947-a5bf-f6694acfdb02@linux.alibaba.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
 <ef7d952f-a0c2-3947-a5bf-f6694acfdb02@linux.alibaba.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_A657F5FF-0091-487A-946B-6B2128F7BF25_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554484814; bh=vyFwJUHhRu2gFilJpDWKFzFswyAlmcV5OBEDXcj+WC8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=ETibEjj6xRheRZRBV/eihd+S7XMs6tQCz0M9VJCBntGm4qh1UaHp8WuO2E88t8Pyr
         q84nsKF8JG2kMrjfVQshSzzCAskVm9F/aXId25GpOqMfTTIVKMS2cbsX/Z9Eb8WS5C
         QCuby7RfI3nOCBROVISKUipHJmRknjluA3kY5RKKu3gtk8fsqRJBEdgHtqA1kmYVnk
         FGoh8OSKUwh9cQ/kDAyUYfMnJwh/F8L9HRhx/J4t0ZvTbbfzn+xNKgTTRhPLkcrX35
         BspUG2efSSYnFIZNZ4T7enByZuUxwwsLwRs3DHxbZgwlUFIUTzvhTvnxGpygzEQq64
         uCkGIhQ4dm+RQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A657F5FF-0091-487A-946B-6B2128F7BF25_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


>> Infrequent page list update problem
>> =3D=3D=3D=3D
>>
>> Current page lists are updated by calling shrink_list() when memory pr=
essure
>> comes,  which might not be frequent enough to keep track of hot and co=
ld pages.
>> Because all pages are on active lists at the first time shrink_list() =
is called
>> and the reference bit on the pages might not reflect the up to date ac=
cess status
>> of these pages. But we also do not want to periodically shrink the glo=
bal page
>> lists, which adds unnecessary overheads to the whole system. So I prop=
ose to
>> actively shrink page lists on the memcg we are interested in.
>>
>> Patch 18 to 25 add a new system call to shrink page lists on given app=
lication's
>> memcg and migrate pages between two NUMA nodes. It isolates the impact=
 from the
>> rest of the system. To share DRAM among different applications, Patch =
18 and 19
>> add per-node memcg size limit, so you can limit the memory usage for p=
articular
>> NUMA node(s).
>
> This sounds a little bit confusing to me. Is it totally user's decision=
 about when to call the syscall to shrink page lists? But, how would user=
 know when is a good timing? Could you please elaborate the usecase?

Sure. We would set up a daemon that monitors user applications and calls =
the syscall
to shuffle the page lists for the user applications, although the daemon=E2=
=80=99s concrete
action plan is still under exploration. It might not be ideal but the pag=
e access information
could be refreshed periodically and page migration would happen on the ba=
ckground of
application execution.

On the other hand, if we wait until DRAM is full and use page migration t=
o make room in DRAM
for either page promotion or new page allocation, page migration sits on =
the critical path
of application execution. Considering the bandwidth and access latency ga=
ps between
DRAM and PMEM are not as large as the gaps between DRAM and SSD, the cost=
 of page migration
(4KB/0.312GB/s =3D 12us or 2MB/2.387GB/s =3D 818us)might defeat the benef=
it of using DRAM over PMEM.
I just wonder which would be better: waiting for 12us or 818us then readi=
ng 4KB or 2MB data in DRAM
or directly accessing the data in PMEM without waiting.

Let me know if this makes sense to you.

Thanks.

--
Best Regards,
Yan Zi

--=_MailMate_A657F5FF-0091-487A-946B-6B2128F7BF25_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlynjlgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKKU0P/ikw4QJvkMnCTTRZt9W5oa0igVq/v3m2Z3wB
x5060LA2205BThiHa04ggs4BX8mx5LpMntFKYpTYA1lzD+yz1Y7JyBSDoviW2srQ
fCK3zDtyBDLWEzd22aE1Gxgx/Iglpgo2T298PjtcpIVgy9t45Ih904r8h8+WDE7u
H7jcILfuGvDMMrcYlpOm1Gg+/pzUPGrpkWTQBBq6lmHP1LqPkK3OsoYRucB9/EnC
1lEtaze8gIjVXGy16Em1HcPkU207CjY7zmgF4st8lFTu8kEvn+/XWbdGNwQAA8bi
FncSc5YBP7Fer0xOYivVAY5kVWftlhMTkqHPElidrReQU+fuiS2pYZ+sf7GoFdG/
AXj1aPOAHtFFpbwxRVckZIt3zMmCkk2A+w5Tl/0+RiDvPIv0yLo/axz3BBRyZSV8
hdYEc010Jo6GNB2z1Iz5keQqltwovQmv7fl4X/syU8i3mS1IfVFP+DlnOmYNomei
nvuS2BQSCO/CzbL6otS5euRSih4hf229lWjS20y/KJzcE9KhGK1Nt3QT5v306dwW
QzaDI01zSjfHsJcbPs6Q2eKhXoNBGQU3FTdGpg7Yb7SFVm9PcXdKQeyuFG5nC52M
pVEYs+K3Op9CRvpVaoCRqShLRsLPQl599v5ngHhMnfS8YaLv9MIlDb3ewmSja+7c
MNRQvCjf
=A9hd
-----END PGP SIGNATURE-----

--=_MailMate_A657F5FF-0091-487A-946B-6B2128F7BF25_=--
