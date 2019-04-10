Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE77217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="xF416QtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfDJMvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:51:00 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:42062 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728553AbfDJMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:50:59 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 34/21-24446-0B6EDAC5; Wed, 10 Apr 2019 12:50:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSaUwTYRDt1922C7K6FJCxETWNJopspWi0HiT
  +MJEfmhgNfxSDW1jbhrI03VYBNWI0koByKPFoPIAY5BAFYowUEAVEioDiSYTEqBQDKmqrgsar
  2y0e/9689zLzZjIEpnTKVQSbaWOtHGNWy4Nx4xLJUrpupDYp1p0frHvoPCPXDVy+odANl/VId
  a9Gf2Jr8YSqS5dkCY0TOYoEb8OcTdhWmYnTZ2TukBlbPQWYZXxaZmWdV56DioPzUDCBU1cwqO
  gvlwqFkiqSwr1TYwqxeI7gZH0floeCCDmlhXNv3yMBh1Ob4WXTL78Jo5oQ3HEdkglCGKUHR6d
  LIZpSoGS8UyriOJgo7vR7cGoB9La4/Y1IajuU1A/6eSW1B54+qfbjIGoduIae4wJGVBR8OlDj
  D4FRkfBs+Ly/J1AUXGi+h4k4AkZf/ZSJ/mTIbX2nEPkY6H06jESshooBh0zEUfDgfH6A3wjtH
  Q0Bvh9B7o/QPET4cDQ8qmREWgVd/bcDFjN878sLRJgNkx6nXLgDUEMy+FjxWC7ukgIfzvYGMs
  yB6qMvcNF0H4O2gW+BZWKgtMkjL0KLHP/s5vhHEvFiqCh7gzn89woF1+lhvBTh1Uint5oMRls
  6YzLT2thYWquNo7Url9PaZUs1TDat17B2ejfL22ithtnNa/is9BRzqoZjbQ3I90eplo7C62jk
  oqENzSKk6giSG6pNUk7XZ6RmGRnemGy1m1m+Dc0mCDWQIy99WqiVNbCZO01m3zNOyUCEqMPJJ
  LdPJnkLk86bDKLUjWjiZvmLs5gS5zI4VhVJJgo9KMFktHN/Wky99AMUpQojkUQiUYZYWGu6yf
  a/PoYiCaQOI9OEUSEmzvZn0pgvhNQXoiSmRghhY/5Kqhy0IvbERu+GebXkd695VU/EQhVdFn9
  hKL7P/jqtKqvJMFrUOLmLXG2ePlnomZvvid8Ul91NHG4erF/Qvr/57kxXsQK7ulc399jxgxf1
  E8duub2liVsm+W2DX91fnEfwll4m4kjYwnPXZjSuGC9YE+PsWn81N1tStqz7c4GdS7Es3zdfj
  fNGRhuNWXnmN7asQqbNAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-10.tower-288.messagelabs.com!1554900655!6698177!1
X-Originating-IP: [104.47.0.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 707 invoked from network); 10 Apr 2019 12:50:56 -0000
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.51)
  by server-10.tower-288.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 10 Apr 2019 12:50:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARq7vZQzs1Jg5IQEtipz162kXRL3OWZyUhUhg3eG2K8=;
 b=xF416QtHaLa5q+HE3JjoBsdbU5AcXY2kWQXQZrx2wSMfkKoH7OGAjUW8NVhMOqAKIe8PAx2C95TcGpGVw+rGJmqHm1fRaJJNI9CZ0w507OtE491UAvdEGh6RpGtH4TK9fq0f73ze6RKQztKrKz/doQdJobSaqf/Yl4NFuFWFxDU=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2830.EURPRD10.PROD.OUTLOOK.COM (20.178.204.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 12:50:53 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:50:53 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Topic: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Index: AQHU7kLaIKCJcCL1TUe/uVGGg60e3KY1U0Hw
Date:   Wed, 10 Apr 2019 12:50:53 +0000
Message-ID: <VI1PR10MB235286F9A7E4E1C32DD41139FE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554752326-13319-13-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586ea7f1-d95e-4686-07dc-08d6bdb32ac5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2830;
x-ms-traffictypediagnostic: VI1PR10MB2830:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB2830587608581043C5B65177F52E0@VI1PR10MB2830.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(97736004)(486006)(256004)(5660300002)(33656002)(71200400001)(6506007)(102836004)(229853002)(26005)(86362001)(6436002)(11346002)(25786009)(71190400001)(105586002)(53936002)(446003)(7696005)(66066001)(2906002)(7736002)(476003)(6246003)(68736007)(478600001)(52536014)(186003)(81166006)(107886003)(81156014)(55016002)(9686003)(110136005)(106356001)(8936002)(3846002)(6306002)(4326008)(316002)(74316002)(966005)(6116002)(76176011)(14454004)(54906003)(305945005)(99286004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2830;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3KNaaim/AbTeTNALI9TcyNz1QfZMblgjHoa0/gj25sGmtsqD7o5HIbFfjBAe7VmFY4AaXI1tKrlK6pImc2ZbF8rc+1BlGss+gAUEjxE0TFZlpoegOGE8yHSUOfoFOAFvDzLicXSsNxVNRrkb41/GjXO3/FIERdxfP2oW+bgfO7lHnATUl+4OT5TnIqwbQcoVFZ+QDvPR6ape8oOT8LB+eEtZCw2SQrF0up5ZsxZb3yR33vNZj+MHd7HWyqvb++9JCwyFYBAOEGrH4w4Dd/YIjxZ2d9P6UiGlOyaDWE9QR32B56qP+NcmWnUgFs+YXAUs8xl1q7agjm53foGN5/LvlnFrnJgnCf2aoaHpet+psmpjN5iWFdbwDXumiS1cNqLG8lgUvUaM/gx83tJqYu0w+FWAnTWGM+DSf5Zj9fMURv8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586ea7f1-d95e-4686-07dc-08d6bdb32ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:50:53.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 08 April 2019 20:39, Guenter Roeck:

> Subject: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of
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
> ---
>  drivers/watchdog/da9063_wdt.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.=
c
> index 384dca16af8b..06eb9070203c 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -188,17 +188,18 @@ static const struct watchdog_ops
> da9063_watchdog_ops =3D {
>=20
>  static int da9063_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct da9063 *da9063;
>  	struct watchdog_device *wdd;
>=20
> -	if (!pdev->dev.parent)
> +	if (!dev->parent)
>  		return -EINVAL;

None of my previous Acked e-mails in this patch set considered whether the
dev->parent was NULL. But this DA9063 driver does.

Logically, this is correct to check, but ... any thoughts?
Otherwise,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

