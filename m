Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4020693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="j6K1m1Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfC1Q3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:9547 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1Q32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553790563;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5Se5j4FDEkUJs4EuTLTYu10ap97ESgOvibvj7y4CvVM=;
        b=j6K1m1BuWyt6Dqmvf5Py8jKOD17QueSMBAuSO/JU3PcL66kiuU0234gGWSw36CY0Ew
        2zYEta5ofCMf5SfHTKdEwkd/UH2QusCH6sMqqrC4AQgQyRbd6VQP265qW/jVxjH6Tiac
        OTFWgHsQtHukcKHs3eLvMGcn050HmIEipnV6GX9ZvpXKUjA+0FXMG3cvB7CA74NcSJGH
        aI/59nY2pedNpwcn+c/h5l/eufX30XI9bdo2/+pk5UXLmXoMZBwJCw4cXpeFK6HBOk+s
        eKhswOV9oc9ZYQ4xqR8oHrHVtnTlvmkkOmpftnFzL6h4jy79FGcmzKsduyenzud+bDgf
        W+IQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWdXA0IgQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2SGTFMIN
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 28 Mar 2019 17:29:15 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] dt-bindings: iio: add Bosch BMG160 gyroscope sensor
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190324180654.44289894@archlinux>
Date:   Thu, 28 Mar 2019 17:29:15 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <55464EC0-7031-42BD-A6E0-6E04E3A45FE8@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com> <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com> <20190324180654.44289894@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 24.03.2019 um 19:06 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Mon, 18 Mar 2019 16:14:15 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Define bindings for "bosch,bmg160" and "bosch,bmi055_gyro".
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Simple binding so applied to the togreg branch of iio.git and pushed =
out as
> testing. Still time for a devicetree ack (or to pull it ;) if anyone =
has
> time to look.

It is more or less an adapation of the bma180 bindings.

>=20
> Thanks,
>=20
> Jonathan
>=20
>> ---
>> .../bindings/iio/gyroscope/bmg160.txt         | 20 =
+++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt =
b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
>> new file mode 100644
>> index 000000000000..78e18a1e9c1d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
>> @@ -0,0 +1,20 @@
>> +* Bosch BMG160 triaxial rotation sensor (gyroscope)
>> +
>> +Required properties:
>> +
>> +  - compatible : should be "bosch,bmg160" or "bosch,bmi055_gyro"
>> +  - reg : the I2C address of the sensor (0x69)
>> +
>> +Optional properties:
>> +
>> +  - interrupts : interrupt mapping for GPIO IRQ, it should by =
configured with
>> +		flags IRQ_TYPE_EDGE_RISING
>> +
>> +Example:
>> +
>> +bmg160@69 {
>> +	compatible =3D "bosch,bmg160";
>> +	reg =3D <0x69>;
>> +	interrupt-parent =3D <&gpio6>;
>> +	interrupts =3D <18 (IRQ_TYPE_EDGE_RISING)>;
>> +};
>=20

