Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9145DC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C51521738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="fTgcRVc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDDG3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:29:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:24376 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554359354;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TWOuqIAYnWnAAX/SrCaBGBo5LU8X1ZuLAepkUJVZeVc=;
        b=fTgcRVc1FFfcNqblZt+cYLw+OeksNQ+TkUBpe4kYUOupq7WTOAi3dP3eh4i13olhdK
        mu5jTqUkcdMSSE2SLiamRzeQyCGzEV5caBOv+0UbUV1wFe31V6QkCwYvOoWaZ8JaJNWz
        dRZd1v7Wvsr5ykh4LbYgp77ov+4/RYbHRDTfZXO5Kap6wzM9Xqu9IaMkmVkpMzvjHmAR
        HcR6Oj3n7xwY2Nyml38bRjoBAWRMPoZZyb2ALPJG3feKUdQB5po08efwoSNcS4LyjQa8
        MtnN8xcHAgGXH/0mpim8/fLW++gDJEnWNrh6HdR5nXI08ICYnlVEPvrwSGCX3h4uApd3
        ocUQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGHPrtwDOsr48="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v346TArbI
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 4 Apr 2019 08:29:10 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190303153201.440ac325@archlinux>
Date:   Thu, 4 Apr 2019 08:29:12 +0200
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A50A918-61AB-4710-B9DA-DF041A898944@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com> <CAHp75VeMTd32S+bTgU2f1AS-NB67iuM+erT8qNJgPS7O0E1Cjg@mail.gmail.com> <20190303153201.440ac325@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> Am 03.03.2019 um 16:32 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> Thanks to Linus and Andy for reviews.
> I've picked up all but they documentation patch.  I think
> it is 'very nearly there', but would like a few really minor
> tweaks.  Seemed silly to stall the other patches on that though!

Seems they have stalled elsewhere since they did not yet arrive in =
linux-next.

The documentation patch is still on my todo list and will need a little =
more time
but that should not block the others.

BR and thanks,
Nikolaus

