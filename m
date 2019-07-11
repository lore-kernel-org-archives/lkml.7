Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2749C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA07921019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="L7hZOuj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfGKMgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:36:48 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:50243 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbfGKMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:36:48 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 2C/80-10831-C5D272D5; Thu, 11 Jul 2019 12:36:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRWlGSWpSXmKPExsWSoc9hrhujqx5
  rcGYSp8WROV+ZLb5d6WCyuLxrDpvF5Ymd7A4sHjtn3WX3aPtZ5vF5k1wAcxRrZl5SfkUCa8bk
  ZfcYCz4wVew9e4mpgXEHUxcjFwejwFJmiXW7b7JBOMdYJD5vncTYxcgJ5KxnlGiYIASSYBE4w
  SzR8+0jWIuQwEQmia0ntzKBVAkJ3GeUOPi1CsRmEzCUmPfmPSNIkYjAXqDuk8/AipgFdCWar7
  9lB7GFBYIlXj04B2aLCIRILNnxlQ3CNpKYOPEjkM0BtE5V4twEHpAwr0CsxJ2Vl1khdllI7H+
  8GKycU8BSYvqdj0wQl8pKfGlczQyxSlzi1pP5YHEJAQGJJXvOM0PYohIvH/9jhaiPl2jfD3GO
  hICOxNnrTxghbCWJZTdmsULYshKX5ndDxX0lGv62MoP8JSFwi1GiZeNpNoiElsS8ZzdZIOwci
  Sdz/0MtVpN4P3Er1CAZiatXT7NCNH9nlbizdiELxDfJEh/mnmWfwKg7C8nhELaOxILdn9ggbG
  2JZQtfM88CB4agxMmZT1gWMLKsYrRIKspMzyjJTczM0TU0MNA1NDTSNbQ0BdIGeolVuol6qaW
  65anFJbqGeonlxXrFlbnJOSl6eaklmxiB6Sil4HDeDsbuI6/1DjFKcjApifJO5lOPFeJLyk+p
  zEgszogvKs1JLT7EKMPBoSTBe1obKCdYlJqeWpGWmQNMjTBpCQ4eJRHe7SBp3uKCxNzizHSI1
  ClGY44JL+cuYuZYsHXJImYhlrz8vFQpcd5YkFIBkNKM0jy4QbCUfYlRVkqYl5GBgUGIpyC1KD
  ezBFX+FaM4B6OSMK8WyBSezLwSuH2vgE5hAjpF1U8N5JSSRISUVAOTTMjcxQu7pj58dDExwaK
  DN1B30sXLxu/M/65Kl3xT3MKX28Q1c933500N7xrXLMo4cUhWlenN1gAbrkOXOFVdVjAqpUZv
  X+i9ac3eU7xbv8687Xqk9iTr+4CFLr9nqhlVPv354vv3X28tLKw812p7HPv7N//2pF88n98X9
  mx4fCQvfPnZj2//JUt4/9H/+mPp27ncug188060bIlZ7HV4b+XdbV+TfgRWsTLN93z66dheGd
  5pU449Vvy4I2uT4Y36E3UnLy/Z93TSwo6SnfdDn1bVfvhnOVfnpEDoYqnHmksPsafW7/qi/pX
  pVayuesvBlS02Pzm940I/zlJj6FTNM112weoei0Edg2PjZqHXl6qUWIozEg21mIuKEwGdZ46t
  VAQAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-11.tower-262.messagelabs.com!1562848603!797513!1
