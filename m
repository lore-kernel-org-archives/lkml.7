Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB73C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA04222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="gIPQCuFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfIZOEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:04:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:44597 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbfIZOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:04:31 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 36/E8-25256-965CC8D5; Thu, 26 Sep 2019 14:04:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRWlGSWpSXmKPExsWSoc9pqptxtCf
  W4NIPM4upD5+wWcw/co7VYtXUnSwW978eZbT4dqWDyeLyrjlsFh92XWW2aN17hN2Bw2PnrLvs
  HptWdbJ53Lm2h82j/6+Bx+dNcgGsUayZeUn5FQmsGatvLmAs+G1d0d5ygrmBcbJuFyMXB6PAU
  maJvguLGbsYOYGcYywSi96EQCQ2M0r87v3JBuKwCJxglrj/+BQriCMkMI1J4nnrOjYI5wmjxI
  +Dn9lA+tkELCQmn3gAlhAR6GKUOH9mKwtIgllgDrPE8hvWILawQKLE5vlvmEBsEYEkiV8fnjJ
  C2NES/5auYQexWQRUJR4sm84KYvMC1W87fJwFYlsbi8TMBUvAtnEK2Er8X/SXCeJyWYkvjauZ
  IZaJS9x6Mh8sLiEgILFkz3lmCFtU4uXjf6wQ9akSJ5tuMELEdSTOXn8CZStJzJt7BMqWlbg0v
  xvK9pWY+uAA2P8SAk8ZJfYcmsIO03xl112oIguJJd2tLBC2lMT3xx+BajiAbBWJf4cqIcIFEr
  MvrYMqV5do+TiPdQKjwSwkZ0PYOhILdn9ig7C1JZYtfM08CxwWghInZz5hWcDIsorRIqkoMz2
  jJDcxM0fX0MBA19DQSNfQ0lLXyMhQL7FKN0kvtVS3PLW4RBfILS/WK67MTc5J0ctLLdnECExm
  KQXH7+5g3H7ktd4hRkkOJiVR3qVLemKF+JLyUyozEosz4otKc1KLDzHKcHAoSfAe2QmUEyxKT
  U+tSMvMASZWmLQEB4+SCG/WEaA0b3FBYm5xZjpE6hSjMceEl3MXMXNsnrt0EbMQS15+XqqUOG
  //YaBSAZDSjNI8uEGwhH+JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvFpCFPJl5JXD7XgG
  dwgR0Sl5+N8gpJYkIKakGJq8l5wvab3ieiFr+8s90rZrZjDXp7uXBliK7m69xH+D90GOfuk9l
  1Q8jd4bgG3GP9qVuPvXSbFrxBp1Zz2L21rY+kam3mKRp+G4PZ/lMmx3/pkbOdPeeGan/JPXLC
  k/LSUcU5H0+h8nsuSWxvds8dNacHibjwzda51n4SnLNrL0vqKntm/xdbbdXy6ZF8Z//cQSIvg
  o7xP/HtG1FnLHn8knHem84Suw4XBcq8XPL+eN3+yYUMG09eKN63SzhNj4m/jgNgfXZfe7H+nN
  cW1c0CzVOFrUwWy1Rkhfi5uzw3uHSngj337azjvtMuFklIpTzqNLlxfeG6zN/vBP/K8/84v9X
  7y6BVX1WrPe/coaUK7EUZyQaajEXFScCAKuxwARzBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-282.messagelabs.com!1569506664!48737!1
