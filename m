Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F804C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE4B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCGKXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:23:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40693 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:23:33 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h1qBW-0006U7-4V; Thu, 07 Mar 2019 10:23:30 +0000
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190302230637.8624-1-colin.king@canonical.com>
 <20190304063623.GA15253@mtr-leonro.mtl.com>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH][next] RDMA/nes: remove redundant check on udata
Message-ID: <815dea03-ef9a-39c0-3ec5-cdd58a545911@canonical.com>
Date:   Thu, 7 Mar 2019 10:23:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190304063623.GA15253@mtr-leonro.mtl.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="myIfY0JvAYSBM2eA8Dl78STvQBfRD0KHQ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--myIfY0JvAYSBM2eA8Dl78STvQBfRD0KHQ
Content-Type: multipart/mixed; boundary="V9KKqdNrC9BAndZvoI3I7vIj8KsaMunRc";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Faisal Latif <faisal.latif@intel.com>, Doug Ledford
 <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <815dea03-ef9a-39c0-3ec5-cdd58a545911@canonical.com>
Subject: Re: [PATCH][next] RDMA/nes: remove redundant check on udata
References: <20190302230637.8624-1-colin.king@canonical.com>
 <20190304063623.GA15253@mtr-leonro.mtl.com>
In-Reply-To: <20190304063623.GA15253@mtr-leonro.mtl.com>

--V9KKqdNrC9BAndZvoI3I7vIj8KsaMunRc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/03/2019 06:36, Leon Romanovsky wrote:
> On Sat, Mar 02, 2019 at 11:06:36PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The non-null check on udata is redundant as this check was performed
>> just a few statements earlier and the check is always true as udata
>> must be non-null at this point. Remove redundant the check on udata
>> and the redundant else part that can never be executed.
>>
>> Detected by CoverityScan, CID#1477317 ("Logically dead code")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/infiniband/hw/nes/nes_verbs.c | 73 +++++++++++++-------------=
-
>>  1 file changed, 34 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniban=
d/hw/nes/nes_verbs.c
>> index 828e4af3f951..526092d435df 100644
>> --- a/drivers/infiniband/hw/nes/nes_verbs.c
>> +++ b/drivers/infiniband/hw/nes/nes_verbs.c
>> @@ -1039,53 +1039,48 @@ static struct ib_qp *nes_create_qp(struct ib_p=
d *ibpd,
>>  				}
>>  				if (req.user_qp_buffer)
>>  					nesqp->nesuqp_addr =3D req.user_qp_buffer;
>> -				if (udata) {
>> -					nesqp->user_mode =3D 1;
>=20
> It was single place where user_mode was set, you should continue and
> remove all code which depends on "if (nesqp->user_mode)".

This is not the only place where user_mode is being set; we currently hav=
e:


        if (udata) {
                if (ib_copy_from_udata(&req, udata, sizeof(struct
nes_create_qp_req))) {
                        nes_free_resource(nesadapter,
nesadapter->allocated_qps, qp_num);
                        kfree(nesqp->allocated_buffer);
                        nes_debug(NES_DBG_QP, "ib_copy_from_udata()
Failed \n");
                        return ERR_PTR(-EFAULT);
                }
                if (req.user_wqe_buffers) {
                        virt_wqs =3D 1;
                }
                if (req.user_qp_buffer)
                        nesqp->nesuqp_addr =3D req.user_qp_buffer;
                if (udata) {
                        nesqp->user_mode =3D 1;
			...


and I'm just removing the redudant 2nd if (udata) check, so the
nesqp->user_mode =3D 1 assignment is still being kept hence it's not
correct to remove all the if (nesqp->user_mode) releated code.


>=20
> I looked on the change which triggered Coverity warning and looks like
> your commit message should include this Fixes line:
> Fixes: 899444505473 ("IB/{hw,sw}: Remove 'uobject->context' dependency =
in object creation APIs")

Can that be added to the patch before it's applied?

>=20
> Thanks
>=20

Colin


--V9KKqdNrC9BAndZvoI3I7vIj8KsaMunRc--

--myIfY0JvAYSBM2eA8Dl78STvQBfRD0KHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcGLapPABucZhZwDPaMKH38aoAiYFAlyA8SEACgkQaMKH38ao
AiZLhg/8DCRIoCDwHqdfnn7+FxVJzm2jnhm/Dm43Pygc4v6bIVuMiNtIKYcoj/S8
XvZri29vTgth8VZBLx9oeAwkEWD/8QOVEPpvf6IBFZljEWlwRNyLKl/dkSsnOt3a
IGH5TZntsieXELKeyFD8FStjOlU8A0klSakB3x57a1uvsOrT905ui/852ONi0/rg
DPLnHdmMNxJdNGHbOFALMDDXiWthHX07Rj0c9P2WYgauTE80++uln08PfrVgYLZ9
Jz6xTDb/RXhc75RRofLUGaBgfJlhI97UyfNBCXR3JdEUGGwsZkLyqbBSEOrkvBVX
Nj0Vk5zRE1q/ilwwLfX6MbWEeHY4tZG2vh+nVUMFKwnSbqlLo2PBzWCMBK0b2/4i
7W1MaVXxWYPkt1NqtfLbkVJlhND9rFIcgAfe5YQkGVkoSXqqp92t06EXrudfkVXX
H6kYvAy8is3btUXVMKts1MJcF3XdQJ2Iua88Yeq3SpQefts8fU74HGCej6bQ0cV+
oQO0p4sTWd6d8kqvSZvAr03VgJYa3XK9Wxz6FK3KpxXfVQVBJ+OTzNF/l1Zq5uvh
/R9EvTNur4Bc/FIQVmgPtpcJov1CFuE9YvTBAE8fDnSj0HJ51Zg3ANKyd7YXGuij
CGpkr5m/q1DE5pfh8YHJaQRsU99PEomeeMvlfp8uSj64vfMJxss=
=F1uf
-----END PGP SIGNATURE-----

--myIfY0JvAYSBM2eA8Dl78STvQBfRD0KHQ--
