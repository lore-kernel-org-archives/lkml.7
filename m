Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB104222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfCYPm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbfCYPm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E266309E979;
        Mon, 25 Mar 2019 15:42:56 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D0CE842B6;
        Mon, 25 Mar 2019 15:42:22 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
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
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
References: <20190306130955-mutt-send-email-mst@kernel.org>
 <ce55943e-87b6-c102-9827-2cfd45b7192c@redhat.com>
 <CAKgT0UcGCFNQRZFmp8oMkG+wKzRtwN292vtFWgyLsdyRnO04gQ@mail.gmail.com>
 <ed9f7c2e-a7e3-a990-bcc3-459e4f2b4a44@redhat.com>
 <4bd54f8b-3e9a-3493-40be-668962282431@redhat.com>
 <6d744ed6-9c1c-b29f-aa32-d38387187b74@redhat.com>
 <CAKgT0UcBDKr0ACHQWUCvmm8atxM6wSu7aCRFJkFvfjT_W_femQ@mail.gmail.com>
 <6709bb82-5e99-019d-7de0-3fded385b9ac@redhat.com>
 <6ab9b763-ac90-b3db-3712-79a20c949d5d@redhat.com>
 <99b9fa88-17b1-f2a9-7dd4-7a8f6e790d30@redhat.com>
 <20190325113543-mutt-send-email-mst@kernel.org>
Organization: Red Hat Inc,
Message-ID: <715834ec-71db-c78a-6949-2bdd2e02b262@redhat.com>
Date:   Mon, 25 Mar 2019 11:42:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190325113543-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ome6xoXIbCoRvokoosxPpacRPrkLNwvqT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 25 Mar 2019 15:42:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ome6xoXIbCoRvokoosxPpacRPrkLNwvqT
Content-Type: multipart/mixed; boundary="wwkf63jV0sTvhnaTwEhX3J79wvQJ7sZzm";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>, kvm list <kvm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <715834ec-71db-c78a-6949-2bdd2e02b262@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting

--wwkf63jV0sTvhnaTwEhX3J79wvQJ7sZzm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/25/19 11:37 AM, Michael S. Tsirkin wrote:
> On Mon, Mar 25, 2019 at 10:27:46AM -0400, Nitesh Narayan Lal wrote:
>> I performed some experiments to see if the current implementation of
>> hinting breaks THP. I used AnonHugePages to track the THP pages
>> currently in use and memhog as the guest workload.
>> Setup:
>> Host Size: 30GB (No swap)
>> Guest Size: 15GB
>> THP Size: 2MB
>> Process: Guest is installed with different kernels to hint different
>> granularities(MAX_ORDER - 1, MAX_ORDER - 2 and MAX_ORDER - 3). Memhog=C2=
=A0
>> 15G is run multiple times in the same guest to see AnonHugePages usage=

>> in the host.
>>
>> Observation:
>> There is no THP split for order MAX_ORDER - 1 & MAX_ORDER - 2 whereas
>> for hinting granularity MAX_ORDER - 3 THP does split irrespective of
>> MADVISE_FREE or MADVISE_DONTNEED.
>> --=20
>> Regards
>> Nitesh
>>
> This is on x86 right?
Yes.
>  So THP is 2M and MAX_ORDER is 8M.
> MAX_ORDER - 3 =3D=3D> 1M.
> Seems to work out.
>
>
--=20
Regards
Nitesh


--wwkf63jV0sTvhnaTwEhX3J79wvQJ7sZzm--

--Ome6xoXIbCoRvokoosxPpacRPrkLNwvqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlyY9tMACgkQo4ZA3AYy
ozn4cA//dAdKiNLLqGXpP4udkqrSmrA80bMipkea4/95uNL43eQYeWo/WEgsy0zK
AQNUMfTVH4Rc0eJd3pa8wrwKyfw02wZjbN0lTCUThCPXnSGxwvXX8KsmPNqX3Rxb
QgEmYow7y8H+j7HWIn/4o/YkrXKIDFN3cVLAyEExaCSI8lMjJO78rWtPjSiVrkPS
gbUe+86vYbQgmzYRb83gcjubDJ6kjxE7bRtuVSIUsuJExahAxeHUa8Q4M92MSYYq
V833gFO66mA3u5rbS9gAEQHIJk1KX4E5bje35CG2RUuGdYsEDKjcdejb2DsiAV8t
nsfMBWD8rkwAAbzoVAZBOQ6UoofaMfVti6Hx37UcYpJS/Z/VOB5BPJaZYw57OUgd
XnrKfu8aQmVYqAs/3x/0h76LS9qjUF630fjaa0Pq+2mJOu2ijhMc8JwvfnqnNttw
1v++5frXJ7/5lWxLMSfDKq0THZOeY8R7zuxdPXGcY+dhYYJncdODXtshXk9Zymir
mkLKbEYZfgPLnbb6fAfNwQF+gmsWdEC4a/tpvS9bNWh+hkk+jZhH5uaDqKgxpxSV
y3Tm3tyX733+HP3zb17K5hhauspK2zoXB3gHrDzMqoEtAE+d0VxODNtXQpR5WTm6
AW8PLDJwSd14avoTYLWadMl8bp+9do5ecBS75nxmNnp5gWc0kiA=
=Xk1k
-----END PGP SIGNATURE-----

--Ome6xoXIbCoRvokoosxPpacRPrkLNwvqT--