X-Originating-IP: [104.47.9.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4883 invoked from network); 26 Sep 2019 14:04:24 -0000
Received: from mail-ve1eur03lp2053.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.53)
  by server-13.tower-282.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 26 Sep 2019 14:04:24 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYYf0aySvMCDM/WfYP10GUxMoZ208UVvB06fTvTHav5FL12/8dKmiYoXanCDgoV+Qjw0QLxf5dlCsvaFjIsmuvEwn1QnvZ1OzOYT5Vyd+Ww9D3/TJkyQbpitSnaZpixi3BFMKdBj8WrOXX/fEC+yev3KbiypDWfYJuumxqrmYNYFI3X0tvXv0Fa4NzMLLy4XqWE8k6ENv0RCmtL6P6CCqVLon1ASKCXBxs/dLLshKf+HRp7R5jyjgwQoKF3lu+Mho9v8EpYP/y8bGDCuv8Xzq2P8gsT9CBkD2f2LwlswT458QxNui5c6mvPCBC8fWvJ7ftf4P+J1Iuw8gEa7IMvxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fbfep/j1MCU9GJdSVOkQrFcxWXQ5aGCklcyQHJzOD8=;
 b=eSRu6lajlX8CnkemweqgKV+ySoJiOOfx4g5pG+t1RLS8JROF9xRI/ogyBuIRvFVSf7AHc91M0bmn+PiSzPgOOFfirvobmCN40uLS/iAYpsWF5JV7MCVBITy/VP4rpl/7aJN3jbIslIEGJcq3I3wqYlm3ukOZUCHobA7+9VxcqsETpsrE2GIhD4ZcPZBHjkqCd+wVIJey+bSv31Z6S7HecoAww7q93ALWPQ5axRVZWrfxE2sBodf5WxKcFASilHq6GFZFl8M9fSv8gAqw/Pmz/FdmVZkQrYvtmHmVM040Buz789q41E4qwPZ16dWb8/hoILvBuQZ1ZX7MqRaYzVFdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fbfep/j1MCU9GJdSVOkQrFcxWXQ5aGCklcyQHJzOD8=;
 b=gIPQCuFZRtJutuLf9b9C4cI3dqx5buwLRM9rbnWAZvfoczQsLB58UbOQRH1UUGlfCe4dgT6gF7kyhwfXVTeccFWCsBl2IoUJRGk8ehR+Jzv09zQ6V0hhrCeZ9EqtIJZqoLO10COJWxsY46DCaepeJ79VsUMhhl07aywOUjnWKXU=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1009.EURPRD10.PROD.OUTLOOK.COM (10.169.148.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 14:04:23 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.028; Thu, 26 Sep
 2019 14:04:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Index: AQHVbVV1957uISHJUEeJggkt0eobi6c6l9DggAH/z4CAAAcsgIABChoAgAAjQKCAABiIAIAAH5vw
Date:   Thu, 26 Sep 2019 14:04:23 +0000
Message-ID: <AM5PR1001MB099405D4A0C06CD6BF2886E880860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
 <AM5PR1001MB09941810C3AE97110DD82E0F80870@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926080956.a3k2z4gf3n6m3n4s@pengutronix.de>
 <AM5PR1001MB09944C0F9A4F547BF9E175CF80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926114354.qvv2rs7mc4xh6lkp@pengutronix.de>
In-Reply-To: <20190926114354.qvv2rs7mc4xh6lkp@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b56676a6-fc71-440b-ae0f-08d7428a6f01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB1009;
x-ms-traffictypediagnostic: AM5PR1001MB1009:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1009C69C5E01402FDDB50E22A7860@AM5PR1001MB1009.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(2906002)(74316002)(76116006)(52536014)(71200400001)(66946007)(476003)(2501003)(316002)(71190400001)(305945005)(8936002)(81156014)(7736002)(25786009)(4326008)(66476007)(8676002)(81166006)(966005)(14454004)(6116002)(6436002)(478600001)(3846002)(11346002)(76176011)(66556008)(99286004)(110136005)(229853002)(64756008)(486006)(66446008)(54906003)(86362001)(5660300002)(7696005)(26005)(33656002)(102836004)(9686003)(6306002)(66066001)(55236004)(6246003)(186003)(55016002)(446003)(6506007)(256004)(53546011)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1009;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0oABpWk1hYClq3hQYqy5/GZuE6aVZBvltjnlBtFq8Qf+dy7hk2QDcdr3YIILlM0znuWuf4zZ1U1b8JsgW6+aqvwGiiAIyVJXvLBMrEhvhwkh9BqEl3Q0eHI2NSIH37/3Mcnsts8JxlgPZzI70arAkYQ9/hd3VvN4pGoXXrPXWtvDCBujqln8IaH8PuSezPLCsHCSxbM3dEFvLupv5xbeABKfVD3ULBl5CH4/2ei44V5XDRhEIeMGrIs2kD4FefG99eD+Ib0NreS5C45cVhwCgo3IXb3z4I8n/TAtGZPv4BYKaR8XxRqh3hc34d9q5FxOpzRfnMrJ1L1Yq+3nh0FJbNS+I9XuFbPk/g15AoNfTj2Ndhp828R3XvNjGle6wjWKMhXAr0Rnw3Vh0JwstFrOvxXDs6JzOkp+infgKs257hWeLZIwY4bUxgJYoycVecvuXoLCQ2Q1g4gluprJBMvlQQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56676a6-fc71-440b-ae0f-08d7428a6f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:04:23.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2lGJGImaLSvKQYRNJNUSk9ng1La8amaVDjmWU3k5CEQV0QBYnyzjks9VAKs0lX63LXT7ehyH1y0JKRCjBDbNTkR1rxZIaxBilOqDNU33Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2019 12:44, Marco Felsch wrote:

> On 19-09-26 10:17, Adam Thomson wrote:
> > On 26 September 2019 09:10, Marco Felsch wrote:
> >
> > > On 19-09-25 16:18, Adam Thomson wrote:
> > > > On 25 September 2019 16:52, Marco Felsch wrote:
> > > >
> > > > > Hi Adam,
> > > > >
> > > > > On 19-09-24 09:23, Adam Thomson wrote:
> > > > > > On 17 September 2019 13:43, Marco Felsch wrote:
> > > > > >
> > > > > > > Add the documentation which describe the voltage selection gp=
io
> > > support.
> > > > > > > This property can be applied to each subnode within the 'regu=
lators'
> > > > > > > node so each regulator can be configured differently.
> > > > > > >
> > > > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++=
++
> > > > > > >  1 file changed, 9 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > index edca653a5777..9d9820d8177d 100644
> > > > > > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > @@ -66,6 +66,15 @@ Sub-nodes:
> > > > > > >    details of individual regulator device can be found in:
> > > > > > >    Documentation/devicetree/bindings/regulator/regulator.txt
> > > > > > >
> > > > > > > +  Optional regulator device-specific properties:
> > > > > > > +  - dlg,vsel-sense-gpios : The GPIO reference which should b=
e used
> by
> > > the
> > > > > > > +    regulator to switch the voltage between active/suspend v=
oltage
> > > settings.
> > > > > If
> > > > > > > +    the signal is active the active-settings are applied els=
e the suspend
> > > > > > > +    settings are applied. Attention: Sharing the same gpio f=
or other
> > > purposes
> > > > > > > +    or across multiple regulators is possible but the gpio s=
ettings must
> be
> > > the
> > > > > > > +    same. Also the gpio phandle must refer to to the dlg,da9=
062-gpio
> > > device
> > > > > > > +    other gpios are not allowed and make no sense.
> > > > > > > +
> > > > > >
> > > > > > Should we not use the binding names that are defined in 'gpio-
> > > regulator.yaml'
> > > > > as
> > > > > > these seem to be generic and would probably serve the purpose h=
ere?
> > > > >
> > > > > Hm.. as the description says:
> > > > >
> > > > > 8<--------------------------------------------------
> > > > > gpios:
> > > > >    description: Array of one or more GPIO pins used to select the
> > > > >    regulator voltage/current listed in "states".
> > > > > 8<--------------------------------------------------
> > > > >
> > > > > But we don't have a "states" property and we can't select between
> > > > > voltage or current.
> > > >
> > > > Yes I think I was at cross purposes when I made this remark. The bi=
ndings
> there
> > > > describe the GPOs that are used to enable/disable and set voltage/c=
urrent
> for
> > > > regulators and the supported voltage/current levels that can be con=
figured
> in
> > > > this manner. What you're describing is the GPI for DA9061/2. If you=
 look at
> > > > GPIO handling in existing regulator drivers I believe they all deal=
 with
> external
> > > > GPOs that are configured to enable/disable and set voltage/current =
limits
> > > rather
> > > > than the GPI on the PMIC itself. That's why I'm thinking that the
> configurations
> > > > you're doing here should actually be in a pinctrl or GPIO driver.
> > >
> > > That's true, the common gpio bindings are from the view of the
> > > processor, e.g. which gpio must the processor drive to enable/switch =
the
> > > regualtor. So one reasone more to use a non-common binding.
> > >
> > > Please take a look on my other comment I made :) I don't use the
> > > gpio-alternative function. I use it as an input.
> >
> > I know in the datasheet this isn't marked as an alternate function spec=
ifically
> > but to me having regulator control by the chip's own GPI is an alternat=
ive
> > function for that GPIO pin, in the same way a specific pin can be used =
for
> > SYS_EN or Watchdog control. It's a dedicated purpose rather than being =
a
> normal
> > GPI.
>=20
> Nope, SYS_EN or Watchdog is a special/alternate function and not a
> normal input.

