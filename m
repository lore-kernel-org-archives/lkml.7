Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186F9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="nP5pGadf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfC0PDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:03:21 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:18397 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfC0PDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:03:20 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id 39/B1-27207-5B09B9C5; Wed, 27 Mar 2019 15:03:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSbUhTYRT23b27Xoc3rjPxtLJoEIS1tVnBEkr
  phy2wqD8FWdRVb9tgzrF7xVlEC4Myswws2oepkWZmDKRR1sJKo6VNRcvKQpEs8WMlqZUE0e7u
  LPvxwnPO85zznPNySEzeTihI1s6zNgtjVhIy3LghJl3lq3Qf1MwFknSXR0YJ3fDcM6Trf+Ahd
  L7xLxLdhe4dmVJ9S1MZof8w4Cf0n+u8uH6mZeUe/IDUZMkttB+RGh+035JaA6R91juPOZAv9h
  ySkTjtxeBeyImEQE5XSuBX7w9MDIYRtDhaJedQHEnQWrg29RUJeCm9EZpL3ZFyjJ5EcPNMGyE
  QifRWmCwtl4iibRAcnyFEnAaX3M5wARn2WwMV9WohTdGH4PzQ6VgBy2kHgvp7xQKOo7PAOVYT
  8UJ0Csyeuo0JGKOTYXC0JtIeaBpu+HswESfB+MffUlF/GM60hWLF/HoIvhlFIlZCw1uXVMQp0
  FdTHs3vAk/r1cj2QA8i6HpXFjVIheb7bUiYGWgzlL4+IKZXwPRPPyHqX0nBORiSigvkwXR1MG
  q8EpoqRnBR1IuBv7EjusF6qH34jRDxOmiom8Qq0VrXouVci2SuRTJX5MMS4IVzFK9FeBPS5dp
  MBiNfwJjMKq1Go9Jq01RpGuFp1MwxVZ6aLVIVsxyv0qqZYk7NlRTkmfPVFpZvQeGDyrd2Bu4j
  T6PhKVpGSpRJVNka90H5ktzC/BIjwxkP24rMLPcUrSBJJVA1F8Ncgo01sPajJnP4KhdoIOOVS
  6mzAk1xVqaAMxlEqhOpyMfXR6oxOW4ptLCKZOqxIKIFkbHI8rfFwm33oRRFIoViYmLk8VbWVm
  Di/+cnUDKJlInUFaFLvMnC/3WaCA8hCQ8xcTIyBM/8oxQO1Ln9+aash94tgYHf2xXdfmbPCY3
  uffb0hqbMu5V87tVPOYwjTvZyXQIa8qSGjn+zJHRVyzN6emaXf6/m3mW8p041WKv6d7YGy2x3
  +qe68b4x3+4U5XDG3mUzHQZTPS/L2bzqrP+Ja8JwpBwa0xW7u6rOu4OP9mUrVu+fn7876VHin
  JHRpmI2jvkDJz7PGNYDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-9.tower-302.messagelabs.com!1553698996!4871819!1
X-Originating-IP: [104.47.0.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 677 invoked from network); 27 Mar 2019 15:03:17 -0000
Received: from mail-he1eur01lp2058.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.58)
  by server-9.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 27 Mar 2019 15:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HnISMcNqOWt8Zb2++Zl2PwEXFvWUkhLa7dXO9NwtF8=;
 b=nP5pGadfPCGXV/6US6ekGDumxpe7fJkfbtrzdJXBWcdeBu5xXhvMbhprU6lvHt8rLdeJQlzU8u52sK1SoDMI18QsoFh8Cn5Gzx7UmgturzSJpSYhukNzVeJhr+C7mDUWuHs81ui2H4ryXqIsGjx+AYG2inarlqUDbqWHya0j268=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2605.EURPRD10.PROD.OUTLOOK.COM (20.178.125.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 15:03:13 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 15:03:13 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 1/4] mfd: da9063: convert headers to SPDX
Thread-Topic: [PATCH 1/4] mfd: da9063: convert headers to SPDX
Thread-Index: AQHU3aNa8c9bqcYF10iMnTaFY5m14qYfmyrA
Date:   Wed, 27 Mar 2019 15:03:13 +0000
Message-ID: <VI1PR10MB2352412A598838DFB6635B1CFE580@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b1abbf6-95a7-40cc-2b08-08d6b2c555d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2605;
x-ms-traffictypediagnostic: VI1PR10MB2605:
x-microsoft-antispam-prvs: <VI1PR10MB2605FA398E70D0B8C57DC9B7F5580@VI1PR10MB2605.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(229853002)(3846002)(5660300002)(6116002)(2906002)(97736004)(6436002)(52536014)(14454004)(478600001)(106356001)(86362001)(74316002)(305945005)(105586002)(33656002)(81166006)(81156014)(8936002)(7736002)(66066001)(68736007)(76176011)(8676002)(53936002)(107886003)(446003)(6246003)(54906003)(11346002)(26005)(476003)(7696005)(99286004)(25786009)(486006)(9686003)(14444005)(55016002)(256004)(4326008)(71190400001)(71200400001)(316002)(6506007)(186003)(53546011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2605;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Od/hIKOfaJhuaYK44geCchZqF8+CFxn40ki/EiA7t1l3yaG1bOPBbIEyjyypKEB3pRitQOYUHQdJDnyAwq2SU9k9XTktK1amKiWSHdwvWr5nIEMGeNhsl97OgnkFfNxWPL5vs/P0ASY316yFM3XbbrB4PHDr9SM7KhYQnDraFEOC7J7ZxYBbsCf9bHTGnBL9hPng69GZTORdAb4yCAf8mtc/k2VEh/sFnzCtyv1GRB1D6e8BnwlJz/LIKD2pr6+62WnGtPbCoCedn9ahAf8M74Q0VjaEhri5GW83BXO3sfYHcu25x/4akM1+OygWj1xBcgFt6yg69FD0Y3K+woKWZun/3cSQIR4DKgrrm4QOh2yzpJOCbsIq1mGTp2mx67UyyGyqG/+uZrnsOmiRBzc1+sK1khMTMiQ7DzP3ZBaPlCo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1abbf6-95a7-40cc-2b08-08d6b2c555d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 15:03:13.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

On 18 March 2019 15:57, Wolfram Sang wrote:
> Subject: [PATCH 1/4] mfd: da9063: convert headers to SPDX
>=20
> Covnert the headers of the source and include files to SPDX.
> And fix some typos in the descriptions ("interrupt" instead of "I2C").

[...]

> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> +// SPDX-License-Identifier: GPL-2.0+
> + * Device access for Dialog DA9063 modules

[...]

> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> -/* da9063-i2c.c: Interrupt support for Dialog DA9063
> +// SPDX-License-Identifier: GPL-2.0+
> +/* I2C support for Dialog DA9063

Thanks

[...]

> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Interrupt support for Dialog DA9063

[...]

> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/c=
ore.h
> +/* SPDX-License-Identifier: GPL-2.0+ */

[...]

> diff --git a/include/linux/mfd/da9063/registers.h
> +/* SPDX-License-Identifier: GPL-2.0+ */

Regards,
Steve
