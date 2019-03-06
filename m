Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2317B2063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCFSlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCFSlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:41:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 227D21310;
        Wed,  6 Mar 2019 18:41:01 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B62CA1001DC5;
        Wed,  6 Mar 2019 18:40:51 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
 <20190306133613-mutt-send-email-mst@kernel.org>
Organization: Red Hat Inc,
Message-ID: <7a77ce2a-853f-86c6-6d10-1d8db8fb8ae4@redhat.com>
Date:   Wed, 6 Mar 2019 13:40:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190306133613-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d59HHRy06H8yetGwTxlr6wgZT5IDIwPC3"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Mar 2019 18:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d59HHRy06H8yetGwTxlr6wgZT5IDIwPC3
Content-Type: multipart/mixed; boundary="L34uAfN2VceX4UnGRao0Vn0YL6JKt8BRb";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
 wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
 david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
 dhildenb@redhat.com, aarcange@redhat.com, alexander.duyck@gmail.com
Message-ID: <7a77ce2a-853f-86c6-6d10-1d8db8fb8ae4@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting

--L34uAfN2VceX4UnGRao0Vn0YL6JKt8BRb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 1:38 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
>>> Want to try testing Alex's patches for comparison?
>> Somehow I am not in a favor of doing a hypercall on every page (with
>> huge TLB order/MAX_ORDER -1) as I think it will be costly.
>> I can try using Alex's host side logic instead of virtio.
>> Let me know what you think?
> I am just saying maybe your setup is misconfigured
> that's why you see no speedup.=20
Got it.
> If you try Alex's
> patches and *don't* see speedup like he does, then
> he might be able to help you figure out why.
> OTOH if you do then *you* can try figuring out why
> don't your patches help.
Yeap, I can do that.
Thanks.
>



--L34uAfN2VceX4UnGRao0Vn0YL6JKt8BRb--

--d59HHRy06H8yetGwTxlr6wgZT5IDIwPC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlyAFDIACgkQo4ZA3AYy
ozlq2g/+LuhyTg5EE+QuRY1swFfvQ2XtYUvty6CPalWpGrt8mBo2479Cbj4q2sTk
MgwZzoIo5p258UcuvpapIQDdIV+J3j7i2y6Wxdqt/9w8O7WkGWXVtBPvmBEL8BjT
2FVEqK18NsKPnxF8O3dWqZynQmc0R0eucJobrRb312j4bsRHlCbtoU99RydlSls1
3gs1nBRpQb3jmklYqhVhDGjD390QMZTcGA3N5ln53oNghXrSONhH1q28ebPt8X12
rbPrRaWEvdXh3IPnlMltHcQKg9fJcNBH1k8xNv0dzrN5eKfvWCm/NZsOJdrimozR
y4rVtxP4EfpesQ1CcIVX6m2dlb/dePLUH/tEqd3R0Xb0A54k99/62E8CClOH4mkO
SDM17WavRCb+wmqoNpPumNYLezhHMS+Ei7UFEQDysOHe9XUz0d0dWg70vmemtjtz
WMxlx4rGg1ZvOjDk5tACjwxN2FqcVBgSZXXT+Jm2qQmj+dlCgIbz4zc9t7sJ7HXd
TJ/DSoktLfHMJF1K/hLCDv2MfhY+W0/Aa0mJXjlxOmSGb34pArpS0bRSDo5H2SNT
EfdTEHR//nlanuiWuHXWslS+PxkiyVdQLTnOx6gr4qLZYZ7FNYSyC0/+gbO9ntzH
blZstB6PYhEAS8itoApMpT9duHDoqegShK+l76N2HKuH4s6miQo=
=cLRz
-----END PGP SIGNATURE-----

--d59HHRy06H8yetGwTxlr6wgZT5IDIwPC3--