Having spoken with our HW team there's essentially no real difference.

>=20
> > See the following as an example of what I'm suggesting:
> >
> >
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/b=
indin
> gs/pinctrl/pinctrl-palmas.txt
> >
> > You could then pass the pinctrl information to the regulator driver and=
 use
> > that rather than having device specific bindings for this. That's at le=
ast my
> > current interpretation of this anyway.
>=20
> For me pinctrl decides which function should be assigned to a pin. So in
> our case this would be:
>   - alternate
>   - gpo
>   - gpi
>=20
> In our use-case it is a gpi..

It's not being used as a normal GPI as such. It's being used to enable/disa=
ble
the regulator so I disagree.

>=20
> An other reason why pinctrl seems not be the right solution is that the
> regulator must be configured to use this gpi. This decision can't be
> made globally because each regulator can be configured differently.. For
> me its just a local gpio.

You'd pass pinctrl information, via DT, to the regulator driver so it can s=
et
accordingly. At least that's my take here, unless I'm missing something. Th=
e
regulator driver would be the consumer and could set the regulator control
accordingly.

At the end of the day I'm not the gatekeeper here so I think Mark's input i=
s
necessary as he will likely have a view on how this should be done. I appre=
ciate
the work you've done here but I want to be sure we have a generic solution
as this would also apply to DA9063 and possibly other devices too.

Have added Mark to the 'To' in this e-mail thread so he might see it.
>=20
> Regards,
>   Marco
>=20
> > >
> > > Regards,
> > >   Marco
> > >
> > >
> > > > I'd be interested in hearing Mark's view on this though as he has f=
ar more
> > > > experience in this area than I do.
> > > >
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > > >
> > > > > > >  - rtc : This node defines settings required for the Real-Tim=
e Clock
> > > associated
> > > > > > >    with the DA9062. There are currently no entries in this bi=
nding,
> however
> > > > > > >    compatible =3D "dlg,da9062-rtc" should be added if a node =
is created.
> > > > > > > --
> > > > > > > 2.20.1
> > > > > >
> > > > > >
> > > > >
> > > > > --
> > > > > Pengutronix e.K.                           |                     =
        |
> > > > > Industrial Linux Solutions                 | http://www.pengutron=
ix.de/  |
> > > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-2069=
17-0
> |
> > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-2069=
17-5555 |
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
