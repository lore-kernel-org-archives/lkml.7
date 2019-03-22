Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F888C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC35218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="f4AZX8mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCVF2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:28:53 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:43268 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVF2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:28:53 -0400
Date:   Fri, 22 Mar 2019 05:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553232529;
        bh=NjhC7nEplMDnGa/sH2KIWG3FL8yXUd+OqTgLzK48IXM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=f4AZX8mb5BHsB9Rq6tU3x+VlbCDpky5pNj/LoT1RiGgOs+wRI4agmOB92G/itLAKg
         0Ma5rnGm/IVczXZRQNXQWorHrAowL3jSx9Liwx9VRMYM7ORIx/PiQ08DmunUOmAA7/
         qIq9X2g9dtGKhzXxTW4iYdliO3GvvkSt/6dJ5I2c=
To:     Leo Yan <leo.yan@linaro.org>
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: Re: [PATCH v4] perf tools: Add missing case value
Message-ID: <d4UkZ-_LsO_rhF_RN_bTZGisCyClzXcpQMjpLqQmvPc0EIsEdEomTDtGqt4Wg0zIVeC-xYTo6LBl8wXHItLINiJILKJtWVgfynMzF7BeUyk=@protonmail.ch>
In-Reply-To: <20190322015935.GA29608@leoy-ThinkPad-X240s>
References: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
 <20190321162702.GA24451@xps15>
 <vZ4GE7nXgr7nfrMHj_pp8qu6onE8B7YfoczBpbm9RA8spzbqAoEmAIT_YJXkGFXgK8tJqLdVBW_1D9D4jQ2Um51V7SWi1ZgIjrMaYxEYzqg=@protonmail.ch>
 <20190322015935.GA29608@leoy-ThinkPad-X240s>
Feedback-ID: idpJ9Qep05LI5f2mQoaoGmmCIit-QceKL6uqbHgV_NOtNjcF0QNi56ai_biFv0uPMue2gAtmoKKy4wfiVgSKGg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------1fef5da3813a03b44951eb72aff0db07"; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------1fef5da3813a03b44951eb72aff0db07
Content-Type: multipart/mixed;boundary=---------------------dfdd195a29d63efb4c8652d4baf1a67b

-----------------------dfdd195a29d63efb4c8652d4baf1a67b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Liu Yan,

On Friday, March 22, 2019 9:59 AM, Leo Yan <leo.yan@linaro.org> wrote:

> Hi Solomon,
> =


> On Fri, Mar 22, 2019 at 12:47:11AM +0000, Solomon Tan wrote:
> =


> [...]
> =


> > > On my side this patch is no different from V3, i.e it doesn't pass c=
heckpatch
> > > and it doesn't apply on my next tree.
> > > Mathieu
> > > =


> > > > =


> > > =


> > > pub RSA 2048/C88289A6 2018-05-09solomonbstoner@protonmail.ch solomon=
bstoner@protonmail.ch
> > > =


> > > > sub RSA 2048/7C5E8D6D 2018-05-09
> > =


> > I created a new branch from `next` for the patch mentioned above. Shou=
ld I
> > have made the patch directly on the `next` branch instead?
> > I ran the following 2 commands to test the files I edited:
> > =


> >     perl scripts/checkpatch.pl -f tools/build/feature/test-libopencsd.=
c
> >     perl scripts/checkpatch.pl -f tools/perf/util/cs-etm-decoder/cs-et=
m-decoder.c
> >     =


> > =


> > The commands reported that the files "has no obvious style problems an=
d is ready
> > for submission." For your kind advice please. Thank you.
> =


> Suggest you to use below flow for sending patch:
> =


> -   git format HEAD~1: generate patch
> -   ./scripts/checkpatch.pl xxxx.patch: check patch format
> -   git send-email xxxx.patch: use git to send patch so avoid any
>     unexpected characters in the mail

Thank you for your kind guidance. I realised that Mr Poirier
had trouble with my patch because I copied-and-pasted it
into a GUI web client. I was not aware previously that patch
corruptions can happen that way.

