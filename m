Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522E20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfDOTjO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:39:14 -0400
Received: from mail-eopbgr800109.outbound.protection.outlook.com ([40.107.80.109]:42367
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728251AbfDOTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:39:13 -0400
Received: from CO2PR01MB2168.prod.exchangelabs.com (10.166.200.9) by
 CO2PR01MB2165.prod.exchangelabs.com (10.166.92.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 19:39:09 +0000
Received: from CO2PR01MB2168.prod.exchangelabs.com
 ([fe80::f12d:c6a7:1b65:a199]) by CO2PR01MB2168.prod.exchangelabs.com
 ([fe80::f12d:c6a7:1b65:a199%4]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 19:39:09 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Thread-Topic: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Thread-Index: AQHU88FusCfPFHtDSUOfLafK2JkH0qY9nThg
Date:   Mon, 15 Apr 2019 19:39:09 +0000
Message-ID: <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415192734.935387-2-arnd@arndb.de>
In-Reply-To: <20190415192734.935387-2-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=HartleyS@visionengravers.com; 
x-originating-ip: [63.230.248.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1190a184-1a94-4fc7-7d4f-08d6c1da07d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600140)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:CO2PR01MB2165;
x-ms-traffictypediagnostic: CO2PR01MB2165:
x-microsoft-antispam-prvs: <CO2PR01MB2165B7B2B933EA803094DC0ED02B0@CO2PR01MB2165.prod.exchangelabs.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(136003)(366004)(346002)(199004)(189003)(66066001)(55016002)(6506007)(186003)(110136005)(53936002)(54906003)(72206003)(476003)(316002)(14454004)(26005)(53546011)(7696005)(6436002)(102836004)(106356001)(105586002)(486006)(11346002)(508600001)(74316002)(3846002)(68736007)(4326008)(86362001)(33656002)(446003)(99286004)(97736004)(81166006)(9686003)(5660300002)(2906002)(25786009)(80792005)(8676002)(7736002)(6246003)(76176011)(81156014)(229853002)(256004)(52536014)(8936002)(71200400001)(71190400001)(6116002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR01MB2165;H:CO2PR01MB2168.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: visionengravers.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gvx2uSn7Qp80gdi+eP/oXinKaldYnO7vGuJYQKxiA3q1f8AoPjEn5WSnxhNOWIjbEg1zjDM52uAD881r3M2q8PD+bcAKLJItk0KtznhFKaQD63Q6qXHmUg0MB5acSKDFihkyN7iJEMZV+e82VBJtg4Fo/9uh3On+DchuORq/t4HMFSE7LwKMsF8up2kIcCtLHsT3rzPAt9bDrRv0rZQHKRtEAXcSzsM/mfwvg4RUwfwxTAkm1Uxiy1fleAjsIIXGhM0NSpiZIajus7TV+U607qz/Sjdxgdg+LUXLCXttn/HjLkNK+SKnSat2GaX7jN4eu1rUxkFNuAQmEK2YjePtMrEIA3PQ1wuZJWFQLzSQnt8X3O1uDwXCT5B+C2iIeKlejY7kwlMB6Sk+sn8VtklsTOmEn9pjCidDNiyUJKHpc24=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1190a184-1a94-4fc7-7d4f-08d6c1da07d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 19:39:09.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 15, 2019 12:25 PM, Arnd Bergmann wrote:
> We can communicate the clock rate using platform data rather than setting a
> flag to use a particular value in the driver, which is cleaner and avoids the dependency.
>
> No platform in the kernel currently defines the ep93xx keypad device structure, so this
> is a rather pointless excercise.  Any out of tree users are probably dead now, but if not,
>  they have to change their platform code to match the new platform_data structure.

<snip>

> diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
> index 0e36818e3680..3054fced8509 100644
> --- a/include/linux/platform_data/keypad-ep93xx.h
> +++ b/include/linux/platform_data/keypad-ep93xx.h
> @@ -9,8 +9,7 @@ struct matrix_keymap_data;
>  #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
>  #define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
>  #define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
> -#define EP93XX_KEYPAD_KDIV		(1<<4)	/* 1/4 clock or 1/16 clock */
> -#define EP93XX_KEYPAD_AUTOREPEAT	(1<<5)	/* enable key autorepeat */
> +#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */

You have re-defined the keypad register bits here.

The KDIV bit changes the clock rate. The AUTOREPEAT bit enables key autorepeat.

Hartley

