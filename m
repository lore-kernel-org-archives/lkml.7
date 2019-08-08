Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FADC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D2F217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbfHHSfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:35:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbfHHSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:35:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78ITgIS164493;
        Thu, 8 Aug 2019 14:35:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rep1rdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 14:35:19 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x78IUZLY167988;
        Thu, 8 Aug 2019 14:35:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rep1rdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 14:35:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x78IVYI4021338;
        Thu, 8 Aug 2019 18:35:18 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w78wmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 18:35:17 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78IZGiR35782982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 18:35:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA4CABE054;
        Thu,  8 Aug 2019 18:35:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26499BE058;
        Thu,  8 Aug 2019 18:35:15 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.40])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 18:35:14 +0000 (GMT)
Message-ID: <6ce7545a7a83e8d92fe09110b7f47de7068262fe.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] block: Use bits.h macros to improve readability
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Thu, 08 Aug 2019 15:35:11 -0300
In-Reply-To: <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
References: <20190802000041.24513-1-leonardo@linux.ibm.com>
         <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jW/MQpPut0s05Z/ZdqZw"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jW/MQpPut0s05Z/ZdqZw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 21:18 -0700, Jens Axboe wrote:
> On 8/1/19 6:00 PM, Leonardo Bras wrote:
> > Applies some bits.h macros in order to improve readability of
> > linux/blk_types.h.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > ---
> >   include/linux/blk_types.h | 55 ++++++++++++++++++++------------------=
-
> >   1 file changed, 28 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 95202f80676c..31c8c6d274f6 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -9,6 +9,7 @@
> >   #include <linux/types.h>
> >   #include <linux/bvec.h>
> >   #include <linux/ktime.h>
> > +#include <linux/bits.h>
> >  =20
> >   struct bio_set;
> >   struct bio;
> > @@ -101,13 +102,13 @@ static inline bool blk_path_error(blk_status_t er=
ror)
> >   #define BIO_ISSUE_SIZE_BITS     12
> >   #define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
> >   #define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE=
_BITS)
> > -#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
> > +#define BIO_ISSUE_TIME_MASK     GENMASK_ULL(BIO_ISSUE_SIZE_SHIFT - 1, =
0)
>=20
> Not sure why we even have these helpers, I'd argue that patches like
> this HURT readability, not improve it. When I see
>=20
> ((1ULL << SOME_SHIFT) - 1)
>=20
> I know precisely what that does, whereas I have to think about the other
> one, maybe even look it up to be sure. For instance, without looking
> now, I have no idea what the second argument is. Looking at the git log,
> I see numerous instances of:
>=20
> "xxx: Fix misuses of GENMASK macro
>=20
>  Arguments are supposed to be ordered high then low."
>=20
> Hence it seems GENMASK_ULL is easy to misuse or get wrong, the very
> opposite of what you'd want in a helper. How is it helping readability
> if the helper is easy to misuse?
>=20
> Ditto with
>=20
> (1ULL << SOME_SHIFT)
>=20
> vs BIT_ULL. But at least that one doesn't have a mysterious 2nd
> argument.
>=20
> Hence I'm not inclined to apply this patch.
>=20

Well, as a newbie, macros like GENMASK(a,b) look way simpler. I to read
than (((1 << a) - 1) << b), or (~((1 << c) - 1)).
I mean, in GENMASK all bits >=3D a, <=3Db are set.=20

But I agree that once you get used to reading masks created with <<, it
doesn't look that harder.

Well, thanks for this feedback.

Regards,=20
Leonardo Br=C3=A1s

--=-jW/MQpPut0s05Z/ZdqZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl1Ma18ACgkQlQYWtz9S
ttTe9hAAjhtl35pbIXslE/8abzIr6IPh4aKByZWmQGSyN+6XVatGy7ScXCRCKT39
0Gq2Xh/DTSJYrSUYEKlYuz8enNxuJpl7H7hFoP5tabUlr8eOxYPH0IirduYuCDvx
in5iJU/62UBGxcANhyFWD2MFoEcPPSATI+dUAHr1Uq9vGlVOXWW21JDRe48Q8VbI
UsRw29RHBJDzqq7tHX811nkn8Pv8e/iMaD6KheD87IdIwdSscmRpORc+nOdUH9t1
dsp7h4KhRlcpl+IAwmGf4bhy0aWvr2VuwYE6tSPYa1BgUeg29q0Cd4pXt6a03BLT
eNOKiz5RXY06aTpUW+CcfvhooKWEWdxjVpzRpdjXcnp+rYQ4tmsrSyyofRBgjet4
9DrQCelgHBwPynqs0BSvwwP66yiSjQR1aRmu/SoykSqdhehhGqm4qWtJnRhJd5DH
gr8/f43rFec8Ms5Fo9IOMzLjA331MVHwPhuW4j54FH5cM3DSuKx4AcWj53aEuqCH
cJF+IhkmHbnA1N12bmY3zX24gCm+G2OdhrlkuxecN3IyUyk7hH30gwofM55HXpRH
xwbPLkQlzlaaiqTbP9XsjhPwfyjvg6DCFEgu7Ip4TrGOJlDmWUrc/VYWld+XaBoa
eJX1+6ioGpy7kHgeSk8Xhp3sHa9cHR8MTFYvPpog1kfFzTmX86M=
=f8ZH
-----END PGP SIGNATURE-----

--=-jW/MQpPut0s05Z/ZdqZw--

