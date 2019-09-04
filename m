Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15374C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62562339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567577994;
	bh=+xqUmCMNDYvLWUy++UUoGPGCLbUYeJcWoNYuROUEpzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=UWpIfTgmzqqY5cw6efPWnHlbREUAx/ZsSShKMHAzhsQYeNCIEPsoMHzrzAp3UNvdo
	 NzTiPZtgS/8UQvRDSspBdo1llR5gw9439YqKlkoyGhsA/qnsrRqk1WTWzdUHM3qztn
	 hAzrGxCH2MextS3RfTsFV2PkbCSLVukDLRYqeZRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfIDGTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:19:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:38375 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDGTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:19:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 23:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="asc'?scan'208";a="207356287"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2019 23:19:51 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     "Kobayashi\, Kento \(Sony\)" <Kento.A.Kobayashi@sony.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cao\, Jacky" <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
In-Reply-To: <OSAPR01MB49300F8CA0956F031CA4B1ECC9B80@OSAPR01MB4930.jpnprd01.prod.outlook.com>
References: <16EA1F625E922C43B00B9D8225022050086ECF6A@APYOKXMS108.ap.sony.com> <16EA1F625E922C43B00B9D8225022050086F86B4@APYOKXMS108.ap.sony.com> <OSAPR01MB49300F8CA0956F031CA4B1ECC9B80@OSAPR01MB4930.jpnprd01.prod.outlook.com>
Date:   Wed, 04 Sep 2019 09:19:41 +0300
Message-ID: <87v9u8mvlu.fsf@gmail.com>
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

"Kobayashi, Kento (Sony)" <Kento.A.Kobayashi@sony.com> writes:

> Hi,
>
> My company's member, Mr.Jacky, sent patch in June 26th.
> But we didn't receive comment about our patch.
> Could you confirm and tell us this patch is needed or not?

I can't find the original patch in my inbox, could you resend it using
git send-email?

Patch seems necessary, indeed.

best regards

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1vV38ACgkQzL64meEa
mQbnrRAAz0r8jcUBfL99Ca7PPl2wsF41zZW4+FepCIfSqfiPhDoMFuacv/JCc5ba
jOUlfX9r65wY992hKAOR7htEEvAiR7eMJW0WyPSXB3LnL0QpHTbevBVZb1NT+1wk
hkTLSVSV1vo24uBtxzw5HfmVXzUA995ZCRJONSUpuInEI8aeBSOz2bNNsXMAx8QU
NMLL/kbrmbgPRKOpdzMH3jslpVYd+Ichmnufs/ERTepqGGefQOwRb7MYKvwVtZer
3pvPmoh4mXEcV9fQuWbpRcelFQmWK1HMLnJ34hKvofcYDiWMcCDXmOzMpiq/62+B
a5LKtXyU1rEvt2g+TZgH2MTAsQJDcsJRT3U5j53eClmsk9bjzOMr5BhzgH7J1BBV
8zK3cvFUBZpUrpqcHjWugJZmSCiNsfascYLNM50L5esrOEi3jUMGblGHE1wkCh6a
JPUX4qN6dMTi5KEjO8pWDHWl4KzM4Wlu59MozdtP45hszEtcoy5nnxoatRhqJlcS
53Vl5ZJ+rBDin0IxX43866tm9AB3MSQriX+fGff86jfDpFDEml0iiPJ5LDKZsO2u
Oua+czwSWuwZOTdS6n7ppCYBGFpLC5zxIxoJFH0xE7LfEVCFGJBfO845RGQq8E/X
uaYTYadKUzIX7GVrP9/ya2bV1BHWH6Ve9Xpzmrb0d79W6ni62ls=
=NyAQ
-----END PGP SIGNATURE-----
--=-=-=--