X-Originating-IP: [104.47.8.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10951 invoked from network); 11 Jul 2019 12:36:44 -0000
Received: from mail-am5eur03lp2055.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.55)
  by server-11.tower-262.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 11 Jul 2019 12:36:44 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBmOJqmioIf0jZj7kqRB1RliX7Qr/kcL98Uc3h04c6x3r4caUPxxD/UZcwQoFo8mVbJtN8sowWfgJxJqOf8ihc4/kO8h8WdVmntpsaHi1s75djgkedWOH63njxlOZSdh/1n3LcPl98qMUaRjNuh7TonHvQ1SGDobs6ig8yVnYluIlTaXxa8nq8KbX3VEbPGzfdCV32jnedIhEjRnfgFr8ID+JYLd0ZV7vL8SbWMg1I8+42pbzMjsUwdDTb8+tHpf5PktPFYG952yKmWLHLMKqrlrLXf5IKfxYYj+5JkVcqnjn+uR/n8RceZOtfLw13yipzT0whsPvb6hcxcCiL7yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25Nwln2AYkOFuw7mN9ZjvPvjzDLEt1wI6Rod7Hk72vk=;
 b=KZG+96C2qxAqbncOz2QoH+KmdZY1NBL+ikuJlMR0EL8PLNjNC0vJ/01FayuG4V6VQL78YhyH33S4gY5o0QnTradrI1QPi8efvryMcoCGR/4XS1wVfzVDo1ahzkpzcQ6dUOMZwotrf8zjKY2tWijtKmPURXzkVTtjxiCZFfl3yRowh7KQLHa7uKI9Xx9tpLNxYiUX/GNnnPFR44g5CFsO8QSXGhb41SSvRrzOIiL2bKEi5clUSNtlBVqGSAGWwgjcGq9h4k7HnEiZX0JFIfFTff/UbEEAKgEGkakpz7wUJsdVekWxRJBQRi94NP5X7n6ol9T+ejL5ZcQ5/Ey899n+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=diasemi.com;dmarc=pass action=none
 header.from=diasemi.com;dkim=pass header.d=diasemi.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25Nwln2AYkOFuw7mN9ZjvPvjzDLEt1wI6Rod7Hk72vk=;
 b=L7hZOuj1XaYNbC198Qo0OZ20zJbre+cyS2ufgFq3naWWVn+fMKdaVKSS/iGkEhS+fV9GhGcuazm536dyY29CRs5LOtqSjokZxdL+QFfzFNC9uLpOUjVhjnv+KqsbNYoHH6WZFF64Lbq/1u2JfhZbNVNXavuzh3EvbQ1sBGjVvWI=
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (20.177.113.222) by
 AM6PR10MB1863.EURPRD10.PROD.OUTLOOK.COM (52.134.117.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 12:36:41 +0000
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e011:a77f:4065:5798]) by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e011:a77f:4065:5798%3]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 12:36:41 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Steve Twiss <stwiss.opensource@gmail.com>
Subject: RE: [PATCH] regulator: da9062: Simplify the code iterating all
 regulators
Thread-Topic: [PATCH] regulator: da9062: Simplify the code iterating all
 regulators
Thread-Index: AQHVN95zzQdlpccrM0mDm7p2Z1SZ96bFU4nA
Date:   Thu, 11 Jul 2019 12:36:41 +0000
Message-ID: <AM6PR10MB2181A2D00DD25C57073DB5E9FEF30@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
References: <20190711114712.31313-1-axel.lin@ingics.com>
In-Reply-To: <20190711114712.31313-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35054b0c-d209-4271-3716-08d705fc6d03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB1863;
x-ms-traffictypediagnostic: AM6PR10MB1863:
x-microsoft-antispam-prvs: <AM6PR10MB18637D224209C405BF6988AAF5F30@AM6PR10MB1863.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(199004)(189003)(256004)(316002)(4744005)(110136005)(186003)(99286004)(8936002)(11346002)(76116006)(86362001)(486006)(26005)(476003)(446003)(71190400001)(71200400001)(76176011)(74316002)(66556008)(478600001)(66476007)(14454004)(66446008)(53546011)(6506007)(68736007)(64756008)(66946007)(6116002)(3846002)(7696005)(305945005)(4326008)(6246003)(53936002)(55016002)(5660300002)(2906002)(81156014)(81166006)(52536014)(8676002)(7736002)(66066001)(2501003)(6436002)(9686003)(102836004)(25786009)(229853002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB1863;H:AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jt2SZC4ljbXSRidCZ+pUIoMHLsEUvLoo7TIX7JjYSkqLazoOnidmpqy5QcS3f6wAcm6AR3zeElD0A3nU0os6rvtfJepiUbWzOzHI2KoxQg7xatNzta45e/6n6FOVjEecE8pLebrItdCjBKWFvgWd4pV9toioYlq5iGzxjDCHuf0E8DkQE4U1WVjYmeYgAoweCKp+Ql4Jpt16QwTEwEbDY6De0kJB3AzulHa+vmqvpBcK0IvxyUrhogiWqq0Ksw1pUbX5l31CtPiLreV5PRwINDdcbi12iBtmyrybMHX4utZuhLVU0rBy2n/caoS3EMemMXcMnTvkCdtj3JhfuCDCIL6XTs+h6fgpsfoumN3VboWSW2beSvWo4LcO/KDauPZCXzeo2xMyod1OtBMwnN9L/TNoBdwvchFvc28WRz6V0Mg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35054b0c-d209-4271-3716-08d705fc6d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 12:36:41.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephen.twiss@diasemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2019 12:47, Axel Lin wrote:

> To: Steve Twiss; Support Opensource; Liam Girdwood; linux-kernel@vger.ker=
nel.org
> Cc: Axel Lin
> Subject: [PATCH] regulator: da9062: Simplify the code iterating all regul=
ators
>=20
> It's more straightforward to use for statement here.

Thanks Axel,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
