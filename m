Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB332C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Brqc38Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfDJMMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:12:37 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:59454 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731739AbfDJMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:12:37 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 7E/20-24446-0BDDDAC5; Wed, 10 Apr 2019 12:12:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSe0hTcRT2t3vvdlve+jUVT0MLRi/Lu7xmsfy
  noAcSFBEVFUbd6c2ttqvtTnxEMaPIlMogjNbDrYfRfCQGZRpm9jSyMolKszT9R8t8FFZE2e7u
  MvvvO+f7zvnOORya0N1S62kh2yk4RN5mUGtJy3wmka3qqEiO8xRHmVprz6hNryvrNaYe7xOVq
  bv3N7GUTLpSXk4l3fzm0iR9qZ62lthCWUVzevZ2yvLj6XUq4wqV3Vl4XO1CT8gCpKVJfJWAgq
  4htRzo8DEVHL5WTCjBewSdXd3+YAKtxhyc+zSAZByO18GHulGNLCJwHYKHTQcomQjDZvhRW69
  RRClwMn+/SsHx4CupDmASzwRfxUigEYO3QnNjcaBWh/fAaG8+KeMJeDm0eEYCxghHw9e8sgAm
  cCS09ZQE+gDGcPHWM0LBEdDb/ZtS9Nvg0O1+jZKPheZXPUjBBih97aYUHA0vSgqD+dVwtzo/c
  AvALQhKPW1B0VwY6X8WNNPDo5b7wbwN6m+OBo2j4PtwrVopHqCgebCJULZJgcGzzcEppoHvSF
  fQ4TkBne8ek8o6seCpG1YXoRj3uO3c4ygFz4NS70fCHbjYFGg61UN6EOlDJrPDmmZx2nmrjeX
  i4liOi2e5xYtYbmGCkc9lzUYhk80SJCfLGfksySjl2FNsqUZRcFYj/yelZtxz16CfBWmNaCqt
  MkQw4tuKZN0kc3pqjoWXLNscmTZBakRRNG0AZrbMTXEIaUL2DqvN/45/aaBDDeHMHJlmpAzeL
  lnTFOoxYumG811nCR0ppouCPpK50+4XYVlkyRTHWvx96hcoWh/GoJCQEF1ohuCwW53/830okk
  aGMMYgW4VaReeYU59/CJV/iBOxZfIQTv4fpXehyYk1XrHgXPsSrmio0nt0V9Ug+hVX1tqw3dW
  x+XL4xBvvUUxdxwzdG3Puo5jVo607bafzhpO8CTOWtaw6vCryUlj8omE7a6Lip7oW+LSbymrN
  uREbdWbtvrxZzr0bDqVLydq+9UPsA+HMwe7NNevfRPWtmP7SPv0zvrBm5e7C8o4PBlKy8Nxcw
  iHxfwCRENwWzwMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-14.tower-288.messagelabs.com!1554898351!6682592!1
X-Originating-IP: [104.47.13.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13234 invoked from network); 10 Apr 2019 12:12:32 -0000
Received: from mail-he1eur04lp2058.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.58)
  by server-14.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 10 Apr 2019 12:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuyuZYDIWRdxz0QKqDMCWDCgILpHzQkceD3thgOTOZo=;
 b=Brqc38YoV47Yq1amlOthKFiFcp/TgCXxMXVEkhzWf7prZ6Sq2IgwWdCxH8VKKX3gDfOZqjlpv7Rc4r8gB254WaY8WsJykDumO1IE5c3jPCdSh3Moy5w7z0UUTzsfcFyRH3Fw2L0NDdbLsgd6KUblBZszzGvMhm/UohNzTOExTXE=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 12:12:30 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:12:30 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 09/22] watchdog: da9052_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Topic: [PATCH 09/22] watchdog: da9052_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Index: AQHU7kLYGYnCzeI8mkWLQp1B3YRAQ6Y1EZ6Q
Date:   Wed, 10 Apr 2019 12:12:30 +0000
Message-ID: <VI1PR10MB2352139A80694DDC11F8FEA1FE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554752326-13319-10-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f66248cd-b799-4ddd-d0ca-08d6bdadce00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB1965;
x-ms-traffictypediagnostic: VI1PR10MB1965:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB1965CF7315ABEA1AE81A953DF52E0@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(7696005)(53546011)(25786009)(33656002)(966005)(54906003)(478600001)(4744005)(486006)(110136005)(316002)(99286004)(11346002)(446003)(4326008)(6436002)(74316002)(52536014)(476003)(229853002)(53936002)(2906002)(305945005)(256004)(7736002)(107886003)(71200400001)(71190400001)(8676002)(8936002)(76176011)(105586002)(9686003)(106356001)(186003)(81156014)(81166006)(6306002)(26005)(3846002)(55016002)(5660300002)(86362001)(6116002)(66066001)(68736007)(14454004)(97736004)(102836004)(6506007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1965;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ydKVbXwqVWsGjRlk3NMH8R2/K4pLcaS/Kh8oi2BKuYcJxTHJcIMg2ueD4gJXicsII1Nz4OVsqF/gGUR1E5+uudw4U0ElKzW06iTs9M81q0Rh74PA9D/1fxd+4wWZKhedGolsEMp8m5YUCz8pWn2ULVRk5NdEewG/A47v/eSliPa2eQEuk+hB8Ll0mknGdf/kPMsYajymfnvpuZX2ArVY6TNZ8SqTqybHoKLd0sJV/sZP5keo7+xzKKopQ2X//Wr6EyzBJBDtqh+PTk51mskcOcaifEhh5bOvICkOGWOy1KJpnWx+TltkX/K+znaBGAet1TSLNA8MOfsYe6VA/ktrdQ4vRbNc7qRUs4ZpuZgRCZak7wICcerXPKNAx0CFPIstt/xRDERiWLnmMuGKGLh8UUaR4bBKvrjH+/gREte+skA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66248cd-b799-4ddd-d0ca-08d6bdadce00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:12:30.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 April 2019 20:39, Guenter Roeck wrote:

> Subject: [PATCH 09/22] watchdog: da9052_wdt: Use 'dev' instead of
> dereferencing it repeatedly
>=20
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
>=20
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>=20
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Thanks!
Regards,
Steve
