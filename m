Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1CCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D205020717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572340275;
	bh=8olqGy9qmOQsHA04ER0LoXI8Hzfyrjkyg8xZq08EKiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=cZBuIc6ww1CaFXfB3dCizWkxZ8XyAupcg70dyqs4TnBDdDyRpUavG06nTA/aHIvQM
	 nbMbYjCjimXs9FINm+7Pt6KDbpQIjcUEK60mGV1ktGxFXPStjn4dIqGyzIwfNSvMjh
	 KZbryRsole8R4/YqrpcBbN8PN7npMf1w3f4xNsFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfJ2JLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:11:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:44164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfJ2JLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:11:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="202783715"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 02:11:07 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <20191028215919.83697-4-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:11:03 +0200
Message-ID: <87mudjj4rc.fsf@gmail.com>
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

John Stultz <john.stultz@linaro.org> writes:
> From: Yu Chen <chenyu56@huawei.com>
>
> It needs more time for the device controller to clear the CmdAct of
> DEPCMD on Hisilicon Kirin Soc.

Why does it need more time? Why is it so that no other platform needs
more time, only this one? And which command, specifically, causes
problem?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24AicACgkQzL64meEa
mQYaqA/+OB/r78C0rDjXgoGomfNuuSQzH6z0iDzT87zhG3UKI3pBK+tMVxd6ZUnH
viHkHF2xumDwnFUrCTnZuoKx6xP6n+EUcRUqqX803mXlhpthOjLvgmxCwN0CDRfG
2Jk6oo2XHcVQWTv00Ku8wwbYh2aL35TI0aXTtROPEmjb3hcBJE2rjfLoHHLnrj6N
dH4lnrW0y2F7nGh1GS0UrH10lqRWwTZgS7qcpArGupALme0kixnF1NJKdfP5zG0T
seUGdarHvh16923Sc4w7gHzDKXnqjntK8xDQAlHPPQp2HaKGtDW3piMSNBFroEmN
jRvaFd7m4qcp/CURLQblfPTfh7qB1D1fOcH4rWzSMXbNLAE9//LnEEZ4h/x5qvbe
udj/S1w+78PtyWHkzhq8UDSxsPxzZy/NPZLOTMr3qXOHkJsK5ke1pP4DYGl460ar
LFmMXoHPxscXJnaabbxPlhosKzfaS5BSBlyvWEIT0qwe9NLLF6VQ9rVwfVDP1HjB
gS0e8wXqsn8R75OYbGdpdtBiqRupGO5H+6tUZOQFDJnuR7vYbCtvqsOSFkXzl729
jNt3s4tn3xauSu+ij9GGGuZtYMRSIJ4EKVvZCIXpgf1k0ft0+07R/G7nGuhiLv7X
WtQlZlpYmjxMODxPGyEzNOt4B2TfE4hxPbzPbtgTNxnQErjJ6fo=
=04ci
-----END PGP SIGNATURE-----
--=-=-=--
