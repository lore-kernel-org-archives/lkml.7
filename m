Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D993DC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12442196E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="DUxyi5yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfI3Jxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:53:40 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:60986 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbfI3Jxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:53:40 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 45/99-25256-D90D19D5; Mon, 30 Sep 2019 09:53:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRWlGSWpSXmKPExsWSoc9orjv3wsR
  Yg2ldjBZTHz5hs5h/5ByrxaqpO1ks7n89ymjx7UoHk8XlXXPYLD7susps0br3CLsDh8fOWXfZ
  PTat6mTzuHNtD5tH/18Dj8+b5AJYo1gz85LyKxJYM55d2cBUcCKmYsWEqSwNjJ0uXYycHIwCS
  5kl9j4x6mLkArKPsUgsfr6VBcLZzCjxu/cnG4jDInCCWWLTho2sII6QwFQmiSX7HjBCOI8ZJf
  Zc38QCMoxNwEJi8okHbCC2iEC8xPG5Z5lBiphB2tcsuMkKkhAWSJTYPP8NE0RRksSvD08ZIex
  siUWdG8AGsQioSvzu3woW5wWqP/lpIgvEtj5Wif/dp8GKOAVsJXqbrzJBvCEr8aVxNTOIzSwg
  LnHryXywuISAgMSSPeeZIWxRiZeP/7FC1KdKnGy6wQgR15E4e/0JlK0kMW/uEShbVuLS/G4gm
  wPI9pV4czoTpnzS2Z1QJRYSS7pbWSBsKYnvjz+yQ5SrSPw7VAkRLpCYvP8WG4StJrH92nmoy2
  Qk9p1sZJvAaDALydEQto7Egt2f2CBsbYllC18zzwKHhKDEyZlPWBYwsqxiNE8qykzPKMlNzMz
  RNTQw0DU0NNI1tLTUNTfWS6zSTdJLLdUtTy0u0TXUSywv1iuuzE3OSdHLSy3ZxAhMYykFxz13
  MN6d9UbvEKMkB5OSKO/c4xNjhfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwqp0DygkWpaanVqRl5
  gBTKkxagoNHSYR3F0iat7ggMbc4Mx0idYrRmGPCy7mLmDk2z126iFmIJS8/L1VKnHc9SKkASG
  lGaR7cIFiqv8QoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHfVeaApPJl5JXD7XgGdwgR0ikN
  qP8gpJYkIKakGJhMzjZC508N8TJ9YzFaLPfU+Jyf4kVrjr+3fEnfwKJ9pXHymz76uyX/RvYlf
  3zD8fvl0U1q9huWjW54z88o/9an8S0wyV9e79+XJpyvnAo0OrOTqqFW6nFRnZnVxarhY7EsmG
  UYnh9On5smriX1a0yDKqmq1YrdUzpHIYHu+loBr77hj/x50r75qyXuTpz322u6PP31/V8WZiZ
  WVNmVovGNrFlm+0OviNtWFv1fkT+G7cG1SFOfa4phewSKl6k4959T+mQdP1Yjf0AysWinA7Rp
  8fr+K/5LTFi6/ZBebWBl8WFxS8fXdajEuCYc31m4Vu4x1r5+47igpusZ5Q6W4Vz1n8Lfi3ify
  lRGXeMuUWIozEg21mIuKEwHWdQypcAQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-288.messagelabs.com!1569837212!348566!1
