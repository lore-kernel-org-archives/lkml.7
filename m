Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F691C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E121955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfGVRks convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:48 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:52886 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbfGVRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:45 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-d5-5d35f51b4352
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 35.55.05313.B15F53D5; Mon, 22 Jul 2019 19:40:43 +0200 (CEST)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Mon, 22 Jul 2019 19:40:43 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Andra Danciu <andradanciu1997@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "vabhav.sharma@nxp.com" <vabhav.sharma@nxp.com>,
        "pankaj.bansal@nxp.com" <pankaj.bansal@nxp.com>,
        "bhaskar.upadhaya@nxp.com" <bhaskar.upadhaya@nxp.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Richard Hu <richard.hu@technexion.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the
 PICO-PI-IMX8M
Thread-Topic: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the
 PICO-PI-IMX8M
Thread-Index: AQHVK1JOWCo7Ia8Nb0OT9XMV6ZJPCKbPwRwAgAB6AQCABbAbAIABJkHh
Date:   Mon, 22 Jul 2019 17:40:43 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A40749E9BDA@WILL-MAIL002.REu.RohmEu.com>
References: <20190625123407.15888-1-andradanciu1997@gmail.com>
 <20190718035523.GD11324@X250>
 <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>,<20190722020345.GR3738@dragon>
In-Reply-To: <20190722020345.GR3738@dragon>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.93.194.89]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0hTURzHOffe3d3ZbpzmbCdNoYFRVqZRcMAIe1C3SDIjiNLsLm9utYfc
        zdAiMHrpIjQoyJX5wMzWKlqlaZa6Bj1ZlFpZrQdapElYsyDD7F7Xw3/O+XK+v+/vcw78DkNq
        AnQ0Y7I6BNHKm/V0BNVW/9M7J+bbgqykUOUMPHS8mcTVR4ZI3PPmJcAtI+UUvtwSpHGlP6DA
        77rW4LcV3QT27WsjsHP4HIk7mk/ROLi/RIHPPHtM4P7qtwQ+H2in8eiHVoAP3PQr8cerOlza
        8IlKjeSOO+sB5zntAVyTK6jkvO4Smnv1tIXmLn++TnClI0ncyJ1jJBfyxqWrNk5YaOAdO9eZ
        cq1zF22ZYGwPfQF5B9kC/9GPoAh4IpxAxSA4H5Ueu004QQSjgU8BGuh2U7KhgXcBuvUBOwHD
        0HAhcnYrZamFaejr4Qy5nIQNNNrXeFMpl0fCTai0sxfIWgsz0eCbxj96OWqo6ByroWA8qmit
        VciahRmoy/36D9cPUFNNcCyggrNQZefzsTsAGItKij4TsiahDr3orSTCl4aotuURGdZRqK/n
        lyKsp6Ey7w8qXD8bVd34Sof1LFRX/YkMgyehe+W9VBmIco1r6xoXcY2LuMZFqgDlBsjCm8y5
        vENIThSF/ETRZrRI21abxQvCszB0HYz6VvoAZIBezV75siBLo+B32gstPjCFIfRRbP0N6Wii
        wZZTaOTtxmwx3yzYfQAxpF7LWpMkj83hC3cJou2vFcNQeh07nR3O1ECZvEMQ8gTxrzuVYfSI
        DYSk4CRRyBUKtpnMjv82wajk5hHRWrtgzRFEPt9hzJbHItsuzYVsqSXu0iGZa8/jLdJpOHof
        JDNlfRU1JDNwrlZaq65Jq4ay2qxCtI6NkXlQDhjzrf9w/UAnvTqSXSS7aumT/OvWL4EICdST
        OE8GOfj/VnQRyDT8Ut+d+yDNM3O5N3ZDX6qwZYVBO1Bz4lWKqnx4tXpwt39t8ZztF5WZgfSU
        hy8TCy4d7n5usn2v6QotGy0+dMEwfXNdii4vY/OTk4vTzrZqu6je9PP4STBOzNLGezIssX2b
        Tq1a8mJ+8fvJg1gVWE/sdQ+ndpg7ElY3xTma61bu0VN2I5+cQIp2/jczX8Rm4QMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top posting. I'm replying using mobile phone and outlook web app... 

gpio_intr is not needed. Irq must be given using the standard irq property. gpio_intr has been used in an old draft driver - I assume the dts originates from NXP bsp which used the old driver.

Br,
Matti Vaittinen

--
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~


________________________________________
From: Shawn Guo [shawnguo@kernel.org]
Sent: Monday, July 22, 2019 5:03 AM
To: Andra Danciu
Cc: robh+dt@kernel.org; mark.rutland@arm.com; leoyang.li@nxp.com; Fabio Estevam; aisheng.dong@nxp.com; l.stach@pengutronix.de; angus@akkea.ca; vabhav.sharma@nxp.com; pankaj.bansal@nxp.com; bhaskar.upadhaya@nxp.com; ping.bai@nxp.com; Manivannan Sadhasivam; Richard Hu; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Vaittinen, Matti; linux-imx@nxp.com; Daniel Baluta
Subject: Re: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M

On Thu, Jul 18, 2019 at 02:12:10PM +0300, Andra Danciu wrote:
...
> > > +     pmic: pmic@4b {
> > > +             reg = <0x4b>;
> > > +             compatible = "rohm,bd71837";
> > > +             /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > > +             pinctrl-0 = <&pinctrl_pmic>;
> > > +             gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
> >
> > Where is the bindings for this property?
> Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

I do not see property 'gpio_intr' in there.

Shawn
