Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A93206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Czt9R0Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfDPKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:21:18 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:33084 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfDPKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:21:18 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id B2/47-19007-A9CA5BC5; Tue, 16 Apr 2019 10:21:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG/XbOjkfxyOem+SoadLLo4pazCwu
  igrDsD0WEIkKrs3naGcxp2yyNCiPpYqVRSTYtNcpqmpU1k7yFWKE1KzOMLljLstTuQRB2Ocez
  zP77fe/zPN/7vvDShOoqFUnzuQ7eZuUsLBVICnP8Fmqcte60uN6n0/UPr5dTeve7Dwr947pWf
  31R94qlZOKbqotk4tf6ySmKtUqz1ZCVu0EpdD6vp7JvUrnXS3+gfNSqLESBNIkvElB2p56SHi
  pcpIADu/YR8qMfgffKoGgLoCmsg5MjH5HEoXgL7B2tGYsT+CyC2pI+QhLUOBkuDN7ymVLgYH8
  bIXM8vM2/O1Yn8TToLhsWwzTN4HS49NsolVU4Aa4Wuv0lDsDLYXR351gU4Wj4trNmjAkcDk8G
  KhQSA8ZwuvkeIXMYvHv1Syn718Oetvf+cj0WPH0DSGYWqh87lTJHQ0/FfiSNADgJXI1qaRXAD
  xCUHCvwZWeB6+hPH1vgc/GQr1cUXBtpoOTAMyV4nhQQ8gJG+HTC4wtMBtfBl6Rsuk9AbcteSt
  4gFiqbvvh4NlRXDROH0AznhOWcE2zOCTaJGRwCnccHyEpEupDeYDObBEcmZ7ZodHFxGp1urma
  eJj5ey23VGLR8jsbIWx02ThS13Ba71p6XabRkaK28ox6JF5SxiZzUiO6fMbWjCFrBhjHHzrvT
  VMGGrIw8gbML6205Ft7ejqJomgVmXY2ohdh4E5+70WwRz/CvDHQQG8okSTJjz+Yy7WaTLHUhD
  X3j1MsThIq0Zln5yHCm2SWasGQScqzjX/w95h4UHalmkJ+fnyoom7dlmh3/60MonEasmtkstQ
  oyWx3jnYbEIRTiEEdja6QhHNw/KTIfGV8nLLasTP4V3kEeYWPmTHWwwbNTSjtmcp2B3gWrvPP
  KIxIrDOWn9pc+2pY6uCgv+Yyp38NV997yCA3p7inndoTpV0e1Hy7uWuaN3k4mB6cumbKse2tW
  1IuEist3W5vU31aktixOXNclVH9PGbg9GlNQFzLfNSOvZPdmqopKG17jZUm7wOlmETY79wfIg
  0tkxwMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-13.tower-246.messagelabs.com!1555410073!211227!1
X-Originating-IP: [104.47.0.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26331 invoked from network); 16 Apr 2019 10:21:14 -0000
Received: from mail-he1eur01lp2057.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.57)
  by server-13.tower-246.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 16 Apr 2019 10:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po0B8nww2k/8D9Mv956Vct/2FTBKJGRwQX0tRMMuZaE=;
 b=Czt9R0WaMVZk6rk/enhYcFCfSId7zzkZoqyFoIzS9Cy9L3+w5Dq/cY2gpilz9OunI3Y9E57RcGiAV2hM88Nx65nYPhWVVVWLLl3HRtgzZZVqNYW34JyTk+QOMwQA0dAc5qGo/zutYKjj5QByrmDahFakOJWHD8W9kdFrGGG4oi4=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2174.EURPRD10.PROD.OUTLOOK.COM (20.177.60.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Tue, 16 Apr 2019 10:21:09 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1813.011; Tue, 16 Apr 2019
 10:21:09 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Thread-Topic: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value,
 too
Thread-Index: AQHU8rKQiJBjLGoJgEygrdEbYLd/faY+hb0w
Date:   Tue, 16 Apr 2019 10:21:09 +0000
Message-ID: <VI1PR10MB2352FEE39015BEA512B1FE61FE240@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9adb2a3-ed44-4580-7055-08d6c2553e68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2174;
x-ms-traffictypediagnostic: VI1PR10MB2174:
x-microsoft-antispam-prvs: <VI1PR10MB21744A21F95D9486CF5606C0F5240@VI1PR10MB2174.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(53546011)(5660300002)(6246003)(229853002)(33656002)(105586002)(14454004)(54906003)(52536014)(4326008)(110136005)(478600001)(106356001)(25786009)(2906002)(6506007)(316002)(2501003)(66066001)(97736004)(6116002)(3846002)(305945005)(53936002)(74316002)(9686003)(55016002)(7736002)(81156014)(26005)(102836004)(186003)(8936002)(11346002)(446003)(8676002)(81166006)(476003)(486006)(4744005)(99286004)(68736007)(71200400001)(86362001)(256004)(6436002)(7696005)(71190400001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2174;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ixG0ja4vr6bTm2fvGEj0p6F5liW0ZFYfbR7DdY+pUZqXAIzNHRRoVyhQO92d7320xXlj1J7OT+Er/DraImYfu94igFzfHGsDS88oXyyyWeevyIQdgLB1O1TYSVY9pz9Mq84GMHJtZ25EGdkpi7EMlyzqnO7R0mqknWrdzOfYIM20N4/kZd6ZEuX1YPoHxFBQQKpMWf5isWaK6PtgrdEREgJVbHxxM/r2xYpX4D+aoaVTSUhGWoI46afRVmU6z/ClctpP0FSeiGf6NPzJJSzYU4/bHITfwhvLJGNzT+pe/EHfYaAQI1LRZKWfO3V//c3N8U6QDcxJG2xoPTSFtqKXbYDKLVERPJM12UvfTPNALTDCgCXlshAfMSD3/Haedt9m8JTi6XhWuAs6tInYr72GDHhb5MRL2kVuVD313VWfSgk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9adb2a3-ed44-4580-7055-08d6c2553e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 10:21:09.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 April 2019 12:10, Wolfram Sang wrote:

> Subject: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, to=
o
>=20
> And make sure the final obtained value gets properly scaled. Remove two
> empty lines to group the initialization blocks while we are here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Tested with a Renesas Lager board (R-Car H2, DA9063AD), checking the init=
ial
> timeout value via sysfs. I didn't test handover from bootloader because m=
y
> bootloader neither supports WDT or I2C out of the box.

Tested on git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-stagin=
g.git
* watchdog-next                 6829e6ef3f22 [origin/watchdog-next] watchdo=
g: pnx4008: readout watchdog state

Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
