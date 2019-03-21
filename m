Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACBC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8585E218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CvHMCAHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCUVUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:20:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1638 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCUVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:20:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9400330001>; Thu, 21 Mar 2019 14:20:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Mar 2019 14:20:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Mar 2019 14:20:52 -0700
Received: from [10.2.161.82] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Mar
 2019 21:20:52 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [PATCH 0/5] Page demotion for memory reclaim
Date:   Thu, 21 Mar 2019 14:20:51 -0700
X-Mailer: MailMate (1.12.4r5614)
Message-ID: <5B5EFBC2-2979-4B9F-A43A-1A14F16ACCE1@nvidia.com>
In-Reply-To: <20190321200157.29678-1-keith.busch@intel.com>
References: <20190321200157.29678-1-keith.busch@intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_64525BCB-86AC-4202-8D74-2FF72494C4AB_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553203251; bh=P6nweyKjbPNRrHuFN0rcQFMXBtF9NIHBGG9PP2cx3gU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=CvHMCAHb62LnWhXYaTKpIzZ/8/u5hF9yqCeAjmJyfMMVl7GIJFMWQFiBM6fNonSzy
         x0EZcfLfo9VxMuTzYfXd//0+SQKpUHOPNN5y4VnGtpMkG+VIxCLfUpsSnFgo2WS43W
         NIG+SX1L/NPoMoKZKMybvacOhDPrC6VmTMnyDYeaFG7/Svs4gvnbPTksyuLJdyvOti
         l/UPviM7V/RLqaPtk0vN58Ck2XWrtqNmqIBCl/3A9U/oEG2OprSTnOn5Y4UlXakkqq
         1HrfxlQaUWJknjTmA67/CYma9htlCXfc/H/Lp1ggGJavdjx3ko/Wq7/IpPHR3SISF+
         ISTSP1ebZpdIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_64525BCB-86AC-4202-8D74-2FF72494C4AB_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2019, at 13:01, Keith Busch wrote:

> The kernel has recently added support for using persistent memory as
> normal RAM:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dc221c0b0308fd01d9fb33a16f64d2fd95f8830a4
>
> The persistent memory is hot added to nodes separate from other memory
> types, which makes it convenient to make node based memory policies.
>
> When persistent memory provides a larger and cheaper address space, but=

> with slower access characteristics than system RAM, we'd like the kerne=
l
> to make use of these memory-only nodes as a migration tier for pages
> that would normally be discared during memory reclaim. This is faster
> than doing IO for swap or page cache, and makes better utilization of
> available physical address space.
>
> The feature is not enabled by default. The user must opt-in to kernel
> managed page migration by defining the demotion path. In the future,
> we may want to have the kernel automatically create this based on
> heterogeneous memory attributes and CPU locality.
>

Cc more people here.

Thank you for the patchset. This is definitely useful when we have larger=
 PMEM
backing existing DRAM. I have several questions:

1. The name of =E2=80=9Cpage demotion=E2=80=9D seems confusing to me, sin=
ce I thought it was about large pages
demote to small pages as opposite to promoting small pages to THPs. Am I =
the only
one here?

2. For the demotion path, a common case would be from high-performance me=
mory, like HBM
or Multi-Channel DRAM, to DRAM, then to PMEM, and finally to disks, right=
? More general
case for demotion path would be derived from the memory performance descr=
iption from HMAT[1],
right? Do you have any algorithm to form such a path from HMAT?

3. Do you have a plan for promoting pages from lower-level memory to high=
er-level memory,
like from PMEM to DRAM? Will this one-way demotion make all pages sink to=
 PMEM and disk?

4. In your patch 3, you created a new method migrate_demote_mapping() to =
migrate pages to
other memory node, is there any problem of reusing existing migrate_pages=
() interface?

5. In addition, you only migrate base pages, is there any performance con=
cern on migrating THPs?
Is it too costly to migrate THPs?

Thanks.


[1] https://lwn.net/Articles/724562/

--
Best Regards,
Yan Zi

--=_MailMate_64525BCB-86AC-4202-8D74-2FF72494C4AB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlyUADMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKSFgQALRovEKyG0/MfQCHU7h0VuN+Y1Ed/08d75x8
EToYq9az+/ecbuxikO5CcMDAa7Llw6BpMkeRaldPARrXIPj3tXeJeHgwLFO6C1Wg
CC4oSM2XsZYoZ1JDwXeTDKIcO1OWCnANPHh3IbjdfcOKF8Z465sxaC70U9OCbzEb
K/Tky+mUMBqokj40A7cTq72FLcOTcrXpyXMJqoWrl188E4bTiQs87FzSaN2wIKNr
XP4MJCJR5cWcS0B1rLKfBTP/gZCWmOO6vCO9uxi/IH4QddfC8u8zZsIqzDQ3hc45
37iYKoWMxSpqeynoz0elvjFYQB5QaXEsmzKXrpDbuiHyaaB25QPl0KbbVTllQJdH
7DNe/zE2gS5MQl16r3DkHDssAZPu48vTgQNlVciDmzeEB4KURuZf/ItrGGXGfdDN
3xScDxR4+fAJ3GzDRyG9M/CwsxbCgHl3fA60/ohO/Yyg0q1E42DWyMTammRikR7z
4xI+r/jBXQMoiDrZ8DpU44QzRyWQugCJV2sX7BqtHpSxiMwlY7VR6g9PNn5bfHi9
9hlI0k3xlEhLvF8voePfAY4iKhSpT5tNkNiwCJwikGByT+IJEAZW3+ESAYmv5U69
dEZBjMSUbPS2uEVTEByjWw40FbuLWUh+7U3wloXwvKpfqQJby1RBl5gEKKIi8xBu
PZ6qi/3K
=WKXP
-----END PGP SIGNATURE-----

--=_MailMate_64525BCB-86AC-4202-8D74-2FF72494C4AB_=--