X-Originating-IP: [104.47.1.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4391 invoked from network); 30 Sep 2019 09:53:32 -0000
Received: from mail-ve1eur01lp2055.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.55)
  by server-3.tower-288.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 30 Sep 2019 09:53:32 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU0izr9ZzrkCb9MZ+38Ujz6DOBGIiUweGuMD0O2qxo2XLZZci82WxDQ83dUWFqW6qGPJ6TCrkH5Lmc19Rb7OVUwgvEIMyDo8xcYdFbat8o06AM2kRZ0doPNDmXHIRf/7O6ZQ+L5VnOolmJ8mxOOB09X71nGVF3N0FKwag6eI43/iEikSVNkJ3hc9bIehUCkW5NJns/z/lsyOHBFoLVIbWCVcpvZU8HDQ4VVpKf4SiP11RpWi+4GU75ZWiTHWq76OG/uhL5n9Fy726HFLamRliNX720Evy20WLhIxSH3SHKhsbQvEIGOs7BLxo2KiGQ5FZU0gAZHu4+W4sA1eHwfYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPyybKPC4uF/tyOTRfuqIw5dViBgNQ+o0Hbm7hQwx70=;
 b=A0aWlwLSFKMLKPv1eeNcvqPcGJ1Ey2wz9JVs/57snafdZZgqwq1c/eyqlPzltORdaYUJESfQ2AuPkniy9LRuSz1Qfj4lmThHRmdCwmzjQcGomhc+qV939t9uYzK8v/QSR/PHtB9NpmQSCZE1/6ebgs/fBITqYKlv/dT1ftaQvgZtO+b40lrgytN2dsFWvYCAY4EHAYrXiCUfka9Tm5JktCevdStpsHe0jO2x3tWenOMpmNomPypiwoQPrpmImfTwGXe3K/GjKDWyMqTOZ8fFjQKbIN1KjOfrNMXKgWsaFOEYWKFdpaPAewB9GuCf/BGUOgY0f529U/xGtlFF2NIUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPyybKPC4uF/tyOTRfuqIw5dViBgNQ+o0Hbm7hQwx70=;
 b=DUxyi5ycHJopciTI1EkN0vYSoOO1NYdbgokmOjjAEjVdAHdXZdmw21exmdGmRoWg3pnzHQZAv08/OyWlr/5c33zEFF4Yk9AQ+h78lSU+3Fm0fUnuOD1dc2J6EnCipmeU0cztiqq+tXr1Nokh51Ef9kJykQ7bWC3DCgGFjIzNF4o=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1059.EURPRD10.PROD.OUTLOOK.COM (10.169.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 09:53:22 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::419d:153e:d6ae:681d]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::419d:153e:d6ae:681d%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 09:53:22 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
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
Thread-Index: AQHVbVV1957uISHJUEeJggkt0eobi6c6l9DggAH/z4CAAAcsgIABChoAgAAjQKCAABiIAIAAH5vwgAARNICABfEikA==
Date:   Mon, 30 Sep 2019 09:53:21 +0000
Message-ID: <AM5PR1001MB0994316EA8AD903B2943CE2080820@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
 <AM5PR1001MB09941810C3AE97110DD82E0F80870@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926080956.a3k2z4gf3n6m3n4s@pengutronix.de>
 <AM5PR1001MB09944C0F9A4F547BF9E175CF80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926114354.qvv2rs7mc4xh6lkp@pengutronix.de>
 <AM5PR1001MB099405D4A0C06CD6BF2886E880860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926143835.tjv535h4gnfyystk@pengutronix.de>
