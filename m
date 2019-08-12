Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F57C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DFA208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfHLMq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:46:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:4684 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfHLMq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:46:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 05:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="asc'?scan'208";a="375932562"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 05:46:29 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <d3bba104-9a85-df8d-c62d-6acb8913c3fe@ti.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com> <1563733939-21214-6-git-send-email-pawell@cadence.com> <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com> <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com> <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com> <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com> <20190812103147.GA4691@kuha.fi.intel.com> <d3bba104-9a85-df8d-c62d-6acb8913c3fe@ti.com>
Date:   Mon, 12 Aug 2019 15:46:25 +0300
Message-ID: <874l2mtuu6.fsf@gmail.com>
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


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> The sysfs file we expose from the class for the role switches is
>> primarily meant for supporting proprietary protocols that require us
>> to basically override the connector USB data role. The default role
>> should always be selected in the drivers.
>
> OK. Let's take this example
> - Port is dual-role port micro AB.
> - microAB to type-A adapter is connected which pulls ID low. port transit=
ions
> to "host" role by the controller driver.
> - proprietary protocol want to switch role to device role so writes "devi=
ce" to
> mode switch sysfs. port transitions to "device" role.
>
> Now, how does controller driver know to fall back to HW based role switch=
ing?

Use a 'disconnect' or 'suspend' event to go reset it? But that should,
probably, be done at kernel space, no?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1RX6EACgkQzL64meEa
mQZPthAAoPp+d2wATueMi3bs7y0hgbJbVUAfZwIcaCcrj0vG2JlU62N1tNjJhsP/
xLLRKsXs7FKLNR0XjkYA0fhOjJwCkEjgnxEZOi+OdWi22avG4YQOP+UAXcuBLB7R
m95XWGOjvW3Tpfh6Fc3F3cmrdbNhMP/+EA/tsdIKEtDZsNkJtWNAFVCnb2pwuaC2
5oEsqDDgCeTDqNPqSH8T2Afkshwfr/rP7pQBunObvZdohJkR4FPteOnoVlFXIkrD
FxBMrIs27xhPywv6U/OeQoCWbvSxnixEvpN7yZzAtZHBt0CuS9w2MvTXQ0l/5Guy
+tAuTdtT+g+Ypaxtp8VoO6SmohDO959TEGYm3OuITelPZKdM9rilRXp+agqWqCuD
M2qfyD0z6AertZ/XzAESt1MHbpZLWxS2CY9QpDmd5RBM0HyS8TnlYNdXpQYpVi+q
FrCqsew6ndcdFG0sr5i5aP5PyidrqMXJeV/hy3MVxbVq2CJATxasC36+ec0oagNO
zkmg0zEHB+Kte/tf+QTGCaYZGjWbObPH++m+phTJpO2UN4EU5hcO0qu1AXTGBdEF
Qnd1alBJim0s5KJ9+E2CUk7s/9l46f4zeTrCoxRtsbSQiBRPQR/SQcdUBRUVFvxW
mPkQlndf37HU1ieYbdm6jC1SkUxtLJmlnv61PJ0I8M8CHwF36Lo=
=A2Hp
-----END PGP SIGNATURE-----
--=-=-=--
