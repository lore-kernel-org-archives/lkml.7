Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35E2C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbfGRNCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:02:22 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:36724 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:02:21 -0400
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 09:02:21 EDT
Received: from NTHCCAS01.nuvoton.com (nthccas01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 6FB5B1C80D43
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:51:48 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 18 Jul 2019
 20:51:47 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 18 Jul
 2019 15:51:45 +0300
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Thu, 18 Jul 2019 15:51:45 +0300
Content-Type: multipart/mixed;
        boundary="_000_9c8e216dbc4f43dbaa1701dc166b05e0NTILML02nuvotoncom_"
From:   <Eyal.Cohen@nuvoton.com>
To:     <jarkko.sakkinen@linux.intel.com>, <tmaimon77@gmail.com>
CC:     <oshrialkoby85@gmail.com>, <Alexander.Steffen@infineon.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <oshri.alkoby@nuvoton.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>, <kgoldman@us.ibm.com>,
        <nayna@linux.vnet.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>
Subject: RE: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Topic: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Index: AQHVOvIQ+td4FoJtQk2eh+ryXBhwdKbQVkKg
Date:   Thu, 18 Jul 2019 12:51:44 +0000
Message-ID: <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
In-Reply-To: <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.191.10.160]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_000_9c8e216dbc4f43dbaa1701dc166b05e0NTILML02nuvotoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko and Alexander,

We have made an additional code review on the TPM TIS core driver, it looks=
 quite good and we can connect our new I2C driver to this layer.
However, there are several differences between the SPI interface and the I2=
C interface that will require changes to the TIS core.
At a minimum we thought of:
1. Handling TPM Localities in I2C is different
2. Handling I2C CRC - relevant only to I2C bus hence not supported today by=
 TIS core
3. Handling Chip specific issues, since I2C implementation might be slightl=
y different across the various TPM vendors
4. Modify tpm_tis_send_data and tpm_tis_recv_data to work according the TCG=
 Device Driver Guide (optimization on TPM_STS access and send/recv retry)
Besides this, during development we might encounter additional differences =
between SPI and I2C.

We currently target to allocate an eng. to work on this on the second half =
of August with a goal to have the driver ready for the next kernel merge wi=
ndow.

Regards,
Eyal.

-----Original Message-----
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Sent: Monday, July 15, 2019 12:46 PM
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Oshri Alkobi <oshrialkoby85@gmail.com>; Alexander Steffen <Alexander.St=
effen@infineon.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.r=
utland@arm.com>; peterhuewe@gmx.de; jgg@ziepe.ca; Arnd Bergmann <arnd@arndb=
.de>; Greg KH <gregkh@linuxfoundation.org>; IS20 Oshri Alkoby <oshri.alkoby=
@nuvoton.com>; devicetree <devicetree@vger.kernel.org>; AP MS30 Linux Kerne=
l community <linux-kernel@vger.kernel.org>; linux-integrity@vger.kernel.org=
; gcwilson@us.ibm.com; kgoldman@us.ibm.com; nayna@linux.vnet.ibm.com; IS30 =
Dan Morav <Dan.Morav@nuvoton.com>; IS20 Eyal Cohen <Eyal.Cohen@nuvoton.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp

On Mon, Jul 15, 2019 at 11:08:47AM +0300, Tomer Maimon wrote:
>    Thanks for your feedback and sorry for the late response.
>
>    Due to the amount of work required to handle this technical feedback a=
nd
>    project constraints we need to put this task on hold for the near futu=
re.
>
>    In the meantime, anyone from the community is welcome to take over thi=
s
>    code and handle the re-design for the benefit of the entire TPM commun=
ity.

Ok, so there is already driver for this called tpm_tis_core.

So you go and create a new module, whose name given the framework of things=
 that we already have deployed, is destined to be tpm_tis_i2c.

Then you roughly implement a new physical layer by using  a callback interf=
ace provided to you by tpm_tis_core.

The so called re-design was already addressed by Alexander [1].

How hard can it be seriously?

