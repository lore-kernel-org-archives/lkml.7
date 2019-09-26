Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="c4tYzczS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfIZKRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:17:16 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:35959 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfIZKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:17:12 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id B2/C3-25181-5209C8D5; Thu, 26 Sep 2019 10:17:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUwbdRjH+d1djwNbdhRmf3YrmrpFM2lpp8a
  DxUF0xkZ5WXyJCzDrld5os755bV0hmjAzCKVMcTARBnSbZSYQl6zdkLchNh1jM7A4hCG6odBp
  AGNgm4psgnccTP3v8zzf7/N7vvnlIVDpOC4nGI+LYW20RYnHY6a0uAzV1prqvZo70xLq6E9Rn
  PJHhkVU29EujJr8/QKg/vi2EqFGuptwar57FKXKz0diswhdV+P1WF2wzYvrfhjrxXUf/q3R3Q
  6m7Bbli8w2g93zlsh0sGkEdVRt8/RUlZSBC49UgXgCkK0o/OwTb6xQDGAw6DuxVoQAvHv4L5w
  vMHIQhTfO1GJ8ISU/RuDib3WIUEQBHOge52biCJykYO3gjzjPyaQeXmweQnkTyo93HFlaNSWR
  NAz5f0UEkwEuzd8EAufC2fAy1ye4fVvhuYVCvi3h7PVDHUBYtozAzrHbIl6II5+FRwIfYTwDU
  gHvHGxHeUZJGZyI+lffhyQJA71XUIE3wpnpZZHgZ+Cl98eB0E+FQ9eia6yELc2RNVbAq34f4P
  NAMgf6plR8BkjeBLBsaQBZn+1v+EIkMAUDvnJMYDn8c3ohVpjdApfDJQI6YHlELzgeg4cWWkQ
  1QNP4n9ACp8LjPbdwgZ+Ap07MoY2rP5EILzVEseMAawPpBtZcbHJZabNFpdVoVFrtk6qnVNu1
  6Wq6VGVQM25VEWNzsTSnqukDTrWzxFpkMaptjCsIuCMzvo193wm+isypw+AhAlFulGzZVL1Xm
  mCwG0tMtNOkZ90WxhkGmwlCCSWmDzgtkWWKGc8+s4U71XUZEmJlsiSPlyVOB211mosF6TJQET
  UzzSdRKWaz2xi5TLJymDORvMnktt1/Yv3grwKFPEkCYmJipGIHw1rNrv/rs0BGAGWSxMmvEpt
  trvubZrkQCBfCZvfxIVz0v5K8DHka8fX1tc5tLnuz5+xLo6WHAg94M82mh3dZPn/98X2mnTMJ
  RQVk3akmY/YLKRMFY9eH6lIigfkdipzJYMvLffl7Etp3fPelU38sIzxwz86KmQNiaVx27VJk9
  xvhR0V70NzKqfQ8zYSjstyqSGuXGu5uOuc9VkGPYqdfW2Id9e9V+ulrrR5z4WJ/RB6Ir8qUFR
  TOdFhGsr5JkZzenrohGMrJGqzYnyeb2lm76wwViuQuDiZmf+q9VY3ArtC7z7w47B7ufm7lYsX
  PV752J6zk94oW2HvDr25o13vTJ5EbD9IZ4ZOF2ldakuszGTatT98A31F2/hK+bNuf359aevb5
  VuN5JeY00dptKOuk/wHx0gPBawQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-239.messagelabs.com!1569493028!9200!1
