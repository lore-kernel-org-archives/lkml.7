Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF71C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CED20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCHTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:39:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHTjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:39:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDFF781E19;
        Fri,  8 Mar 2019 19:39:18 +0000 (UTC)
Received: from [10.40.205.251] (unknown [10.40.205.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C951690F;
        Fri,  8 Mar 2019 19:39:00 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free
 pages
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com>
 <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com>
 <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
 <20190307212845-mutt-send-email-mst@kernel.org>
 <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
 <17d2afa6-556e-ec73-40dc-beac536b3f20@redhat.com>
 <CAKgT0UcdQZwHjmMBkSWmy_ZdShJCagjwomn13g+r7ZNJBRn1LQ@mail.gmail.com>
Organization: Red Hat Inc,
Message-ID: <8f692047-4750-6827-1ee0-d3d354788f09@redhat.com>
Date:   Fri, 8 Mar 2019 14:38:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcdQZwHjmMBkSWmy_ZdShJCagjwomn13g+r7ZNJBRn1LQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8V13K9q11cPOiDPproSx8qZXs1NSfkUuj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 08 Mar 2019 19:39:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8V13K9q11cPOiDPproSx8qZXs1NSfkUuj
Content-Type: multipart/mixed; boundary="f4QJr4T5d62WyAt2NEZJ9Bhrbh7HvhH7s";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, kvm list <kvm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <8f692047-4750-6827-1ee0-d3d354788f09@redhat.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free
 pages

--f4QJr4T5d62WyAt2NEZJ9Bhrbh7HvhH7s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/8/19 2:25 PM, Alexander Duyck wrote:
> On Fri, Mar 8, 2019 at 11:10 AM Nitesh Narayan Lal <nitesh@redhat.com> =
wrote:
>>
>> On 3/8/19 1:06 PM, Alexander Duyck wrote:
>>> On Thu, Mar 7, 2019 at 6:32 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>>>> On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
>>>>> The only other thing I still want to try and see if I can do is to =
add
>>>>> a jiffies value to the page private data in the case of the buddy
>>>>> pages.
>>>> Actually there's one extra thing I think we should do, and that is m=
ake
>>>> sure we do not leave less than X% off the free memory at a time.
>>>> This way chances of triggering an OOM are lower.
>>> If nothing else we could probably look at doing a watermark of some
>>> sort so we have to have X amount of memory free but not hinted before=

>>> we will start providing the hints. It would just be a matter of
>>> tracking how much memory we have hinted on versus the amount of memor=
y
>>> that has been pulled from that pool.
>> This is to avoid false OOM in the guest?
> Partially, though it would still be possible. Basically it would just
> be a way of determining when we have hinted "enough". Basically it
> doesn't do us much good to be hinting on free memory if the guest is
> already constrained and just going to reallocate the memory shortly
> after we hinted on it. The idea is with a watermark we can avoid
> hinting until we start having pages that are actually going to stay
> free for a while.
>
>>>  It is another reason why we
>>> probably want a bit in the buddy pages somewhere to indicate if a pag=
e
>>> has been hinted or not as we can then use that to determine if we hav=
e
>>> to account for it in the statistics.
>> The one benefit which I can see of having an explicit bit is that it
>> will help us to have a single hook away from the hot path within buddy=

>> merging code (just like your arch_merge_page) and still avoid duplicat=
e
>> hints while releasing pages.
>>
>> I still have to check PG_idle and PG_young which you mentioned but I
>> don't think we can reuse any existing bits.
> Those are bits that are already there for 64b. I think those exist in
> the page extension for 32b systems. If I am not mistaken they are only
> used in VMA mapped memory. What I was getting at is that those are the
> bits we could think about reusing.
>
>> If we really want to have something like a watermark, then can't we us=
e
>> zone->free_pages before isolating to see how many free pages are there=

>> and put a threshold on it? (__isolate_free_page() does a similar thing=

>> but it does that on per request basis).
> Right. That is only part of it though since that tells you how many
> free pages are there. But how many of those free pages are hinted?
> That is the part we would need to track separately and then then
> compare to free_pages to determine if we need to start hinting on more
> memory or not.
Only pages which are isolated will be hinted, and once a page is
isolated it will not be counted in the zone free pages.
Feel free to correct me if I am wrong.
If I am understanding it correctly you only want to hint the idle pages,
is that right?
>
>>>>> With that we could track the age of the page so it becomes
>>>>> easier to only target pages that are truly going cold rather than
>>>>> trying to grab pages that were added to the freelist recently.
>>>> I like that but I have a vague memory of discussing this with Rik va=
n
>>>> Riel and him saying it's actually better to take away recently used
>>>> ones. Can't see why would that be but maybe I remember wrong. Rik - =
am I
>>>> just confused?
>>> It is probably to cut down on the need for disk writes in the case of=

>>> swap. If that is the case it ends up being a trade off.
>>>
>>> The sooner we hint the less likely it is that we will need to write a=

>>> given page to disk. However the sooner we hint, the more likely it is=

>>> we will need to trigger a page fault and pull back in a zero page to
>>> populate the last page we were working on. The sweet spot will be tha=
t
>>> period of time that is somewhere in between so we don't trigger
>>> unnecessary page faults and we don't need to perform additional swap
>>> reads/writes.
>> --
>> Regards
>> Nitesh
>>
--=20
Regards
Nitesh


--f4QJr4T5d62WyAt2NEZJ9Bhrbh7HvhH7s--

--8V13K9q11cPOiDPproSx8qZXs1NSfkUuj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlyCxNAACgkQo4ZA3AYy
ozl3oRAAia5Dz2avOmKr/a1Ev84UQjMmuObxBysvEemwv6N1ZTU+nlC7CXOk1jx5
Kk6dIaPn70vs8i4D6eZs0Uh/ocedS5bXgEUKvvxPaSyZzti4QaoG0SPUWqrbQzlr
5N6fhcaXmJsIkSNKhcMGdz7gOGXeOn7xjTICT60GAZFTECLVqY4Nh6HjAGtVCeUA
pzVydsO96pS4f7nE1+jOsAo18RIqpyrArzFHHQMVlD0STpJBGf4xoXJOWYz3D+MB
509GeqjptMe6kBAxK9ZLxFWgmvBvHKBzHnytKNLxfBHs7AuvdOzPooz6WbO5cWth
RhMb9ffIwkve7nDJGCAjK51aVoc+lajvCkzQNjFu1la+syCNihA1vAqShA4U9WSJ
TyFSYMpQ1ZoI0uJl4E2g6FxbQ/EqosMjvTmNG0QoP7zpyJ+aa8HSTbfkFSdQ6UxL
N08gXgdis1iq3q4u9N4zTL8Xzp2paF3jKpW9/NzRlR/DmPI9so30mnywT5cQcnDZ
XT3XLbhg+MxO2P3e9iDgozHDxptxYtf01KJIMJm+JFTFagQ8i1AMHVsswwg88pQc
h1xTfl1xMh+gehhxGf4gk5vJY8c7Raoq9/ZqiIdxY67xpwIy+zuGGagowvpXcBz/
kNNG4KeSUHPWBfGmb2GMg6/WhNY5RJ4deke8B/rWqRpx6dDHSSk=
=n2GA
-----END PGP SIGNATURE-----

--8V13K9q11cPOiDPproSx8qZXs1NSfkUuj--