[1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_20=
19_7_4_331&d=3DDwIBAg&c=3Due8mO8zgC4VZ4q_aNVKt8G9MC01UFDmisvMR1k-EoDM&r=3Dh=
jzIxEsS8wf3Ezr__r0ZOjw3kki8jIlQK-SQ5pWhXaM&m=3DaYs86sTFmxqvlI5rE2AWLGRl0lb9=
XRuiRKVtsCaXdRM&s=3D_3MMoq5UISFwMfK4OfgLbA2kMfZVgEfgkaWKqDEUXGw&e=3D

/Jarkko


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The privileged confidential information contained in this email is intended=
 for use only by the addressees as indicated by the original sender of this=
 email. If you are not the addressee indicated in this email or are not res=
ponsible for delivery of the email to such a person, please kindly reply to=
 the sender indicating this fact and delete all copies of it from your comp=
uter and network server immediately. Your cooperation is highly appreciated=
. It is advised that any unauthorized use of confidential information of Nu=
voton is strictly prohibited; and any information in this email irrelevant =
to the official business of Nuvoton shall be deemed as neither given nor en=
dorsed by Nuvoton.

--_000_9c8e216dbc4f43dbaa1701dc166b05e0NTILML02nuvotoncom_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

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
GyVweSVwalW6dhhQdI5IJzCH4UQDkddI4BhwUXA8kiEukmOEHfeCI2SyPABvPjFpQGSzlPPjhBtr
ZnViaiphaDBjwDFoMFtQQU0wgCB2MqAgMC8yXTOicmgw/0lRaDAlASrTK2Vg00lgKCBWMkJwBTBw
WFxPkkJuB2yTbPgysTExOjA4SW2wN0EnACswh+AwOygQbst3A2AQIDdGPiDdoMFUGaEokWDSeSqi
VoD9CYBiANBMMVDCBbBRwGDH/wtgKPEJcEIAAiASACyma1btoLNEClA0JmEEYFVBXdL/TAMzNT9S
JCE4ETJyLCEQIN8RwAMAHlGh+6BKcANgl3L/G9IfYBhwMJEEICmxGFCn1OZwedColWFzXBM2sI8Q
e2DJCsFmedAIcKR/oLNJ/yaEB4A88QdxKBAAcKGwGFDfHHUmsYjoLCEpsGxrIaX0+2jQGeBvK5Ms
EaBKJbMiQvuoNyXiLVKhRLADoGDWL5D/GFBCUKbTJqI6cTNyJuKI5/lYTU9rQvE0QyeBLCEHQP9g
dJo6LBIeUR5wSpg06mtm/yIgobEpESIzBQBggFsCKtP3BGFswLHBdzawEgCQIbQR/2ZgR9EmkwNQ
wtFb5LkCOEF/RrIysiSxvKUkMwEAC1Bv/SxwZCgROfEHkCVAGFCn4/9FAUlWmyFYTaEAL+HAYgNg
jzbRPVFDt8F1cGh5DkH/JYEsUz/CPgA4QjXBvhKiQ/8wmKsRHWABAKfjwGI/0b6P78kLu8K+FbdY
d62gvIclAR+kARIAHGA/0XQYWzFd/1hNLSEkIQsgKdMoMUUCBnF7R1E9UD9YXNUhJCACQHDwczov
LwhwjxABEAnwv6RhqxEZMD8AMJFrEi+YgBHZoj91PdkzLTNBtF9fcgBtePPcc19tQgBfN180XzMz
MQAmZD1Ed0lCQRBnJmM9ClA4bU8AOHpnQzRWWjQAcV9hTlZLdDgQRzlNQ21QVUZEATXwc3ZNUjFr
LUBFb0RNJnLb0GoAekl4RXNTOHcgZjNFenLcYHIwIFpPanczaOE4agBJbFFLLVNRNSBwV2hYYeGA
bT0AYVlzODZzVEYBfIBxdmxJNXJFADJBV0xHUmwwCc2QOVh5wGlSS1ZBrCBDYVhkUuGAc4o93eBN
SOBxNVUnMABGd01mSzRPZkBnTGJBMmvoQFoIVmdF6JBrYVdLAHFERVVYR3cmdGU9WFwvIdRYXFhV
Pf/tD+4f7y/wP/FP8aPRCasQ/yfQAxBj0BxRG+FCUAEAsYH/JYF2YRrzRGIb4QGQx1M5cf8sA0Pw
cGE50jCSItGuRD4A/7ShPULPkqZS08UHkdMBHbH/qUEcQvi1BbBmVUnSG7HEVPv2pTfQSV3AwGIu
Ej6S+Ov/+fn2TAWx/XakBY5QqHFg0v8PQCMwGjE9YLj29tMr0T7Q/xHANcFCEBHwnLJD0a2gGeD/
HaI9UQlwC1A9Y1zkdGP6Bf9MtCwhMOE1sSJRAgF70VqS/RvRcDkyXeEoMRyDobPbEf+tAVVyIlGR
AUwD13Erkk7w38LgDeBa8T1QN9BZChROwN8YYkRiLCEsEMpjYT7wSzHdDGJk/OE1sLxiZB1g1BJ/
MpOx8czAJXB50DawjDB6vxxR+CNd8PQf9SZd4U6ENP850qvBGOBFgqsRLBByMBxB/3PwegIQkvTq
9k1ZgTzFNDX/NyBCUfSiPfEjQVCBE6lxoP8IokUBCDBD8SlR0xCRAF6R/71RwxQ+kG8AR+TUJBPV
LKYMfX1lwB8gAAAAHwBCAAEAAAAgAAAASQBTADIAMAAgAEUAeQBhAGwAIABDAG8AaABlAG4AAAAf
AGUAAQAAAC4AAABFAHkAYQBsAC4AQwBvAGgAZQBuAEAAbgB1AHYAbwB0AG8AbgAuAGMAbwBtAAAA
AAAfAGQAAQAAAAoAAABTAE0AVABQAAAAAAACAUEAAQAAAHAAAAAAAAAAgSsfpL6jEBmdbgDdAQ9U
AgAAAIBJAFMAMgAwACAARQB5AGEAbAAgAEMAbwBoAGUAbgAAAFMATQBUAFAAAABFAHkAYQBsAC4A
QwBvAGgAZQBuAEAAbgB1AHYAbwB0AG8AbgAuAGMAbwBtAAAAHwACXQEAAAAuAAAARQB5AGEAbAAu
AEMAbwBoAGUAbgBAAG4AdQB2AG8AdABvAG4ALgBjAG8AbQAAAAAAHwDlXwEAAAAuAAAAcwBpAHAA
OgBlAGMAbwBoAGUAbgBAAG4AdQB2AG8AdABvAG4ALgBjAG8AbQAAAAAAAgFODgEAAAAcAAAAAQUA
AAAAAAUVAAAAJyTOQ9u5VgypqqEGpAgAAB8AGgwBAAAAIAAAAEkAUwAyADAAIABFAHkAYQBsACAA
QwBvAGgAZQBuAAAAHwAfDAEAAAAuAAAARQB5AGEAbAAuAEMAbwBoAGUAbgBAAG4AdQB2AG8AdABv
AG4ALgBjAG8AbQAAAAAAHwAeDAEAAAAKAAAAUwBNAFQAUAAAAAAAAgEZDAEAAABwAAAAAAAAAIEr
H6S+oxAZnW4A3QEPVAIAAACASQBTADIAMAAgAEUAeQBhAGwAIABDAG8AaABlAG4AAABTAE0AVABQ
AAAARQB5AGEAbAAuAEMAbwBoAGUAbgBAAG4AdQB2AG8AdABvAG4ALgBjAG8AbQAAAB8AAV0BAAAA
LgAAAEUAeQBhAGwALgBDAG8AaABlAG4AQABuAHUAdgBvAHQAbwBuAC4AYwBvAG0AAAAAAAIBTQ4B
AAAAHAAAAAEFAAAAAAAFFQAAACckzkPbuVYMqaqhBqQIAAALAEA6AQAAAB8AGgABAAAAEgAAAEkA
UABNAC4ATgBvAHQAZQAAAAAAAwDxPwkEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAAKzHo
FgH3KEqvus+Bj0JJZwMAFwABAAAAQAA5AABwXo1nPdUBQAAIMKnI0o1nPdUBCwApAAAAAAALACMA
AAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMAYwBlAHAAdABsAGEAbgBnAHUAYQBn
AGUAAAAAAAEAAAAMAAAAZQBuAC0AVQBTAAAAHwD6PwEAAAAgAAAASQBTADIAMAAgAEUAeQBhAGwA
IABDAG8AaABlAG4AAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAGhQAAAAAAAB8ANwABAAAAegAA
AFIARQA6ACAAWwBQAEEAVABDAEgAIAB2ADIAIAAwAC8AMgBdACAAYwBoAGEAcgA6ACAAdABwAG0A
OgAgAGEAZABkACAAbgBlAHcAIABkAHIAaQB2AGUAcgAgAGYAbwByACAAdABwAG0AIABpADIAYwAg
AHAAdABwAAAAAAAfAD0AAQAAAAoAAABSAEUAOgAgAAAAAAADADYAAAAAAB8A2T8BAAAAAAIAAEgA
aQAgAEoAYQByAGsAawBvACAAYQBuAGQAIABBAGwAZQB4AGEAbgBkAGUAcgAsAA0ACgANAAoAVwBl
ACAAaABhAHYAZQAgAG0AYQBkAGUAIABhAG4AIABhAGQAZABpAHQAaQBvAG4AYQBsACAAYwBvAGQA
ZQAgAHIAZQB2AGkAZQB3ACAAbwBuACAAdABoAGUAIABUAFAATQAgAFQASQBTACAAYwBvAHIAZQAg
AGQAcgBpAHYAZQByACwAIABpAHQAIABsAG8AbwBrAHMAIABxAHUAaQB0AGUAIABnAG8AbwBkACAA
YQBuAGQAIAB3AGUAIABjAGEAbgAgAGMAbwBuAG4AZQBjAHQAIABvAHUAcgAgAG4AZQB3ACAASQAy
AEMAIABkAHIAaQB2AGUAcgAgAHQAbwAgAHQAaABpAHMAIABsAGEAeQBlAHIALgANAAoASABvAHcA
ZQB2AGUAcgAsACAAdABoAGUAcgBlACAAYQByAGUAIABzAGUAdgBlAHIAYQBsACAAZABpAGYAZgBl
AHIAZQBuAGMAZQBzACAAYgBlAHQAdwBlAGUAbgAgAHQAaABlACAAUwBQAEkAIABpAG4AdABlAHIA
ZgBhAGMAZQAgAGEAbgBkACAAdABoAGUAIABJADIAQwAgAGkAbgB0AGUAcgBmAGEAYwBlAAAAAwAu
AAAAAAAfAEIQAQAAAGQAAAA8ADIAMAAxADkAMAA3ADEANQAwADkANAA1ADQAMQAuAHoAagBxAHgA
YQBpAG4AZwBnAGoAdQB2AGoAeABkADIAQABsAGkAbgB1AHgALgBpAG4AdABlAGwALgBjAG8AbQA+
AAAAAgFxAAEAAAAbAAAAAQHVOvIQ+td4FoJtQk2eh+ryXBhwdKbQVkKgAB8AcAABAAAAcgAAAFsA
UABBAFQAQwBIACAAdgAyACAAMAAvADIAXQAgAGMAaABhAHIAOgAgAHQAcABtADoAIABhAGQAZAAg
AG4AZQB3ACAAZAByAGkAdgBlAHIAIABmAG8AcgAgAHQAcABtACAAaQAyAGMAIABwAHQAcAAAAAAA
HwA1EAEAAABwAAAAPAA5AGMAOABlADIAMQA2AGQAYgBjADQAZgA0ADMAZABiAGEAYQAxADcAMAAx
AGQAYwAxADYANgBiADAANQBlADAAQABOAFQASQBMAE0ATAAwADIALgBuAHUAdgBvAHQAbwBuAC4A
YwBvAG0APgAAAB8AORABAAAAuAMAADwAMgAwADEAOQAwADYAMgA4ADEANQAxADMAMgA3AC4AMgAw
ADYAOAAxADgALQAxAC0AbwBzAGgAcgBpAGEAbABrAG8AYgB5ADgANQBAAGcAbQBhAGkAbAAuAGMA
bwBtAD4AIAA8ADgAZQA2AGMAYQA4ADcAOQA2AGYAMgAyADkAYwA1AGQAYwA5ADQAMwA1ADUANAAz
ADcAMwA1ADEAZAA3AGEAZgAzADIAMwBmADAAYwA1ADYALgBjAGEAbQBlAGwAQABsAGkAbgB1AHgA
LgBpAG4AdABlAGwALgBjAG8AbQA+ACAAPAA3ADkAZQA4AGIAZgBkADIALQAyAGUAZAAxAC0AYwBm
ADQAOAAtADQAOQA5AGMALQA1ADEAMgAyADIAMgA5AGIAZQBiADIAZQBAAGkAbgBmAGkAbgBlAG8A
bgAuAGMAbwBtAD4AIAA8AEMAQQBNADkAbQBCAHcASgBDADIAUQBEADUALQBnAFYAMQBlAEoAVQBE
AHoAQwAyAEYAbgBuAHUAZwByAC0AbwBDAFoAQwBvAGEASAAyAHMAVABfADcAawB0AEYARABrAFMA
LQBRAEAAbQBhAGkAbAAuAGcAbQBhAGkAbAAuAGMAbwBtAD4AIAA8ADQANQA2ADAAMwBhAGYAMgBm
AGMAOAAzADcANABhADkAMABlAGYAOQBlADgAMQBhADYANwAwADgAMwAzADkANQBjAGMAOQBjADcA
MQA5ADAALgBjAGEAbQBlAGwAQABsAGkAbgB1AHgALgBpAG4AdABlAGwALgBjAG8AbQA+ACAAPAA2
AGUANwBmAGYAMQBiADkANQA4AGQAOAA0AGYANgBlADgAZQA1ADgANQBmAGQAMwAyADcAMwBlAGYA
MgA5ADUAQABOAFQASQBMAE0ATAAwADIALgBuAHUAdgBvAHQAbwBuAC4AYwBvAG0APgAgADwAQwBB
AFAANgBaAHEAMQBoAFAAbwA5AGQARwA3ADEAWQBGAHkAcgA3AHoAOQByAGoAbQBpAC0ARAB2AG8A
VQBaAEoATwBtAGUANAArADIAdQBxAHMAZgBPACsANwBuAEgAKwBIAFEAQABtAGEAaQBsAC4AZwBt
AGEAaQBsAC4AYwBvAG0APgAgADwAMgAwADEAOQAwADcAMQA1ADAAOQA0ADUANAAxAC4AegBqAHEA
eABhAGkAbgBnAGcAagB1AHYAagB4AGQAMgBAAGwAaQBuAHUAeAAuAGkAbgB0AGUAbAAuAGMAbwBt
AD4AAAADAN4/n04AAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAAAAOFAAAAAAAAAwAAgAggBgAAAAAA
wAAAAAAAAEYAAAAAAYUAAAAAAAADAIAQ/////0AABzDsoayNZz3VAQsAAgABAAAAAwAmAAAAAAAL
ACsAAAAAAAsABgwAAAAAAgETMAEAAAAQAAAA+td4FoJtQk2eh+ryXBhwdB8A+D8BAAAAIAAAAEkA
UwAyADAAIABFAHkAYQBsACAAQwBvAGgAZQBuAAAAHwAiQAEAAAAGAAAARQBYAAAAAAAfACNAAQAA
AFYAAAAvAE8APQBOAFUAVgBPAFQATwBOAC8ATwBVAD0ATgBUAEkATAAvAEMATgA9AFIARQBDAEkA
UABJAEUATgBUAFMALwBDAE4APQBFAEMATwBIAEUATgAAAAAAHwAkQAEAAAAGAAAARQBYAAAAAAAf
ACVAAQAAAFYAAAAvAE8APQBOAFUAVgBPAFQATwBOAC8ATwBVAD0ATgBUAEkATAAvAEMATgA9AFIA
RQBDAEkAUABJAEUATgBUAFMALwBDAE4APQBFAEMATwBIAEUATgAAAAAAHwAwQAEAAAAOAAAAZQBj
AG8AaABlAG4AAAAAAB8AMUABAAAADgAAAGUAYwBvAGgAZQBuAAAAAAAfADhAAQAAAA4AAABlAGMA
bwBoAGUAbgAAAAAAHwA5QAEAAAAOAAAAZQBjAG8AaABlAG4AAAAAAAMAWUAAAAAAAwBaQAAAAAAD
AAlZAQAAAAMAAIAIIAYAAAAAAMAAAAAAAABGAAAAABCFAAAAAAAACwAAgAggBgAAAAAAwAAAAAAA
AEYAAAAAgoUAAAAAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAOhQAAAAAAAAMAAIAIIAYAAAAA
AMAAAAAAAABGAAAAABiFAAAAAAAAQAAAgAggBgAAAAAAwAAAAAAAAEYAAAAAv4UAAEAyYVtnPdUB
HwAAgAggBgAAAAAAwAAAAAAAAEYAAAAA2IUAAAEAAAASAAAASQBQAE0ALgBOAG8AdABlAAAAAAAD
AA00/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACAAAAB4AC0AbQBzAC0AaABhAHMALQBhAHQA
dABhAGMAaAAAAAEAAAACAAAAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAFIAAAB4AC0AbQBz
AC0AZQB4AGMAaABhAG4AZwBlAC0AdAByAGEAbgBzAHAAbwByAHQALQBmAHIAbwBtAGUAbgB0AGkA
dAB5AGgAZQBhAGQAZQByAAAAAAABAAAADgAAAEgAbwBzAHQAZQBkAAAAAAAfAACAhgMCAAAAAADA
AAAAAAAARgEAAAAiAAAAeAAtAG8AcgBpAGcAaQBuAGEAdABpAG4AZwAtAGkAcAAAAAAAAQAAACAA
AABbADEAMAAuADEAOQAxAC4AMQAwAC4AMQA2ADAAXQAAAKeC

--_000_9c8e216dbc4f43dbaa1701dc166b05e0NTILML02nuvotoncom_--
