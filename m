Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35321783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="HDgtKHTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504180AbfIXJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:23:40 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:39369 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbfIXJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:23:39 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id B5/C4-25186-790E98D5; Tue, 24 Sep 2019 09:23:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSf0wTZxzGeXvX48CeOVoIL8QurigkjKu0M+7
  Msihzy5oFg9P9MU0UD3trO0tp2qKtugQ0zUB0NhFNVnGVTWysKAobGwUNlh+hq7DJjyF0BYyt
  G5Y5A04mG2zXH7Ltv8/zfZ73fZ+7fHFE6McycdZsYg06RivBklH1uoRXqbNT1bvzg7Pp9Jn7Q
  Yx2dA/wadeZNpSe/L0H0M+Gq3j0kLsOo5+4RxDaerM7cTOuaLMHEhXNrmpM8dOPHZji1GK+Yq
  75pW38XXyNrqTMvJev9j72Jup9K83OxgWsAtQKjoNkHJANCLx17Fc0JnpRuOB4iMREC4B/nny
  ORQRK9iGwaeBOYkQIybM82PX1aFwEAWwJt4PjIAnHSBqe7puKHkklPTw4YT8XFQjZBOCntZ5o
  SkQysMUxw4twKlkCF56EQIzlcPLUEhJhlFwLh8N+LMIElw/84o7OhaQO1j9fjM6TyDeg9c51N
  MKAFMOnlVeiGYRMh+NBR/R+SJLwYsf3SIzT4PSDJX4sz0Lv0XsgNs+D/aPBOEvg5+e74yyGg4
  6aOG+FPzi7QORjIBkCcOK+a/mwrWM0zjS8WGPlCuEcr4FLHktsrIc94yPxDtnw3kxVnFfBGz3
  zfBtYZ/9P7RjnwQvts1iMX4GX6sOIPforUqD3syB6AaAuQJcYNCq1qZTRaClZfj4lk8kp2UY5
  JZfJpMwhipGy5dRB1miiOHnQKDVaSvdplVIda2oG3J4p9Z1D3wKbfUbqARk4T5JG/N1dvVu4s
  qRMaVEzRnWxoVzLGj1gFY5LIPFlgPNSDKyKNX+o0XLb+sKGuECSSuyb5GzCqGdKjRpVzPoOUL
  ht+vwXiBDVlenYzHRiYyRERkLqct3yFS92fhCIM0UESEhIEAr0rKFUY/q//wik40AiIqYmuFs
  EGp1p+aVHXAkeVyJrS7SEifnXyqzgveaQ/2yRfJyN7/U/2EbVzNfzNyx2epILHfsP6DWCIacv
  pWgNfuDtTZ2qsRWtfUeusXVv3rTXfpWb23BMIH13dYG1MFviy6s73JfBX581V22/ZXPlBMayd
  Hhg9fz7GypvmP6SWNI6P/hmc5KKv8tJKMJH/dtP5NzuZ1eI3hkqbB7IaPKPjO+cG94SZP5oYI
  qd4pYigfh2KHyXMP+W6yu6PrBjz+PKbI1PSleE4NYjrxe3envFn5Dj23PWUx+JkonCKffV2cM
  nTta3Peu17m/0ut/rKrhy7erO9ooxJVP2dO08sL18WTPdPxhqbbxcdZe3J5jKnuYp3zp3yPyw
  qmCTWYIa1YwsFzEYmX8AOt2ZSG4EAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-25.tower-262.messagelabs.com!1569317013!119244!1
