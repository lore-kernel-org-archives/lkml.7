Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9AF20678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfDYND4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:03:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:42337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfDYND4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:03:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 06:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="asc'?scan'208";a="226593208"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2019 06:03:53 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC endpoint
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24E7D8F2@dggemm526-mbx.china.huawei.com>
References: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com> <87tvi2juh4.fsf@linux.intel.com> <678F3D1BB717D949B966B68EAEB446ED24E4CEE3@dggemm526-mbx.china.huawei.com> <87o98ajso9.fsf@linux.intel.com> <678F3D1BB717D949B966B68EAEB446ED24E7D8F2@dggemm526-mbx.china.huawei.com>
Date:   Thu, 25 Apr 2019 16:03:49 +0300
Message-ID: <878svys0cq.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


(please, avoid top-posting)

Hi,

"Zengtao (B)" <prime.zeng@hisilicon.com> writes:

> Hi balbi:
>
> I got this issue in the UVC application, and I think this issue still exi=
st in the=20
> latest dwc3 driver.
>
> And we should issue an stop command and the queue is empty when it's=20
> ISOC transfer, otherwise we will end up with MISS ISOC error for all the=
=20
> upcoming transfers.
>
> So I think you can test the UVC application with the latest driver.

right. Then what do I do? How do you load the driver, how do you start
the application? When do you plug the cable?

Please, provide exact steps so I can try to replicate the problem.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlzBsDUACgkQzL64meEa
mQaZXBAAwKJa0FMOB7+f02bktLuU5i+vLrmTbXoojizgu3L18mKmhsv3H7oqSXFQ
avSmiMrb1f/Wx0nYYAWC1m6U2l4ce13PjGHQNzUx6zdT/PrajxldDERsEZI+q8PE
LU+7O0qxEUbLbuWCrwivbrOj4JKu9bZ0jTuJsvFgR5GgBc0uKudL+2jYXeoskDF3
RxPMp3vxjMZfatS4EVK53bUlvf5g3ezYJ1uypcoGtSlVlRZXR3VFRD9LE7FJUpMd
gLT6ujqb5PLCoSXblvU0zw+XlP/yL1SyZBXkNzM2Rqhal2qCMABphZtoDsJx1xME
YEY6z6XaDPCK3u7oN0BGuzcuVWSeB9JSN+aIpU7Ga371lFz5h1PZyg0+FxlZCCri
xsEnlNZTek0Rg9YqS4AH0lFZmmdFvsACg2qGiQis9GAzgl0BL2trETw/WImfR9gD
Hl7QCILVTLIxnqu+YjXJZUTpqD3oHz/JePLGs5iiZFpwYKA/+eeMOchOtmdZ++nP
csWZVjOSOWBBNclIeXR52/UN6J1dEd3qy/vX8wACF+Dabv6Juy4hZF3M15Rynv+X
KuC0E3HN4r0C5XH3iYPWSjiUfcKF7LsG0y5FlTiYR0SGyM53Q1Ft3s62TEZVqwCD
g7b7v/EiLwcNqge/+kZs1Q9330DzVdkTOb4Etlxz6p5h3BcSXpw=
=ye3h
-----END PGP SIGNATURE-----
--=-=-=--
