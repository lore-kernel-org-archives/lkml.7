Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EDD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KYEYMqia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfEMR1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:27:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15524 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbfEMR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:27:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9a8eb0000>; Mon, 13 May 2019 10:27:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 10:27:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 10:27:00 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 17:27:00 +0000
Subject: Re: [PATCH 0/5] mm/hmm: HMM documentation updates and code fixes
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190512150832.GB4238@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <89c6ce48-190b-65df-7c35-a0eb0f5d936f@nvidia.com>
Date:   Mon, 13 May 2019 10:26:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190512150832.GB4238@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557768427; bh=5iuLlyyOWz845CEoxjvFeDA6uM+p6rUh7ezrIXkoluc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KYEYMqiaFUWGmzf3uqRTE3CKf0u6MxnNhKf5pI+pHFvjypeWF8KWQTzcVWwQoag93
         qpf7d2eBgg04VrJm3elH3119s8dRSdNRlKdqgM09VPSBimQBSoJv+YmGxacQVs12uM
         LgKZRNgZ4cPHJHS4bZE65PFWPmGH6ZKNSFXr06e0aa/UQbx/smyDqfKaCJl2Lhp75+
         7H2GykDVlleOBe/rqdpKIPJ9dvuPOLZ25UNInI7ov+W1oRSzT2cMBYWxqhfWAVxjSJ
         7BkwemDz5kvzrpPh/qt4BaQqoPPnpfKCPB5ILknioJxCGHsvmHaTKOaMLcOzLPdP/v
         PyclKZ3YFaJrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/19 8:08 AM, Jerome Glisse wrote:
> On Mon, May 06, 2019 at 04:29:37PM -0700, rcampbell@nvidia.com wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> I hit a use after free bug in hmm_free() with KASAN and then couldn't
>> stop myself from cleaning up a bunch of documentation and coding style
>> changes. So the first two patches are clean ups, the last three are
>> the fixes.
>>
>> Ralph Campbell (5):
>>    mm/hmm: Update HMM documentation
>>    mm/hmm: Clean up some coding style and comments
>>    mm/hmm: Use mm_get_hmm() in hmm_range_register()
>>    mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
>>    mm/hmm: Fix mm stale reference use in hmm_free()
>=20
> This patchset does not seems to be on top of
> https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dhmm-5.2-v3
>=20
> So here we are out of sync, on documentation and code. If you
> have any fix for https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dhmm-=
5.2-v3
> then please submit something on top of that.
>=20
> Cheers,
> J=C3=A9r=C3=B4me
>=20
>>
>>   Documentation/vm/hmm.rst | 139 ++++++++++++++++++-----------------
>>   include/linux/hmm.h      |  84 ++++++++++------------
>>   mm/hmm.c                 | 151 ++++++++++++++++-----------------------
>>   3 files changed, 174 insertions(+), 200 deletions(-)
>>
>> --=20
>> 2.20.1

The patches are based on top of Andrew's mmotm tree
git://git.cmpxchg.org/linux-mmotm.git v5.1-rc6-mmotm-2019-04-25-16-30.
They apply cleanly to that git tag as well as your hmm-5.2-v3 branch
so I guess I am confused where we are out of sync.