X-Originating-IP: [104.47.0.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4856 invoked from network); 24 Sep 2019 09:23:34 -0000
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.51)
  by server-25.tower-262.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Sep 2019 09:23:34 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwCGKuXuAHdLXIZnYFEmNsuSHCv/b9UD21NIoIgthaS6c9SmbJcFWouffU+9Tte1wv0dxF65xtgCn23PAEKz6bMTeeRPWPX8sVvZGY5gp2bHeFaD1LfbmBovQ12+hNJF98Z4CCiMiHn53xCkq2Nqdv20yqWnE06EI4HrXM2D+vR6KZzk3OXr3aYVmo4gbQa9Xp2nZeS2aw+SBQ6vmf8C0Ic23HvsQFYvAkxoxR2eVbUsoHk0b+IIA8Epb5b5zIpr2itOUxAHruU3hM18oliv3/fJFMMiXzfh9nYDAiw1+02c3wLEIyTjEzCaaXx6rFS2VvWMuubZvCpWrd2Bo7krWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47sgLku49VqwC7K2xFMGMscmOk7Z1I9kuK2h27aVksM=;
 b=RWqtsUYfyhNNVZwwRyrfau1DBYVBC20mBeF/IfU9Rv6lztKj8ynsaR0cNFUaB7krw2oCKK2A0AXzSpksoTdHmAAjVDJ7Kh1aPOScFpsOng18wWCwHRCjyX8RW1B56AXwj7EwfMfQd8er39JiA1zjJi0GWi+57bFEIukDsWU9tmuLs8YHGegHgsxSGRwH1fU6KEtS02IdPmhDInKYI2UleO015zpXIMHNuT0661yQ/cusZoA51Vj5Iqbu4f0KA+UpZi2Fto7kkDBP8ppp2cbiFP70JffKJZzyraWaeHL26+ZlCJQQ2QYgbDGXI0LifuEJbNzIMKHbjhOJP7vFgpdFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47sgLku49VqwC7K2xFMGMscmOk7Z1I9kuK2h27aVksM=;
 b=HDgtKHTFBSBrUMw1e/5xhx0eY/43gGv6UdV5mwys2YLSppAvKyVqzhjzfZ9ibVhCnSYJe+tAHZWtb9LVIgOlxtyfVmXUW3KFGtLSXQipxM/BIXPnxjqv6mLl3WHCjodp5DbVtgRmFbOpJDIcMeNzX9gJoLN3InmsZkghgrBETnI=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB0961.EURPRD10.PROD.OUTLOOK.COM (10.169.153.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 09:23:32 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.023; Tue, 24 Sep
 2019 09:23:32 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Index: AQHVbVV1957uISHJUEeJggkt0eobi6c6l9Dg
Date:   Tue, 24 Sep 2019 09:23:32 +0000
Message-ID: <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
In-Reply-To: <20190917124246.11732-3-m.felsch@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a31840-e8b9-4113-b31f-08d740d0de73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB0961;
x-ms-traffictypediagnostic: AM5PR1001MB0961:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB096150DCBEAFC7B22ECFEDF4A7840@AM5PR1001MB0961.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39850400004)(189003)(199004)(81156014)(81166006)(71190400001)(8676002)(4326008)(186003)(229853002)(64756008)(66946007)(66446008)(11346002)(54906003)(52536014)(446003)(66066001)(76176011)(8936002)(66556008)(110136005)(25786009)(26005)(76116006)(478600001)(316002)(14454004)(33656002)(486006)(66476007)(5660300002)(55016002)(7736002)(6246003)(476003)(2906002)(7696005)(53546011)(6116002)(6436002)(86362001)(6636002)(3846002)(102836004)(305945005)(256004)(9686003)(74316002)(55236004)(71200400001)(6506007)(2501003)(99286004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0961;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6H9tcJOvfaaKNqg6lTRWdpDDCgPLZWPzll045IvS8LI3NXJdN3DpLKOWwbiawu1gbd/Nw6b7uMruvkid32WiQFLZpsgzGGbK0FIkXrWzzLtqefozdEz+d3sKl9gV1SetV+qFt7qZjf4/oLYXbxcxBDv1F/5YtvssD/1UpYP0JaxBo53ArPJ6UbQFuH45tpgMi4PllSAHs2/0KfEeH9u0vQwd41+SsKYwzPZVI/404uBhsCFXTE26dtDJ5z+0/u+9eBnMCpRcPZ5hJ8pzZMjyJF+zf8M9QBuH2EV/lR8R6CXl/7C5nlR80QGtCf3rpxXqjioXNfvbfp8qkzlRmf1TOHKwLQOoNbK62SOnLKDKuSHOft3a5RW1tQ9BdVDfj9VFLeE6sPJe71iMebXZWNELckPjpzejhU/ZPmUoArvL9/U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a31840-e8b9-4113-b31f-08d740d0de73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:23:32.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naGxXCuJsrj8UVChb9XX6bP47P35syaVzGTKvlYtV5BiHTn39uxCAtT7NBxT83fTGlZ2auJ2P9V7Ky6td9ATNnI+bxHjPdrAtxfNE19j3/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2019 13:43, Marco Felsch wrote:

> Add the documentation which describe the voltage selection gpio support.
> This property can be applied to each subnode within the 'regulators'
> node so each regulator can be configured differently.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> b/Documentation/devicetree/bindings/mfd/da9062.txt
> index edca653a5777..9d9820d8177d 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -66,6 +66,15 @@ Sub-nodes:
>    details of individual regulator device can be found in:
>    Documentation/devicetree/bindings/regulator/regulator.txt
>=20
> +  Optional regulator device-specific properties:
> +  - dlg,vsel-sense-gpios : The GPIO reference which should be used by th=
e
> +    regulator to switch the voltage between active/suspend voltage setti=
ngs. If
> +    the signal is active the active-settings are applied else the suspen=
d
> +    settings are applied. Attention: Sharing the same gpio for other pur=
poses
> +    or across multiple regulators is possible but the gpio settings must=
 be the
> +    same. Also the gpio phandle must refer to to the dlg,da9062-gpio dev=
ice
> +    other gpios are not allowed and make no sense.
> +

Should we not use the binding names that are defined in 'gpio-regulator.yam=
l' as
these seem to be generic and would probably serve the purpose here?

>  - rtc : This node defines settings required for the Real-Time Clock asso=
ciated
>    with the DA9062. There are currently no entries in this binding, howev=
er
>    compatible =3D "dlg,da9062-rtc" should be added if a node is created.
> --
> 2.20.1

