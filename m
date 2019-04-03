Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D9BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E956020700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfDCGgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:36:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbfDCGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:36:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x336Y3N3051027
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 02:36:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmqmvg789-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:36:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 3 Apr 2019 07:36:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 07:36:31 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x336aTut40435866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 06:36:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7401A52063;
        Wed,  3 Apr 2019 06:36:29 +0000 (GMT)
Received: from [9.145.70.33] (unknown [9.145.70.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE4C552057;
        Wed,  3 Apr 2019 06:36:28 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
To:     Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com,
        david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Wed, 3 Apr 2019 08:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402174636.15175-2-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0"
X-TM-AS-GCONF: 00
x-cbid: 19040306-0016-0000-0000-0000026AAAF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040306-0017-0000-0000-000032C6B48F
Message-Id: <39632665-8861-a386-a1c9-9ce9d081f868@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0
Content-Type: multipart/mixed; boundary="foHmibD3CXfkRlupSVXWPePnqmUFC7JKg";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com,
 david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <39632665-8861-a386-a1c9-9ce9d081f868@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
In-Reply-To: <20190402174636.15175-2-walling@linux.ibm.com>

--foHmibD3CXfkRlupSVXWPePnqmUFC7JKg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.04.19 19:46, Collin Walling wrote:
> Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
> for the availability of hardware support for the instruction.
>=20
> In order to support this instruction for a KVM/QEMU guest, we
> would need to provide modifications to the SCLP Read SCP Info
> data, which will in turn reduce the maximum number of CPUs that
> may be provided to the guest. This issue introduces compatability
> and legacy concerns.

s/compatability/compatibility/

>=20
> Let's circumvent this issue by removing the bit check and blindly
> executing the instruction. An exception table rule is in place to
> catch the case where hardware does not support this instruction.

Great, another ESSA like instruction...
The sclp bit is still there but we can choose to ignore it for a spec
exception.

>=20
> While we're at it, let's condense the version code fields in the
> diag318_info struct until we can determine how it will be used.
>=20
> This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>


--foHmibD3CXfkRlupSVXWPePnqmUFC7JKg--

--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcpFRsAAoJEONU5rjiOLn4m78P/jSthbC12i38yNCo6Zrs35Ox
tY8+so48VneY/3lNvqbKm9+jxDBLwGepY6C2MG3JTDt5ZW00vMmmydXloLS9Dz2N
cmLk4j0B3cBupaPKemzxuA74UpKEXmzPYuafia+ZF2nRnd9u4LhmQWXHhnOXqvIw
vQPRknEbtwMk3ioK4qx1PNhT9rm67oXXtJuC8vrzOZm0U7JTus3V9w4eM1AXzSCp
nN3JdpkMUj5tqrMz81p5oTqeOJzbcfbgqY8hrNXGGXk445ZIWFUNzsYTmsjExcdF
wgzUJIfZ+1SNCewg4VsULrqilriQDTbwGnD5Mol5ozR0dzBmLNjXh49mS4yG+kjX
Jasz+cwIk5CRCJfMe97imfeCL8Kpsm5QnhDFkk0gqLuqyAG1h7R9YmTDy14fcqAB
UhP5SDlYXz7Gt2XCX72R8rDdTExGX1sFPh3xLJeUFvcfIpECVQh/HQ+nf55AQPDS
OjdX5rXoCbsRlleNHM9y0FP2ASRtByJ15IvYuEyxIbRSiZa41beJMYcceG33Wa9p
K6Ej3GfACafZTpll/Pi6PETu7HgNEp3fQnjV1YN2ZWpvUGdhHvYWq9culc/6NGl4
CnAfwprndJLw0ymF+NjqpDPGpfEFYInCGC4luKb05dvq2UoVcx1TTCQ82f6PnYuV
1eL06BpUbRgdpk74VeBg
=ETJE
-----END PGP SIGNATURE-----

--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0--

