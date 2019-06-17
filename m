Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D080BC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BC42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfFQBUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:20:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbfFQBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:20:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H1Glcw048282
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:20:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t5svxsku3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:20:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Mon, 17 Jun 2019 02:20:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 02:20:38 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5H1Kbtp26345770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 01:20:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47ECAE057;
        Mon, 17 Jun 2019 01:20:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54AB1AE05F;
        Mon, 17 Jun 2019 01:20:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 01:20:37 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 81114A00D4;
        Mon, 17 Jun 2019 11:20:35 +1000 (AEST)
Date:   Mon, 17 Jun 2019 11:20:34 +1000
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        virtualization@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] drm/bochs: Fix connector leak during
 driver unload
References: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
 <20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19061701-0008-0000-0000-000002F44852
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061701-0009-0000-0000-0000226157A3
Message-Id: <20190617012033.GA1151@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 10:10:29AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> The bug is in the driver, so ...
>=20
> > Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
> > 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up help=
ers.")
> > ... but the issue also seems to be due to a change in the generic drm c=
ode
>=20
> ... this one is the culprit and should be listed.
>=20
> > (reverting it separately fixes the issue):
> > 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in dr=
m_atomic_remove_fb, v2.")
> > ... so I've included both in the commit.  Is that the right thing to do?
>=20
> That only triggers the driver bug.
>=20
> I'll fix it up on commit,
>   Gerd

Sorry if I misunderstood, but were you going to take the patch and fix
it up or would you like me to post a v2?

Cheers,
Sam.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAl0G6tMACgkQMX8w6AQl
/iJjVgf/T6KF8XcN9Z/Yppy+tUW0hD9031/YPdlJJ7slrFUkPrEcVSxARY1J32SO
f7Vdc6de427aF9P33QULxkg/rqAbdVYTuim6s3BQUPax7JYmkfviHOKUNPVdDlN/
BUBpEPqkanHxn8KKBSd4OdKWpek/20RTAgM+Vg5jwhN8jtLNHbrqXQf+z3ll1SS/
9iHxA/KH8/lBv1RH2AfbChumNz/dNioxMoZizPOxEZbu9G8tfDb40q2HBfLD8lXk
aCdFb8P6d37bkR1xn51HKqGgChbL6orlfiVuT1goYLB/MLxDvHn+9G5yywcwLjvp
zWJH22IKznWBtuRpaaoTunVc4UPd+Q==
=snbg
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