In-Reply-To: <20190926143835.tjv535h4gnfyystk@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7499e663-9f19-467e-f740-08d7458c07a9
x-ms-traffictypediagnostic: AM5PR1001MB1059:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB105919F982C59137CBE737F5A7820@AM5PR1001MB1059.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(199004)(189003)(66476007)(7696005)(76176011)(478600001)(7736002)(14454004)(8936002)(30864003)(966005)(71200400001)(71190400001)(5660300002)(256004)(14444005)(99286004)(33656002)(316002)(305945005)(74316002)(66066001)(25786009)(66556008)(2906002)(64756008)(66446008)(66946007)(6246003)(486006)(52536014)(476003)(446003)(11346002)(76116006)(26005)(55016002)(9686003)(86362001)(6306002)(229853002)(53546011)(6506007)(6436002)(102836004)(110136005)(6116002)(3846002)(54906003)(4326008)(8676002)(81156014)(81166006)(55236004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1059;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ltDwvHzkZh6uYua0+4T/5kpC9M7NMeqiuSEy5UszIExNlEQrzQ9G5uPmBnf94yo7vEThLkwDpKu0d/fjX9/Sa5k60n5VysJaanvQ/AyycbhA38BLFZ3q1iDOacmwqI6CCsM/KhoqhGqV8+OXZCIqhdaRKVK6jXJaRWYHeVf2RBvEglaijsfZ6sZurVYsMETmr/Olna7rYLsncbLwYnby5dloAj+YSs7QAVP/2GAa4XGDPOX624URt3FZKhYMl0Pj/IbAaFIvcQlJmUx0JxPC5bjvS7kVF8JtQPF76HXJbGJmT/qlH8u6MZH8glW3eArVIiRiBsbHFEeUtuNk9GVzn2nnqD8lHNBM5xTZWM4ETzMB9jp6Y/qf2advHVGiCHTMnbP8nH3vL1cyoZoRzD3qv8LOY4eLiAPULmBp9gNTWMDLYTlWN7E4PMfVifFl3iZCV6S0QnqPcsF9aVc6NHMLCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7499e663-9f19-467e-f740-08d7458c07a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 09:53:21.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS0cb0vtEim+UKNbA9stQccg/SGTvz/BhykI0CnPjYDQNymFs+agLcsAYTVJI9Wi/VBj/vpZoknnJQwv4WVUb43lkge8X7eQ3gS5ULTIqlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2019 15:39, Marco Felsch wrote:

> On 19-09-26 14:04, Adam Thomson wrote:
> > On 26 September 2019 12:44, Marco Felsch wrote:
> >
> > > On 19-09-26 10:17, Adam Thomson wrote:
> > > > On 26 September 2019 09:10, Marco Felsch wrote:
> > > >
> > > > > On 19-09-25 16:18, Adam Thomson wrote:
> > > > > > On 25 September 2019 16:52, Marco Felsch wrote:
> > > > > >
> > > > > > > Hi Adam,
> > > > > > >
> > > > > > > On 19-09-24 09:23, Adam Thomson wrote:
> > > > > > > > On 17 September 2019 13:43, Marco Felsch wrote:
> > > > > > > >
> > > > > > > > > Add the documentation which describe the voltage selectio=
n gpio
> > > > > support.
> > > > > > > > > This property can be applied to each subnode within the
> 'regulators'
> > > > > > > > > node so each regulator can be configured differently.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9
> +++++++++
> > > > > > > > >  1 file changed, 9 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/mfd/da9062=
.txt
> > > > > > > > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > index edca653a5777..9d9820d8177d 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > @@ -66,6 +66,15 @@ Sub-nodes:
> > > > > > > > >    details of individual regulator device can be found in=
:
> > > > > > > > >    Documentation/devicetree/bindings/regulator/regulator.=
txt
> > > > > > > > >
> > > > > > > > > +  Optional regulator device-specific properties:
> > > > > > > > > +  - dlg,vsel-sense-gpios : The GPIO reference which shou=
ld be
> used
> > > by
> > > > > the
> > > > > > > > > +    regulator to switch the voltage between active/suspe=
nd
> voltage
> > > > > settings.
> > > > > > > If
> > > > > > > > > +    the signal is active the active-settings are applied=
 else the
> suspend
> > > > > > > > > +    settings are applied. Attention: Sharing the same gp=
io for other
> > > > > purposes
> > > > > > > > > +    or across multiple regulators is possible but the gp=
io settings
> must
> > > be
> > > > > the
> > > > > > > > > +    same. Also the gpio phandle must refer to to the dlg=
,da9062-
> gpio
> > > > > device
> > > > > > > > > +    other gpios are not allowed and make no sense.
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Should we not use the binding names that are defined in 'gp=
io-
> > > > > regulator.yaml'
> > > > > > > as
> > > > > > > > these seem to be generic and would probably serve the purpo=
se
> here?
> > > > > > >
> > > > > > > Hm.. as the description says:
> > > > > > >
> > > > > > > 8<--------------------------------------------------
> > > > > > > gpios:
> > > > > > >    description: Array of one or more GPIO pins used to select=
 the
> > > > > > >    regulator voltage/current listed in "states".
> > > > > > > 8<--------------------------------------------------
> > > > > > >
> > > > > > > But we don't have a "states" property and we can't select bet=
ween
> > > > > > > voltage or current.
> > > > > >
> > > > > > Yes I think I was at cross purposes when I made this remark. Th=
e
> bindings
> > > there
> > > > > > describe the GPOs that are used to enable/disable and set
> voltage/current
> > > for
> > > > > > regulators and the supported voltage/current levels that can be
> configured
> > > in
> > > > > > this manner. What you're describing is the GPI for DA9061/2. If=
 you look
> at
> > > > > > GPIO handling in existing regulator drivers I believe they all =
deal with
> > > external
> > > > > > GPOs that are configured to enable/disable and set voltage/curr=
ent
> limits
> > > > > rather
> > > > > > than the GPI on the PMIC itself. That's why I'm thinking that t=
he
> > > configurations
> > > > > > you're doing here should actually be in a pinctrl or GPIO drive=
r.
> > > > >
> > > > > That's true, the common gpio bindings are from the view of the
> > > > > processor, e.g. which gpio must the processor drive to enable/swi=
tch the
> > > > > regualtor. So one reasone more to use a non-common binding.
> > > > >
> > > > > Please take a look on my other comment I made :) I don't use the
> > > > > gpio-alternative function. I use it as an input.
> > > >
> > > > I know in the datasheet this isn't marked as an alternate function =
specifically
> > > > but to me having regulator control by the chip's own GPI is an alte=
rnative
> > > > function for that GPIO pin, in the same way a specific pin can be u=
sed for
> > > > SYS_EN or Watchdog control. It's a dedicated purpose rather than be=
ing a
> > > normal
> > > > GPI.
> > >
> > > Nope, SYS_EN or Watchdog is a special/alternate function and not a
> > > normal input.
> >
> > Having spoken with our HW team there's essentially no real difference.
>
> So I don't have to configure the gpio to alternate to use it as SYS_EN?

Yes you do, but the effect is much the same as manually configuring the GPI=
O as
input, just that the IC does it for you. The regulator control features cou=
ld
well have been done in a similar manner. Guess that was a design choice.