X-Originating-IP: [104.47.9.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12546 invoked from network); 26 Sep 2019 10:17:09 -0000
Received: from mail-ve1eur03lp2058.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.58)
  by server-16.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 26 Sep 2019 10:17:09 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/s5Q6ZyNqcbzUIHDa9NxeM2dYbjpthVqXhfpthMnUel7MrRo2nnw6/jYvXVkF/KvysTI/lr3WCjR4km1tOBHw1/dbguHDxaby6Vc2caS471Ji7FwIFUeFSAEpqTCed3mlgLa+gipONQ7X4j/IdZE+jmaSMwnGRtZZGm8t6fVlnpJoqEtXIVeSVKHUsqSN4ZRYq0BBP8szG85/6bC6kj3Tuhi17UUTOBTjGZsIg/B8+VOyKJkDl9Q759RIOYVpzDlqeyjhDFxEQqmtQ66g6HCgC/1R5imVPLAwawVL8fNUTv9mtFolIQ2KNYedYAmHCZN47mz218ae7XjJkFYcHljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7enp2VNNzJccuNEyRMziCDHoNSIt9Jiam856VqtplQ=;
 b=fnR7vWbEiosX2dTSAN9zulIbtR2HGJ1+CWoUGEdD384h8WFyNmzhwHOkXyIiZ+1lkVZZWWpKUXMpVRaD/jmKcgzev4XKpRNBagT3SJahrNjXDFHC/0DgMXVlpKWmhyHhMjuvcV0beEQL8xeX08Yncs63Rg6qJrEn2csG2DN0rXZkEbS+ZSepDPjVnSBYUAbReokH/e1zDirGhLBkDHtMrvsnKkhQbj8bPP0sQafpYgXVrJOvXTT92biEvZs3iO9778li9CQ60SUdRWP1PAd2gFueo5RJEH0uTDONBTP3hmxzEkENXi5yAWXtrK9GL5zcF2WgFcHyKWrmStLzyo3Lwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7enp2VNNzJccuNEyRMziCDHoNSIt9Jiam856VqtplQ=;
 b=c4tYzczSsoZjhzbYCSxaR0D8YZMIJ9sz8BqIb+xgxYfgoeMfzJu1w0M6exAfm4lOqtwuZNPXwPDB4sygE6HRYTWj5R6tcDtu/jnc0cbMtQVdmmBaYQAxEFMsKfrlmbz1RgvM7DlPhg7RJ8p7vD3FdzgeZnIH74dFc4QO2SCxaOk=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1026.EURPRD10.PROD.OUTLOOK.COM (10.169.150.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 10:17:06 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.028; Thu, 26 Sep
 2019 10:17:06 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Index: AQHVbVV1957uISHJUEeJggkt0eobi6c6l9DggAH/z4CAAAcsgIABChoAgAAjQKA=
Date:   Thu, 26 Sep 2019 10:17:06 +0000
Message-ID: <AM5PR1001MB09944C0F9A4F547BF9E175CF80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
 <AM5PR1001MB09941810C3AE97110DD82E0F80870@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926080956.a3k2z4gf3n6m3n4s@pengutronix.de>
In-Reply-To: <20190926080956.a3k2z4gf3n6m3n4s@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bd29d30-c172-426a-6c6b-08d7426aaed0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB1026;
x-ms-traffictypediagnostic: AM5PR1001MB1026:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB102629046DC9A3F8A7D3416CA7860@AM5PR1001MB1026.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(26005)(7736002)(74316002)(64756008)(66556008)(66446008)(305945005)(52536014)(71190400001)(446003)(71200400001)(229853002)(66476007)(8936002)(81166006)(76116006)(81156014)(66946007)(11346002)(476003)(478600001)(3846002)(14454004)(6436002)(6116002)(966005)(6506007)(486006)(7696005)(33656002)(54906003)(86362001)(186003)(76176011)(9686003)(8676002)(25786009)(4326008)(256004)(99286004)(6246003)(5660300002)(55016002)(6306002)(102836004)(316002)(2906002)(14444005)(53546011)(55236004)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1026;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CJ++4pfIHGWh+IkCjKC0sWutZjo+m19VQqMoNUiWWzdl/ZbklKI8DWZJqpfJp2w8HAfT74IAXyMOpczU93/9kq0DTja6KvNAhRxUQa/FRyyoa5/hLDg77gGccOyYBK7MJYJwNS7E138V2hUeIDMOXlyROwyNKprDq3hYre5OLBiCLo7AQQgh9w/GkRDgeDmfd8pX1yR30RQvnI+XRrkO6Guqsog/10E8OVc84k3bHK47/WOsmyVSi76312xQ+r/9lQOdMIpRSI38j23BH7yL3u3xYoPxU+qXvbLvgW27+9smgb9ADszYR8Lps1UNHvduvSJ3pb+TmD/mYTEKz86QX26cQIXcJbHkzBJBQoqQmE/W2MVJw/X6y4yjyz/cPdAgMKNFxOgY2ghjgX8lwaIID2DDlAOdQ+DFzEWnyXeaDIwg4FFBU7vZg92t9uHa9WeIyxJpWsBF+p1p7TEwKntKsw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd29d30-c172-426a-6c6b-08d7426aaed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 10:17:06.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwMnfZwJxdg+aLN2TxYH0Hf9Aq8GgoZDuMLFPHRzidXOyvJ0ctO9MKjOKqy5jUr4G9rHTMy6fQ3GJZRXJ9vBFA9Mk0s89oR1VFh/Btag71A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2019 09:10, Marco Felsch wrote:

> On 19-09-25 16:18, Adam Thomson wrote:
> > On 25 September 2019 16:52, Marco Felsch wrote:
> >
> > > Hi Adam,
> > >
> > > On 19-09-24 09:23, Adam Thomson wrote:
> > > > On 17 September 2019 13:43, Marco Felsch wrote:
> > > >
> > > > > Add the documentation which describe the voltage selection gpio
> support.
> > > > > This property can be applied to each subnode within the 'regulato=
rs'
> > > > > node so each regulator can be configured differently.
> > > > >
> > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > index edca653a5777..9d9820d8177d 100644
> > > > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > @@ -66,6 +66,15 @@ Sub-nodes:
> > > > >    details of individual regulator device can be found in:
> > > > >    Documentation/devicetree/bindings/regulator/regulator.txt
> > > > >
> > > > > +  Optional regulator device-specific properties:
> > > > > +  - dlg,vsel-sense-gpios : The GPIO reference which should be us=
ed by
> the
> > > > > +    regulator to switch the voltage between active/suspend volta=
ge
> settings.
> > > If
> > > > > +    the signal is active the active-settings are applied else th=
e suspend
> > > > > +    settings are applied. Attention: Sharing the same gpio for o=
ther
> purposes
> > > > > +    or across multiple regulators is possible but the gpio setti=
ngs must be
> the
> > > > > +    same. Also the gpio phandle must refer to to the dlg,da9062-=
gpio
> device
> > > > > +    other gpios are not allowed and make no sense.
> > > > > +
> > > >
> > > > Should we not use the binding names that are defined in 'gpio-
> regulator.yaml'
> > > as
> > > > these seem to be generic and would probably serve the purpose here?
> > >
> > > Hm.. as the description says:
> > >
> > > 8<--------------------------------------------------
> > > gpios:
> > >    description: Array of one or more GPIO pins used to select the
> > >    regulator voltage/current listed in "states".
> > > 8<--------------------------------------------------
> > >
> > > But we don't have a "states" property and we can't select between
> > > voltage or current.
> >
> > Yes I think I was at cross purposes when I made this remark. The bindin=
gs there
> > describe the GPOs that are used to enable/disable and set voltage/curre=
nt for
> > regulators and the supported voltage/current levels that can be configu=
red in
> > this manner. What you're describing is the GPI for DA9061/2. If you loo=
k at
> > GPIO handling in existing regulator drivers I believe they all deal wit=
h external
> > GPOs that are configured to enable/disable and set voltage/current limi=
ts
> rather
> > than the GPI on the PMIC itself. That's why I'm thinking that the confi=
gurations
> > you're doing here should actually be in a pinctrl or GPIO driver.
>=20
> That's true, the common gpio bindings are from the view of the
> processor, e.g. which gpio must the processor drive to enable/switch the
> regualtor. So one reasone more to use a non-common binding.
>=20
> Please take a look on my other comment I made :) I don't use the
> gpio-alternative function. I use it as an input.

I know in the datasheet this isn't marked as an alternate function specific=
ally
but to me having regulator control by the chip's own GPI is an alternative
function for that GPIO pin, in the same way a specific pin can be used for
SYS_EN or Watchdog control. It's a dedicated purpose rather than being a no=
rmal
GPI.

See the following as an example of what I'm suggesting:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/pinctrl/pinctrl-palmas.txt

You could then pass the pinctrl information to the regulator driver and use
that rather than having device specific bindings for this. That's at least =
my
current interpretation of this anyway.

>=20
> Regards,
>   Marco
>=20
>=20
> > I'd be interested in hearing Mark's view on this though as he has far m=
ore
> > experience in this area than I do.
> >
> > >
> > > Regards,
> > >   Marco
> > >
> > > > >  - rtc : This node defines settings required for the Real-Time Cl=
ock
> associated
> > > > >    with the DA9062. There are currently no entries in this bindin=
g, however
> > > > >    compatible =3D "dlg,da9062-rtc" should be added if a node is c=
reated.
> > > > > --
> > > > > 2.20.1
> > > >
> > > >
> > >
> > > --
> > > Pengutronix e.K.                           |                         =
    |
> > > Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
> > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
> >
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
