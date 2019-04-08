Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BACC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Iy384OUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfDHHqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:46:07 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39699 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDHHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:46:06 -0400
X-IronPort-AV: E=Sophos;i="5.60,324,1549954800"; 
   d="scan'208";a="29843964"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Apr 2019 00:46:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 8 Apr 2019 00:46:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5dVVIBNWLKJqu/oNRkrxsHxOdUPuothdKfHj2OF/ak=;
 b=Iy384OUMIRDwBJr3/dv6naq1IhGWKjsonl33m8Nc/dqECu0XKbcFoxB5uzAkBrc/y+Lg01YXmZHn6B8/njhCj6/8g7jvZspnulyMxo4WpywsD+F8T1YN7yyM+RE/FBfRyFLEnirq+Y56w6Sy7acvv++qQs3tnx0S84Q2I1s1h2E=
Received: from BL0PR11MB3329.namprd11.prod.outlook.com (10.167.235.150) by
 BL0PR11MB3332.namprd11.prod.outlook.com (10.167.235.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Mon, 8 Apr 2019 07:46:03 +0000
Received: from BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336]) by BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336%2]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 07:46:03 +0000
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <Jisheng.Zhang@synaptics.com>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHV0yp6Fa7I5USr12hPuITf3qYx3ZMg
Date:   Mon, 8 Apr 2019 07:46:03 +0000
Message-ID: <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
References: <20190408140301.3dcbccdd@xhacker.debian>
In-Reply-To: <20190408140301.3dcbccdd@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RaghuramChary.Jallipalli@microchip.com; 
x-originating-ip: [118.185.82.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601cf235-cec3-4739-e8e0-08d6bbf64079
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BL0PR11MB3332;
x-ms-traffictypediagnostic: BL0PR11MB3332:
x-microsoft-antispam-prvs: <BL0PR11MB33326F7F0211F06BE07040899F2C0@BL0PR11MB3332.namprd11.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(51914003)(189003)(199004)(105586002)(2201001)(86362001)(66066001)(5660300002)(52536014)(76176011)(478600001)(6246003)(110136005)(26005)(68736007)(81166006)(8676002)(81156014)(8936002)(6506007)(99286004)(186003)(102836004)(4744005)(229853002)(305945005)(106356001)(97736004)(11346002)(33656002)(486006)(55016002)(74316002)(3846002)(7736002)(446003)(14444005)(256004)(2906002)(53936002)(316002)(71200400001)(6116002)(6436002)(72206003)(2501003)(476003)(25786009)(71190400001)(14454004)(9686003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3332;H:BL0PR11MB3329.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vzmyZvbQzhrT3+1bW9Pby4bGBLPs933FSuzwpoKd/fwrcVKnAdd2IeHw4ynAj9RRAmfNWEbsGmuZvzUWNRxhjjebXQREdt561f5V5Wt+C5chjz6yW07Tp6EYDPgcBUqrgbmb//vvR81iOchu18QQDE6aFFBg/9osmUYqFcVY8GKrdND/5JPgCSvUFFDGzz79LxIO2uQBpV7XTbHZXQoX0Tb9MrkD/t+n2R3QqcjCzZv76cyGXoAiZJhBH0l1sYylMmJCwL+zgQ88ydzcQWzBXi+0XjpWM1xMGGAn8TbQHim4+Kw9InAztqhCW2FeAp2Z2u/ZfguG9y3VLpuRcaXbb3hsrP0JUOVcdOl499cQ+0rsncxB167LIFXDTC730kh4RzHGxbDKbqNCC06b7/rWq/1YxT/XQIKf5ZHPsMIerpI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cf235-cec3-4739-e8e0-08d6bbf64079
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 07:46:03.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3332
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Per my understanding, the proper handling of PHY irq is to make use of
> PHY_IGNORE_INTERRUPT then call phy_mac_interrupt when
> INT_ENP_PHY_INT is triggered.
>=20

Hi Jisheng,
Thanks for the changes.
Is this warning specific to any linux version? Why do you think PHY irq dom=
ain handling is not proper? Maybe we can fix that rather removing complete =
IRQ domain code changes.=20
Also, Can you pls let us know how this changes fixed your warning.

Thanks
-Raghu