>
> > >
> > > > See the following as an example of what I'm suggesting:
> > > >
> > > >
> > >
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/b=
indin
> > > gs/pinctrl/pinctrl-palmas.txt
> > > >
> > > > You could then pass the pinctrl information to the regulator driver=
 and use
> > > > that rather than having device specific bindings for this. That's a=
t least my
> > > > current interpretation of this anyway.
> > >
> > > For me pinctrl decides which function should be assigned to a pin. So=
 in
> > > our case this would be:
> > >   - alternate
> > >   - gpo
> > >   - gpi
> > >
> > > In our use-case it is a gpi..
> >
> > It's not being used as a normal GPI as such. It's being used to enable/=
disable
> > the regulator so I disagree.
>
> This one is used as voltage-selection. What is a "normal" GPI in your
> point of view?

With the voltage selection and enable/disable control the actual work of
handling the GPI state is all done internally in the IC. There is no contro=
l
required from SW other than setting of initial direction. For a normal GPI
I would expect SW to be involved in the handling of that GPI state, for exa=
mple
as part of a bit banging interface.

>
> > >
> > > An other reason why pinctrl seems not be the right solution is that t=
he
> > > regulator must be configured to use this gpi. This decision can't be
> > > made globally because each regulator can be configured differently.. =
For
> > > me its just a local gpio.
> >
> > You'd pass pinctrl information, via DT, to the regulator driver so it c=
an set
> > accordingly. At least that's my take here, unless I'm missing something=
. The
> > regulator driver would be the consumer and could set the regulator cont=
rol
> > accordingly.
>
> IMHO this is what I have done. I use the gpi so the regulator is the
> consumer. Since the gpi can be used by several regulators for voltage
> selection or enable/disable action this gpi is marked as shared. If I
> got you right than you would do something like for regulatorX.
>
>   pinctrl-node {
>
>   	gpio2 {
> 		func =3D "vsel";
> 	}
>   }
>
> But the gpi(o)2 can also be used to enable/disable a regulatorY if I
> understood the datasheet correctly. I other words:
>
>
>
>          +--> Alternate function
>       /
>   ---+   +--> GPI ----> Edge detection ---> more processing
>    |       |                |
>    |       |                +-----> Regulator control
>    |       |                          |
>    \__  __/ \__________  _______
>       \/               \/
>    pinctrl            gpio
>
> This is how I understood the pinctrl use-case. I configure the pin as
> gpio and then the regulator driver consume a gpio.

How I see it is that you configure the function through pinctrl as
'regulator_switch' or 'regulator_vsel' (or whatever name is deemed sensible=
 to
cover the two types of functionality) and then the pinctrl driver code woul=
d do
the work of requesting and configuring the relevant GPIO as input so it's n=
o
longer available for use as something else (basically what you do in the
regulator driver right now).

I believe you can have more than one consumer of a pinctrl pin so it could =
be
provided to both regulator X and Y to indicate that this is the chosen
functionality of that pin and so the regulator can then be marked as being
controlled by that pin. Using pinctrl also would mean you're using standard
bindings as well rather than something which is device specific.

>
> > At the end of the day I'm not the gatekeeper here so I think Mark's inp=
ut is
> > necessary as he will likely have a view on how this should be done. I a=
ppreciate
> > the work you've done here but I want to be sure we have a generic solut=
ion
> > as this would also apply to DA9063 and possibly other devices too.
>
> Why should this only apply to da9062 devices? IMHO this property can be
> used by any other dlg pmic as well if it is supported. Comments and sugge=
stions
> are welcome so no worries ;)

You're right. You can do the same for DA9063 and other devices potentially.=
 I
would just like to make sure we take the right/agreed approach. Potentially
this could be used in non-Dialog products as well which have similar
functionality.

As I say, Mark is really the gatekeeper so his input is also key in this.

>
> Regards,
>   Marco
>
> > Have added Mark to the 'To' in this e-mail thread so he might see it.
> > >
> > > Regards,
> > >   Marco
> > >
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > > >
> > > > >
> > > > > > I'd be interested in hearing Mark's view on this though as he h=
as far
> more
> > > > > > experience in this area than I do.
> > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > >   Marco
> > > > > > >
> > > > > > > > >  - rtc : This node defines settings required for the Real=
-Time Clock
> > > > > associated
> > > > > > > > >    with the DA9062. There are currently no entries in thi=
s binding,
> > > however
> > > > > > > > >    compatible =3D "dlg,da9062-rtc" should be added if a n=
ode is
> created.
> > > > > > > > > --
> > > > > > > > > 2.20.1
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Pengutronix e.K.                           |                 =
            |
> > > > > > > Industrial Linux Solutions                 | http://www.pengu=
tronix.de/  |
> > > > > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-=
206917-
> 0
> > > |
> > > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-=
206917-5555
> |
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
>
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
