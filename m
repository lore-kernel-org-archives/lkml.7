Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92430C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E4217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h2W2PudR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbfDRVHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:07:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18708 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfDRVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:07:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb8e7090000>; Thu, 18 Apr 2019 14:07:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Apr 2019 14:07:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Apr 2019 14:07:15 -0700
Received: from [10.2.163.72] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Apr
 2019 21:07:13 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <mgorman@techsingularity.net>, <riel@surriel.com>,
        <hannes@cmpxchg.org>, <akpm@linux-foundation.org>,
        <dan.j.williams@intel.com>, <fengguang.wu@intel.com>,
        <fan.du@intel.com>, <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Date:   Thu, 18 Apr 2019 17:07:11 -0400
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <1603DE17-0090-47C5-8438-4623D1B684AA@nvidia.com>
In-Reply-To: <8259dfd6-9044-b9f8-29b1-f427b4435eda@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <5c2d37e1-c7f6-5b7b-4f8e-a34e981b841e@intel.com>
 <20190418181643.GB7659@localhost.localdomain>
 <8259dfd6-9044-b9f8-29b1-f427b4435eda@linux.alibaba.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_5E3781CD-B9F6-408F-BA40-B35DEC4A82B8_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555621641; bh=nL+sMwEmPCY4rNbOS/JGJ4nu8a5lRZWh4YcqIgrxm04=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=h2W2PudRBNpYFmzSz+/ehPkOYUqJSQcofXo71X+1tFWypwa69zMPXFcLUvJWeDeQ0
         LtgeY99mETRwplq8gDd1AaCwMfs/f1d3HAQA5chJpOwEVjDHx+N/teXRXUIXNws3RT
         0oulDZVUhhNyR6UmrNjj8hdXUWlJDnUb1M2/XqlMA5i3h4Yx80AGXSawdwWWR9R5FX
         GV34jOBmU28ALQC8jSRg5U9TUJsZ5vZdY03/bXiWhYaBxLt9rb6XdlaqpVNFCVZZIx
         9Vc6Xhw5hIoTQXcmFT+EfUDWmxD9oaRMz4quXgzs5BZ0agBiuaTLQUzts9PpvOe6k0
         VWVlD+P+Qavng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5E3781CD-B9F6-408F-BA40-B35DEC4A82B8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Apr 2019, at 15:23, Yang Shi wrote:

> On 4/18/19 11:16 AM, Keith Busch wrote:
>> On Wed, Apr 17, 2019 at 10:13:44AM -0700, Dave Hansen wrote:
>>> On 4/17/19 2:23 AM, Michal Hocko wrote:
>>>> yes. This could be achieved by GFP_NOWAIT opportunistic allocation f=
or
>>>> the migration target. That should prevent from loops or artificial n=
odes
>>>> exhausting quite naturaly AFAICS. Maybe we will need some tricks to
>>>> raise the watermark but I am not convinced something like that is re=
ally
>>>> necessary.
>>> I don't think GFP_NOWAIT alone is good enough.
>>>
>>> Let's say we have a system full of clean page cache and only two node=
s:
>>> 0 and 1.  GFP_NOWAIT will eventually kick off kswapd on both nodes.
>>> Each kswapd will be migrating pages to the *other* node since each is=
 in
>>> the other's fallback path.
>>>
>>> I think what you're saying is that, eventually, the kswapds will see
>>> allocation failures and stop migrating, providing hysteresis.  This i=
s
>>> probably true.
>>>
>>> But, I'm more concerned about that window where the kswapds are throw=
ing
>>> pages at each other because they're effectively just wasting resource=
s
>>> in this window.  I guess we should figure our how large this window i=
s
>>> and how fast (or if) the dampening occurs in practice.
>> I'm still refining tests to help answer this and have some preliminary=

>> data. My test rig has CPU + memory Node 0, memory-only Node 1, and a
>> fast swap device. The test has an application strict mbind more than
>> the total memory to node 0, and forever writes random cachelines from
>> per-cpu threads.
>
> Thanks for the test. A follow-up question, how about the size for each =
node? Is node 1 bigger than node 0? Since PMEM typically has larger capac=
ity, so I'm wondering whether the capacity may make things different or n=
ot.
>
>> I'm testing two memory pressure policies:
>>
>>    Node 0 can migrate to Node 1, no cycles
>>    Node 0 and Node 1 migrate with each other (0 -> 1 -> 0 cycles)
>>
>> After the initial ramp up time, the second policy is ~7-10% slower tha=
n
>> no cycles. There doesn't appear to be a temporary window dealing with
>> bouncing pages: it's just a slower overall steady state. Looks like wh=
en
>> migration fails and falls back to swap, the newly freed pages occasion=
aly
>> get sniped by the other node, keeping the pressure up.


In addition to these two policies, I am curious about how MPOL_PREFERRED =
to Node 0
performs. I just wonder how bad static page allocation does.

--
Best Regards,
Yan Zi

--=_MailMate_5E3781CD-B9F6-408F-BA40-B35DEC4A82B8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAly45v8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKnnIQAKE47hPakks41SBv19FR7y5bTpSP1Z2QUQmd
OvoFo8YxcVq0Dl7DA2QWP8DSGgc2qd2kWwtSnkFfIU0XLEONPZTGjzJ06vYdtjeT
61xPup7HSMy4Lm21TINBKxUuE4ATRt4QYydB0mVRGdMObmfJfrrxW0UJXcbo/QFM
KVS9tnf1qXVlrq0/BVi1u9b9s6Fvr386C1ClWXd5YXGtPgC2MzcYEuZkUhArwK9S
bpjYP62hFButU6a9Vdsnm9s0R2S1D44iFChvtqGoDOzdU6cz06HB2gq9GjZJK8vZ
RcDO0/nlGcrIxtxzUO0IJ581gFtOcqFu9kD5BgGzO4tS1BdmChs5QS7vGUR1YrGA
X4zKSFe9xy4abqY6sirLPqDw45GrSFLiWlEbJvJvpM59Zm/fWnkBXlFNwgH2mUHi
UnrGeKG11TtMvVSt6mfbadDvx2cMrlNkA/pcRHPwJh1QFKxHwcMbkkfE2HDLt8//
5PLjzK0PmAih/ByCGhqSn0XFNBlS1QKGNo+Eo0tfOPgt3Y5FrxNgdkkoLEqQnvme
mKmK+bUUyY/pYOgVfYgGKhJVkiyrTX3C7XooJRfYinqUPppRRQ+JffyCF96Lv8Ij
qcgCvH7WBgtHQH923gLunxNzeGYubIMHNVDRPBWHV0Wfy7F3QBLw/dSdlGoEJ4ud
JAHRzB4r
=a4wc
-----END PGP SIGNATURE-----

--=_MailMate_5E3781CD-B9F6-408F-BA40-B35DEC4A82B8_=--