I have amended the patch and tested it with both `checkpatch`
and `git am` before sending it out. =



>     =


>     P.s. Marc has a good presentation [1] for upstreaming patches, you
>     could check page 16 for how to use the git tool.
>     =


>     [1] https://elinux.org/images/2/26/Getting-Your-Patches-in-Mainline-=
Linux-What-Not-To-Do-and-a-Few-Things-You-Could-Try-Instead-Marc-Zyngier-A=
RM.pdf
>     =


>     Thanks,
>     Leo Yan
>


-----------------------dfdd195a29d63efb4c8652d4baf1a67b
Content-Type: application/pgp-keys; filename="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"; name="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"; name="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjQuMTANCkNvbW1lbnQ6IGh0dHBzOi8vb3BlbnBncGpzLm9yZw0KDQp4c0JOQkZyeTVGWUJD
QUNWZG9oN1pvYnFaMTI2RUFPVDNjaktZalVIMURtQkxHeWEvWmxQV0xaVVBmMjkNCk5aMUduSHcx
K0ZnYXZPODRPY3ZPK0RORm51eVllUG9ZM3NsaVVwNWpPT0xRNHhoQmVIL0U3ZWgybDhUVg0KdW9t
ZFZLK1hsQ0NzcGFXZU9BR3ovSkt0dDgrV0RtbytsOUsrQTNHcXdnZHZPTjI3dTA0L3VYd1MyeE5W
DQpHQWhBY0RVVGZBL3NMNTdUbWV0NU5KNXdoZ0dXM3d5alNPOSs0Zkw4aWtXaDlBMGJvL3BxVFo5
L3NFTVcNCjdTOGllYXUxbklKUER5ZXBzeTU4TnE0ZFRnMTBIVll5WkMyZTdER0x4MXR4YzVPeE81
V3hJcTgwazJXdQ0KeFhqRFU5aVhPT2I1ZElDeDJZSExTTGZmdTQ1VGw0bXBVam9tY3F2WFVZdmpM
NEZYRGszTWtTVFhBQkVCDQpBQUhOTzNOdmJHOXRiMjVpYzNSdmJtVnlRSEJ5YjNSdmJtMWhhV3d1
WTJnZ1BITnZiRzl0YjI1aWMzUnYNCmJtVnlRSEJ5YjNSdmJtMWhhV3d1WTJnK3dzQi9CQkFCQ0FB
cEJRSmE4dVJXQmdzSkJ3Z0RBZ2tRNzdSbg0Kck1pQ2lhWUVGUWdLQWdNV0FnRUNHUUVDR3dNQ0hn
RUFDZ2tRNzdSbnJNaUNpYWIweXdnQWxBemthWVZSDQpDMHFvL0lhY000NXRVVGJyTnlVYmVLeUds
Mi9tTU9ma3JOTDcvcTBWemtxcmJxY2NTWjRzUVVta25IYU0NCk1Cdm1STnJiMXR4elNkTlZuS1ZQ
VlJRSGE4eDlDcDVUQnhBTFV3NDdHOW81SnYrYVNueHRwWEFMSldldA0KbUt1WWlSaHRzUWxBazlF
RlZJYzY3ajkvK2s5bkpTUkRtWnRLeU9jOGhXZkxjcFlGV0s2UXFLSWt1NG9xDQp3d0xFRzE0T0Nl
c3VqV2E4Sm9iVy8rb1Irelh3QmJCOE55dWRGSm13b0FYLzdud2NTSlZ0bGRZeUdYbWoNCkt1VFFp
eFJpWFh1TjhsNHBSdGRRdUdGdVhERjM4WVRrMDlNYyt1SmdjaVRZYmNSL3pmMGRhUktVbDB0aA0K
RzBOVE85YzErZG02M0FHWjdMSkJIOFB1N0NrMi9hT3d4czdBVFFSYTh1UldBUWdBNVZWdCtKVGRa
VXhwDQpuZSs2dzljSE0zTzY1Q1ZzcWFMNkI4VCtBcVF6a0VJbGJhQkI4RlV5citGa1BZZGRiNGVw
SjlQVHNJLzYNCk1jeThTRTdWUUVuU2NuYVQvREtkbk1OUXJibngrRWgyM2NWNFNJVncveWVBT0hP
Z1BvT0dHekZmVk0ySw0KZkVhQjJvTDk4eThNcUlRLzNEak9CYUpwZFdhQS9mQldEcVJ6aENqQzhX
MkhndDIvRElQY2JWalpISUFtDQptZXBGSWo4R2JLZDhOVjhYVU1QcUtjWEVNTVZIdW1ndHNSVVBX
eE9DN29wZjI3WmFLcjRteVd2NFdCVDANClo5RzAzT2VLUmEvU3ZoVUlYcjVMZzRyaWpkbTZWMVFL
aFpvS3R4Wi9RR0RqdDg3dUtQb0M1ZTNwa2tQYg0KOXlvbHNFQVQ2U0xRcDd2TEVwWjRlUjFmd1Ju
eDV3QVJBUUFCd3NCcEJCZ0JDQUFUQlFKYTh1UlhDUkR2DQp0R2VzeUlLSnBnSWJEQUFLQ1JEdnRH
ZXN5SUtKcGk5N0IvOXhYU3VMRjc2QUd6ZWtwdFdiTVo2eXVYeWQNCmZza2IwL0NjL0xjR2tMV21V
Y1hkbGRLWVdTLzg3ZXZTalZXZTFTbUhCQzVrZWhvVXp1bEpCZmx0SGpqMQ0KcVZCTWY0eHB6ckVz
aGFCWUNxbllhTnpCa2NINlFINGNRT3cvMUw1WTZ5QjRPQVZGQjJ2d3UzN2dSNUJ4DQpEQWN2NHFD
b1lvT1ZDRklDRFprV3lQWkFReFNLb3hHd3BXK2ZNOTdXOXBwV0Q4WEw5b2RlU29UVmN6a0INCnJK
WTFrakltUnhONU5wMkg5UVRKY0EyMHNQNDJ0VnNQVzRuaC9HYkQ4cmc2Tkl3TFg3RWJVWkh2VjJE
Mg0KRDJxRThSM1ZNTGNob3BSbGFIQjVHU1AzNWxpTkVuY2tKMmV0dTRUWVY4SXB6NkNseW16TnZy
RjR1MkhkDQowZktFU0hRM2U3SEVWMGpQDQo9TTRBNA0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkg
QkxPQ0stLS0tLQ0K
-----------------------dfdd195a29d63efb4c8652d4baf1a67b--

-----------------------1fef5da3813a03b44951eb72aff0db07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail
Comment: https://protonmail.com

wsBcBAEBCAAGBQJclHKNAAoJEO+0Z6zIgommx+EH/jvvHnsS+F2JRDoNXKrE
6u8KmunLz87T2bKXJBBR4CCFq5otmDaMgXlDZIWZHy4v6z1IgGPb14KZ1yon
yR+UUhq1mttRK+TaO86AqwwzV5cUpeTSP+8K3UN8BHltcuymZTkg/uAeQWpw
6iWK64kruSGKHyjxBwOF4HiIqBScZmOGEyhJuFmTx/WncapPbDrXuRZ6MsKf
8oZ8L+Nt7WB/ZMc539Vze6TcY9PV1xb2XqcvMC2/aKDDR7+x3zquhbHGlEnX
bO3p0fw+/IrqXCrn5ba1lQ9EN8yZRGrm+SADUvdBdMkvC7oONf9sGKZ4S5Xa
e3ZwTyvj+bM0oND4+QjLuWw=
=cgXf
-----END PGP SIGNATURE-----


-----------------------1fef5da3813a03b44951eb72aff0db07--

